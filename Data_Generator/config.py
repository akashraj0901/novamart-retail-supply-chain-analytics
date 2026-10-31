# ==============================
# NovaMart Data Generator Config
# ==============================

NUM_CUSTOMERS = 5000

START_DATE = "2022-01-01"
END_DATE = "2025-12-31"

OUTPUT_FOLDER = "output"


# -------------------------------
# Orders Configuration
# -------------------------------

NUM_ORDERS = 50000

PAYMENT_METHODS = {
    "UPI": 55,
    "Card": 35,
    "Cash": 10
}

ORDER_STATUS = {
    "Delivered": 90,
    "Pending": 4,
    "Processing": 3,
    "Shipped": 2,
    "Cancelled": 1
}

DISCOUNT_OPTIONS = [0, 5, 10, 15, 20]


# -------------------------------
# Order_details Configuration
# -------------------------------

MAX_PRODUCTS_PER_ORDER = 5