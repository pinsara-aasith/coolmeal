import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import NearestNeighbors
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import FunctionTransformer
import pickle


def train_knn_model(
    n_neighbors=5,
    metric="cosine",
    algorithm="brute",
    model_filename="knn_model.pkl",
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
    df = pd.read_csv("./final_meal_combinations_dataset.csv")

    # Standarize the nutrient data
    scaler = StandardScaler()
    prep_data = scaler.fit_transform(df.iloc[:, 4:].to_numpy())

    # Initialize KNN model
    neigh = NearestNeighbors(
        metric=metric, algorithm=algorithm, n_neighbors=n_neighbors
    )
    neigh.fit(prep_data)

    # Create a transformer for KNN
    transformer = FunctionTransformer(
        neigh.kneighbors, kw_args={"return_distance": False}
    )

    # Create the pipeline
    pipeline = Pipeline([("std_scaler", scaler), ("NN", transformer)])

    # Save the pipeline to a pickle file
    with open(model_filename, "wb") as f:
        pickle.dump(pipeline, f)

    return pipeline


def predict_knn(model_filename, input_data):
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
