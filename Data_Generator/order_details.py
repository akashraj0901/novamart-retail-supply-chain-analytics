import random
import pandas as pd
from config import *

def generate_order_details():

    # Read Products
    products = pd.read_csv(f"{OUTPUT_FOLDER}/Products.csv")

    product_dict = {}

    for _, row in products.iterrows():
        product_dict[row["Product_ID"]] = {
            "Selling_Price": row["Current_price"],
            "Cost_Price": row["Cost_Price"]
        }

    order_details = []

    detail_id = 1

    for order_id in range(1, NUM_ORDERS + 1):

        # Each order contains 1–5 unique products
        num_products = random.randint(1, MAX_PRODUCTS_PER_ORDER)

        selected_products = random.sample(
            list(product_dict.keys()),
            num_products
        )

        for product_id in selected_products:

            quantity = random.randint(1, 5)

            selling_price = product_dict[product_id]["Selling_Price"]

            cost_price = product_dict[product_id]["Cost_Price"]

            order_details.append([
                detail_id,
                order_id,
                product_id,
                quantity,
                selling_price,
                cost_price
            ])

            detail_id += 1

    columns = [
        "Order_Detail_ID",
        "Order_ID",
        "Product_ID",
        "Quantity",
        "Selling_Price",
        "Cost_Price"
    ]

    df = pd.DataFrame(order_details, columns=columns)

    df.to_csv(
        f"{OUTPUT_FOLDER}/Order_Details.csv",
        index=False
    )

    print("Order_Details.csv Generated Successfully!")