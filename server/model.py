import pandas as pd
from sklearn.preprocessing import StandardScaler

df = pd.read_csv("../notebooks/daily_menus.csv")


scaler = StandardScaler()
prep_data = scaler.fit_transform(df.iloc[:, 1:5].to_numpy())


from sklearn.neighbors import NearestNeighbors

neigh = NearestNeighbors(metric="cosine", algorithm="brute")
neigh.fit(prep_data)


from sklearn.pipeline import Pipeline
from sklearn.preprocessing import FunctionTransformer

transformer = FunctionTransformer(neigh.kneighbors, kw_args={"return_distance": False})
pipeline = Pipeline([("std_scaler", scaler), ("NN", transformer)])


params = {"n_neighbors": 5, "return_distance": False}
pipeline.get_params()
pipeline.set_params(NN__kw_args=params)


df.iloc[pipeline.transform([[1800, 154, 60, 23]])[0]]
