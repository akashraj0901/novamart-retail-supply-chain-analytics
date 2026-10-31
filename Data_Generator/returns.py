import random
import pandas as pd
from faker import Faker
from config import *

fake = Faker("en_IN")

RETURN_RATE = 0.05

RETURN_REASONS = [
    "Damaged Product",
    "Wrong Product",
    "Changed Mind",
    "Late Delivery"
]


def generate_returns():

    orders = pd.read_csv(f"{OUTPUT_FOLDER}/Orders.csv")

    order_details = pd.read_csv(f"{OUTPUT_FOLDER}/Order_Details.csv")

    delivered_orders = orders[
        orders["Order_Status"] == "Delivered"
    ]

    delivered_ids = set(delivered_orders["Order_ID"])

    delivered_details = order_details[
        order_details["Order_ID"].isin(delivered_ids)
    ]

    returns = []

    return_id = 1

    for _, row in delivered_details.iterrows():

        if random.random() <= RETURN_RATE:

            refund = row["Selling_Price"] * row["Quantity"]

            returns.append([

                return_id,

                row["Order_Detail_ID"],

                fake.date_between(
                    start_date=pd.Timestamp("2025-01-02").date(),
                    end_date=pd.Timestamp.today().date()
                    ),

                random.choice(RETURN_REASONS),

                round(refund,2)

            ])

            return_id += 1

    df = pd.DataFrame(

        returns,

        columns=[

            "Return_ID",

            "Order_Detail_ID",

            "Return_Date",

            "Return_Reason",

            "Refund_Amount"

        ]

    )

    df.to_csv(

        f"{OUTPUT_FOLDER}/Returns.csv",

        index=False

    )

    print("Returns.csv Generated Successfully!")