import random
import pandas as pd

from faker import Faker
from config import *

fake = Faker("en_IN")


def generate_orders():

    orders = []

    payment_methods = list(PAYMENT_METHODS.keys())
    payment_weights = list(PAYMENT_METHODS.values())

    order_status = list(ORDER_STATUS.keys())
    status_weights = list(ORDER_STATUS.values())

    for order_id in range(1, NUM_ORDERS + 1):

        customer_id = random.randint(1, NUM_CUSTOMERS)

        order_date = fake.date_time_between(
            start_date=pd.to_datetime(START_DATE).to_pydatetime(),
            end_date=pd.to_datetime(END_DATE).to_pydatetime()
        )

        payment = random.choices(
            payment_methods,
            weights=payment_weights,
            k=1
        )[0]

        status = random.choices(
            order_status,
            weights=status_weights,
            k=1
        )[0]

        discount = random.choice(DISCOUNT_OPTIONS)

        orders.append([
            order_id,
            customer_id,
            order_date,
            payment,
            status,
            discount
        ])

    columns = [
        "Order_ID",
        "Customer_ID",
        "Order_Date",
        "Payment_Method",
        "Order_Status",
        "Discount"
    ]

    df = pd.DataFrame(orders, columns=columns)

    df.to_csv(
        f"{OUTPUT_FOLDER}/Orders.csv",
        index=False
    )

    print("Orders.csv Generated Successfully!")