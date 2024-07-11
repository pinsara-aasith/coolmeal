import re
import pandas as pd
from rapidfuzz import process, fuzz

pd.options.mode.copy_on_write = True

def read_and_retrieve_only_latest_prices(df):
    df["date"] = pd.to_datetime(df["date"], errors="coerce", format="%Y-%m-%d")
    df = df.dropna(subset=["date"])

    df["market_priority"] = df["market"].apply(
        lambda x: "1" if "colombo" in x.lower() else "0"
    )
    df.sort_values(
        by=["date", "market_priority"], ascending=[False, False], inplace=True
    )

    df = df.drop_duplicates(subset="commodity", keep="first")
    return df


def merge_ingredients_with_prices(ingredients_df, prices_df, key1, key2, threshold=60):
    choices = prices_df[key2].tolist()

    def match_key(row, choices):
        # Remove scientific name from ingredient name
        pattern = r"\(.*?\)"
        key = re.sub(pattern, "", row[key1]).strip()

        best_match = process.extractOne(key, choices, scorer=fuzz.ratio)

        if best_match and best_match[1] >= threshold:
            print(key, "->", best_match)
            return best_match[0]
        return None

    ingredients_df["best_match"] = ingredients_df.apply(match_key, axis=1, choices=choices)
    merged_df = pd.merge(ingredients_df, prices_df, left_on="best_match", right_on=key2, how="left")

    return merged_df


if __name__ == "__main__":
    ingredients_file_path = "./datasets/ingredients.csv"
    ingredient_prices_file_path = "./datasets/ingredient_prices.csv"

    df_ingredients = pd.read_csv(ingredients_file_path)

    df_ingredient_prices = pd.read_csv(ingredient_prices_file_path)
    df_ingredient_prices = read_and_retrieve_only_latest_prices(df_ingredient_prices)

    df_ingredient_prices.to_csv('./datasets/latest_ingredient_prices.csv')
    merged_df = merge_ingredients_with_prices(df_ingredients, df_ingredient_prices, "Food Name", "commodity")
    # print(merged_df.head())
