# NovaMart — Retail Supply Chain Analytics

## Project Overview

NovaMart is an end-to-end retail analytics project designed to analyze sales performance, customer behavior, product profitability, inventory health, and supply chain operations using synthetic retail data.

The project demonstrates a complete analytics workflow, from Python-based data generation and MySQL data preparation to interactive Power BI dashboards.

## Project Objectives

- Analyze revenue, profit, and sales trends.
- Identify high-performing products and categories.
- Understand customer purchasing behavior and repeat purchases.
- Monitor inventory levels and identify stock replenishment needs.
- Examine shipment and return patterns.
- Present business insights through interactive dashboards.

## Technology Stack

| Technology | Purpose |
|---|---|
| Python | Generate synthetic retail datasets |
| MySQL | Store, transform, and analyze data |
| SQL | Perform business analysis and create views |
| Power BI | Build interactive dashboards |
| DAX | Create measures and KPIs |

## Project Structure

```text
NovaMart/
├── Data_Generator/
├── DataSets/
├── Documentation/
├── Images/
├── PowerBI/
│   └── DashBoard.pbix
├── Python/
├── ReadMe/
├── SQL/
│   ├── 01_Create_Database.sql
│   ├── 02_Load_Data.sql
│   ├── 03_SQL_Analysis.sql
│   └── 04_NovaMart_Views.sql
└── README.md
```

## Data Generation

Python scripts generate synthetic retail datasets for customers, products, orders, order details, shipments, and returns.

The project also includes inventory and other supporting data used for supply chain analysis.

**Note:** The datasets are synthetic and intended for analytics practice and portfolio demonstration.

## SQL Analysis

The MySQL component includes database creation, data loading, analytical queries, and views designed to support Power BI reporting.

The analysis focuses on:

- Sales and revenue performance
- Product and category performance
- Profitability analysis
- Customer purchasing behavior
- Returns and shipment analysis
- Inventory health and stock replenishment

## Power BI Dashboards

### 1. Executive Overview

Provides a high-level view of business performance, including revenue, profit, profit margin, orders, customers, and returns.

Key visualizations include monthly sales trends, category performance, top products, top customers, and return reasons.

### 2. Supply Chain Operations

Focuses on inventory health, stock replenishment, warehouse inventory, and stockout records.

The dashboard helps identify inventory-related areas that may require operational attention.

### 3. Customer & Product Insights

Explores customer segments, customer revenue, repeat purchasing behavior, average order value, and product performance.

It helps compare customers and products using interactive filters.

## Business Value

This project demonstrates how retail data can be transformed into structured analysis and interactive reports to support business decisions involving sales, profitability, customers, and inventory operations.

## How to Explore the Project

1. Review the Python scripts in `Data_Generator/`.
2. Explore the generated datasets in `DataSets/`.
3. Review the SQL scripts in `SQL/`.
4. Open `PowerBI/DashBoard.pbix` using Power BI Desktop.
5. Explore the dashboards and interact with their filters.

Database configuration and data source settings may need to be adjusted when running the project on another computer.

## Disclaimer

NovaMart is a portfolio project using synthetic data. It is not affiliated with any real retail business.

---

**Project:** NovaMart — Retail Supply Chain Analytics  
**Tools:** Python | MySQL | SQL | Power BI | DAX
