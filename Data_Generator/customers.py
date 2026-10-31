import random
import pandas as pd
from faker import Faker
from config import *

fake = Faker("en_IN")

cities = {
    "Delhi": "Delhi",
    "Mumbai": "Maharashtra",
    "Bengaluru": "Karnataka",
    "Hyderabad": "Telangana",
    "Chennai": "Tamil Nadu",
    "Pune": "Maharashtra",
    "Kolkata": "West Bengal",
    "Ahmedabad": "Gujarat",
    "Jaipur": "Rajasthan",
    "Lucknow": "Uttar Pradesh"
}


def generate_customers():

    customers = []

    used_email = set()
    used_phone = set()

    for customer_id in range(1, NUM_CUSTOMERS + 1):

        city = random.choice(list(cities.keys()))
        state = cities[city]

        name = fake.name()

        # Unique Email
        while True:
            email = (
                name.lower()
                .replace(" ", ".")
                .replace("'", "")
                + str(random.randint(1, 9999))
                + "@gmail.com"
            )

            if email not in used_email:
                used_email.add(email)
                break

        # Unique Phone
        while True:
            phone = "9" + "".join(random.choices("0123456789", k=9))

            if phone not in used_phone:
                used_phone.add(phone)
                break

        customers.append([
            customer_id,
            name,
            email,
            phone,
            city,
            state,
            fake.date_between(
                start_date=pd.to_datetime(START_DATE).date(),
                end_date=pd.to_datetime(END_DATE).date()
            )
        ])

    columns = [
        "Customer_ID",
        "Customer_Name",
        "Email",
        "Phone",
        "City",
        "State",
        "Registration_Date"
    ]

    df = pd.DataFrame(customers, columns=columns)

    df.to_csv(
        f"{OUTPUT_FOLDER}/Customers.csv",
        index=False
    )

    print("Customers.csv Generated Successfully!")