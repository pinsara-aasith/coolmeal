from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import NearestNeighbors
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import FunctionTransformer
import pickle
from sklearn.model_selection import train_test_split
import requests
import pandas as pd

weights = {
    "Price": 0.5,
    "Total Energy(Kcal)": 2,
    "Total Protein(g)": 2.2,
    "Total fat(g)": 0.5,
    "Total Carbohydrates(g)": 0.5,
    "Total Magnesium(mg)": 0.05,
    "Total Sodium(mg)": 0.05,
    "Total Potassium(mg)": 0.05,
    "Total Saturated Fatty Acids(mg)": 0.2,
    "Total Monounsaturated Fatty Acids(mg)": 0.05,
    "Total Polyunsaturated Fatty Acids(mg)": 0.1,
    "Total Free sugar(g)": 0.5,
    "Total Starch(g)": 0.1,
}


def apply_weights(X, columns=[]):
    X = pd.DataFrame(X, columns=columns)
    for feature, weight in weights.items():
        if feature in columns:
            X[feature] *= weight
    return X


def train_knn_model(
    n_neighbors=8,
    metric="cosine",
    algorithm="brute",
    model_filename="ml_model.pkl",
):
    """
    Trains a K-Nearest Neighbors model, saves it as a pickle file, and returns the pipeline.

    :param data_path: Path to the CSV file containing the data
    :param n_neighbors: Number of neighbors to use for KNN
    :param metric: Distance metric to use (default is 'cosine')
    :param algorithm: Algorithm to compute the nearest neighbors (default is 'brute')
    :param model_filename: Name of the file where the model will be saved
    :return: Trained pipeline object
    """

    # Load the data
    df_final = pd.read_csv("./FinalPermutations.csv")
    columns = list(weights.keys())

    df_final["Meal_Plan"] = df_final.apply(
        lambda x: f'{x["Breakfast"]} / {x["Lunch"]} / {x["Dinner"]}', axis=1
    )

    X = df_final[columns]
    y = df_final["Meal_Plan"]

    scaler = StandardScaler()
    prep_data = scaler.fit_transform(df_final[columns].to_numpy())
    prep_data = apply_weights(prep_data, columns=columns)
    weight_transformer = FunctionTransformer(
        apply_weights, validate=False, kw_args={"columns": columns}
    )

    neigh = NearestNeighbors(
        metric=metric, algorithm=algorithm, n_neighbors=n_neighbors
    )
    neigh.fit(prep_data)

    nn_transformer = FunctionTransformer(
        neigh.kneighbors, kw_args={"return_distance": False}
    )

    pipeline = Pipeline(
        steps=[
            ("std_scaler", scaler),
            ("weighting", weight_transformer),
            ("NN", nn_transformer),
        ]
    )
    print("pipeline created successfully... ")

    # Save the pipeline to a pickle file
    with open(model_filename, "wb") as f:
        pickle.dump(pipeline, f)
    print("model saved successfully --------------------- ")

    return pipeline


def predict_knn(model_filename="kmm_model.pkl", input_data=[]):
    """
    Loads a KNN model from a pickle file and makes predictions on the input data.

    :param model_filename: Name of the file where the model is saved
    :param input_data: A list of lists or 2D array containing the input data for prediction
    :return: Indices of the nearest neighbors
    """

    # Load the model from the pickle file
    with open(model_filename, "rb") as f:
        pipeline = pickle.load(f)

    # Transform the input data using the pipeline and return predictions
    return pipeline.transform(input_data)
