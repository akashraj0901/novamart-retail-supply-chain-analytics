import random
import os
import pandas as pd
from faker import Faker
from config import *

fake = Faker("en_IN")


def generate_shipments():

    orders = pd.read_csv(
        f"{OUTPUT_FOLDER}/Orders.csv"
    )

    shipments = []

    shipment_id = 1

    valid_status = [
        "Delivered",
        "Shipped",
        "Processing"
    ]

    for _, order in orders.iterrows():

        order_status = order["Order_Status"]

        if order_status not in valid_status:
            continue

        # Convert Order_Date from CSV string to datetime
        order_date = pd.to_datetime(
            order["Order_Date"]
        )

        # Shipment occurs 1–5 days after order
        shipment_delay = random.randint(1, 5)

        shipment_date = (
            order_date +
            pd.Timedelta(days=shipment_delay)
        )

        # Delivered orders get a delivery date
        if order_status == "Delivered":

            # Delivery occurs 1–7 days after shipment
            delivery_delay = random.randint(1, 7)

            delivery_date = (
                shipment_date +
                pd.Timedelta(days=delivery_delay)
            )

        else:

            # Processing and Shipped orders
            # have not been delivered yet
            delivery_date = "NULL"

        shipments.append([
            shipment_id,
            order["Order_ID"],
            random.randint(1, 8),
            shipment_date.date(),
            delivery_date.date() if delivery_date !="NULL" else "NULL",
            order_status
        ])

        shipment_id += 1

    columns = [
        "Shipment_ID",
        "Order_ID",
        "Warehouse_ID",
        "Shipment_Date",
        "Delivery_Date",
        "Delivery_Status"
    ]

    df = pd.DataFrame(
        shipments,
        columns=columns
    )

    # Make sure output folder exists
    os.makedirs(
        OUTPUT_FOLDER,
        exist_ok=True
    )

    output_file = os.path.join(
        OUTPUT_FOLDER,
        "Shipments.csv"
    )

    df.to_csv(
        output_file,
        index=False
    )

    print("Shipments.csv Generated Successfully!")
    print(f"Total Shipments: {len(df)}")