# Retail Sales & Profit Intelligence

### End-to-End Data Analytics | Python · SQL · Power BI

An end-to-end retail analytics project exploring sales performance, simulated profitability, product categories, geographic trends, delivery efficiency, and customer purchasing behavior using the **Brazilian Olist E-Commerce dataset**.

Built to demonstrate how raw transactional data can be transformed into validated analytical datasets and interactive Power BI dashboards that support business decision-making.

---

## 📌 Project Overview

E-commerce businesses need more than sales figures to understand performance. They need visibility into profitability, customer retention, regional demand, payment behavior, and delivery reliability.

This project analyzes more than **92,000 orders from 2016–2018**, transforming raw data from multiple CSV files into a structured analytical model and a four-page Power BI dashboard.

The workflow combines Python-based data preparation, independent SQL validation, and Power BI visualization to uncover patterns and potential business improvement opportunities.

### Project Highlights

* Cleaned and integrated multiple related e-commerce datasets using Python and Pandas.
* Built a consolidated fact table and supporting dimension tables.
* Used SQLite queries to independently validate analytical outputs.
* Developed a simulated product cost model to estimate profitability.
* Designed a four-page Power BI dashboard using a financial-terminal-inspired theme.
* Translated analytical results into business insights and potential actions.

---

## 🛠️ Tech Stack

| Technology       | Application                                                     |
| ---------------- | --------------------------------------------------------------- |
| Python           | Data cleaning, transformation, merging, and feature engineering |
| Pandas           | Data manipulation and analytical dataset preparation            |
| SQLite           | Independent validation and SQL-based analysis                   |
| SQL              | Aggregations, reconciliation, and analytical cross-checks       |
| Power BI         | Interactive dashboards and business intelligence                |
| DAX              | Measures and KPI calculations                                   |
| Jupyter Notebook | Reproducible analysis workflow                                  |
| Git & GitHub     | Version control and project documentation                       |

---

## 📊 Key Business Metrics

The following metrics were reported by the project pipeline and cross-checked using Python and SQLite.

| Metric                                   |     Reported Result |
| ---------------------------------------- | ------------------: |
| Orders analyzed                          |             92,000+ |
| Total revenue                            |     R$12,611,643.70 |
| Estimated profit                         |      R$4,208,515.91 |
| Estimated profit margin                  |              33.27% |
| Late delivery rate                       |  Approximately 6.6% |
| On-time delivery rate                    | Approximately 93.4% |
| Revenue contribution from São Paulo      |   Approximately 38% |
| Revenue contribution from SP, RJ, and MG |   Approximately 63% |
| Repeat-customer rate                     |  Approximately 3.1% |
| Revenue share from credit-card payments  | Approximately 79.7% |

**Important:** These figures describe the current project outputs. Revenue, profit, delivery, and customer metrics must be interpreted according to their respective calculation definitions and data filters.

---

## 📈 Dashboard Design: The Ledger

The dashboard follows a financial-terminal-inspired visual identity called **The Ledger**.

### Design Principles

* Near-black canvas for a focused analytical experience.
* Copper accents to emphasize profitability and key financial metrics.
* Monospace-style figures for a financial reporting aesthetic.
* Consistent KPI cards, chart hierarchy, and page navigation.
* A balance between executive-level summaries and detailed exploration.

## Screenshots
<img width="1317" height="740" alt="executive_overview" src="https://github.com/user-attachments/assets/b48ce24c-db58-4420-9d10-cd6de3acdd1f" />
<img width="1314" height="740" alt="category_product_analysis" src="https://github.com/user-attachments/assets/602510ed-313d-4aa6-b696-adc16b5523b7" />
<img width="1315" height="739" alt="geography_delivery" src="https://github.com/user-attachments/assets/46aab12d-f9ad-4b07-af63-b89753417a84" />
<img width="1314" height="740" alt="customer_payment" src="https://github.com/user-attachments/assets/db6e49e2-8fc7-4870-a676-f0540a625ca6" />

### Dashboard Pages

#### 1. Executive Overview

Provides a high-level view of business performance.

Key components:

* Total revenue, estimated profit, and estimated profit margin.
* Monthly revenue and profit trends.
* Top five product categories by revenue.
* High-level indicators for sales and delivery performance.

**Business question:** How is the business performing, and where are the main revenue and profitability trends?

#### 2. Category & Product Analysis

Explores differences in revenue and estimated profitability across product categories.

Key components:

* Revenue versus estimated profit margin by category.
* Top 15 categories ranked by revenue.
* Category-level profitability comparisons.
* Product performance analysis.

**Business question:** Which product categories generate the most revenue, and which appear more profitable under the modeled cost assumptions?

#### 3. Geography & Delivery Performance

Examines regional revenue distribution and delivery reliability across Brazilian states.

Key components:

* Revenue contribution by state.
* Highest and lowest delivery performance across states.
* Order volume and late-delivery analysis by state.
* Regional comparisons of delivery outcomes.

**Business question:** Which regions contribute most to revenue, and where could delivery performance improve?

#### 4. Customer & Payment Intelligence

Investigates customer purchasing frequency and payment preferences.

Key components:

* Repeat-customer and one-time-customer analysis.
* Revenue distribution by payment method.
* Average instalments by payment method.
* Customer purchasing behavior and retention opportunities.

**Business question:** How dependent is the business on one-time buyers, and how do payment preferences influence transaction behavior?

---

## 💡 Key Business Insights

### 1. Revenue Is Concentrated Geographically

São Paulo contributes approximately **38% of total revenue**, equivalent to around R$5.2 million. São Paulo, Rio de Janeiro, and Minas Gerais collectively account for approximately 63%.

**Business implication:** These states represent important markets for regional performance monitoring, demand planning, and delivery optimization.

### 2. Strong Reported Delivery Performance, With Room to Improve

The reported delivery metrics indicate an on-time delivery rate of approximately 93.4% and a late-delivery rate of approximately 6.6%.

**Business implication:** Further analysis by state, order volume, and delivery outcomes can help identify locations that may benefit from operational improvements.

*These rates should be interpreted using the project's delivery-status definitions and the population of orders included in the calculation.*

### 3. Customer Retention Is a Potential Growth Opportunity

The analysis reports a repeat-customer rate of approximately 3.1%, indicating that repeat purchasing is relatively limited under the project's customer-level calculation.

**Business implication:** Customer retention analysis could help identify opportunities for re-engagement, repeat purchases, and longer-term customer value.

*The repeat-customer definition, customer identifier, and observation period should be considered when interpreting this result.*

### 4. Credit Cards Dominate Payment Revenue

Credit-card transactions account for approximately 79.7% of reported revenue, while boleto accounts for approximately 17.6%. Voucher and debit-card payments contribute a comparatively small share.

**Business implication:** Payment-method analysis can help businesses understand transaction preferences and evaluate payment-specific purchasing patterns.

### 5. Revenue Leadership Does Not Necessarily Mean the Highest Average Order Value

Although São Paulo leads in total revenue, its reported average order value among the ten highest-revenue states is approximately R$125.75, compared with R$152.28 in Bahia.

**Business implication:** Regional sales volume and average order value should be analyzed together to distinguish high-volume markets from markets with higher transaction values.

---

## 🧮 Profitability Modeling: An Important Assumption

The original Olist dataset does not provide actual product cost or profit figures.

To demonstrate profitability analysis, this project introduces a **simulated product cost model**.

The modeling approach assigns product categories base cost ratios of approximately 60%–75% of product price and introduces transaction-level random variation.

Estimated profit is then calculated from revenue and the modeled cost assumptions.

The resulting profit and margin metrics are analytical estimates, not verified financial results from Olist.

### Why Use a Simulated Model?

* Demonstrates cost-based feature engineering.
* Enables category-level profitability comparisons.
* Supports DAX measure development and financial dashboard design.
* Provides an opportunity to document modeling assumptions and limitations.

### Limitations

* Modeled costs do not represent actual supplier costs.
* Simulated profits should not be used for real financial decisions.
* Transaction-level randomness can affect reproducibility unless a random seed is fixed.
* Revenue, cost, freight, refunds, and order-status definitions must be handled consistently.

**Interpretation:** The profitability results illustrate analytical methodology rather than actual company earnings.

---

## 🗂️ Repository Structure

```text
retail-sales-profit-intelligence/
│
├── data/
│   ├── raw/
│   │   └── Original Olist CSV files
│   │
│   └── processed/
│       ├── Cleaned fact table
│       └── Star-schema dimension tables
│
├── notebooks/
│   └── 01_cleaning_and_fact_table.ipynb
│
├── sql/
│   └── validation_queries.sql
│
├── powerbi/
│   └── Retail_Sales_Profit_Intelligence.pbix
│
├── screenshots/
│   ├── executive_overview.png
│   ├── category_product_analysis.png
│   ├── geography_delivery.png
│   └── customer_payment.png
│
└── README.md
```

*The Power BI file and screenshot filenames above are intended repository conventions. Add or rename these entries to match the actual files in your repository.*

---

## 🔄 Project Workflow

**1. Data Ingestion**

* Loaded the original Olist CSV files.
* Inspected dataset structure, data types, and missing values.
* Identified relationships between orders, customers, products, payments, and delivery information.

**2. Data Cleaning and Transformation**

* Cleaned and standardized relevant columns.
* Processed dates and numerical fields.
* Merged related datasets into an analytical structure.
* Created a consolidated fact table and supporting dimension tables.

**3. Analytical Feature Engineering**

* Calculated sales and delivery indicators.
* Introduced the documented simulated cost model.
* Prepared category, customer, payment, and geographic attributes for analysis.

**4. SQL Validation**

* Loaded or queried the prepared data using SQLite.
* Independently recalculated selected metrics.
* Compared SQL outputs with Python results to identify inconsistencies.

**5. Power BI Development**

* Built KPI measures and supporting calculations.
* Designed four pages around specific business questions.
* Applied the The Ledger visual theme.
* Presented analytical results through interactive charts and summaries.

---

## 🚀 How to Explore the Project

1. Clone or download the repository.
2. Install Python and the required notebook dependencies.
3. Place the original dataset files in `data/raw/`.
4. Run `notebooks/01_cleaning_and_fact_table.ipynb` to reproduce the data-preparation workflow.
5. Execute `sql/validation_queries.sql` against the corresponding SQLite database or adapted tables.
6. Open the Power BI file in Power BI Desktop to explore the dashboards.

### Suggested Python Dependencies

```bash
pip install pandas numpy jupyter
```

SQLite is available through Python's standard library, so a separate SQLite Python package is not normally required for this workflow.

---

## 📚 Dataset

**Olist Brazilian E-Commerce Public Dataset**

The dataset contains anonymized Brazilian e-commerce transactions and related customer, product, payment, and delivery information covering the 2016–2018 period.

The project uses related CSV files to explore transactional sales and operational performance.

Please follow the original dataset provider's terms when accessing, redistributing, or using the data.

---

## 🎯 Skills Demonstrated

* Data cleaning and preprocessing
* Exploratory data analysis
* Multi-table data integration
* SQL aggregation and validation
* Data modeling and star-schema design
* KPI development and business metric interpretation
* Power BI dashboard development
* DAX-based calculations
* Profitability simulation and assumption documentation
* Business storytelling and insight communication
* GitHub project documentation

---

## 🔮 Potential Future Improvements

* Add automated data-quality checks.
* Make the simulated cost model fully reproducible using a fixed random seed.
* Introduce sensitivity analysis for category cost assumptions.
* Add drill-through pages for state, category, and customer analysis.
* Investigate delivery delays by purchase, approval, dispatch, and estimated-delivery dates.
* Add a data dictionary and metric-definition document.
* Document the reconciliation process for every headline KPI.

---

## 👨‍💻 About This Project

This project demonstrates an end-to-end analytical workflow that combines Python, SQL, and Power BI to turn raw e-commerce data into structured analysis and business-focused dashboards.

The focus is on analytical accuracy, transparent assumptions, meaningful visualizations, and translating data into actionable business questions.

**Tools:** Python | Pandas | SQLite | SQL | Power BI | DAX

**Project Type:** End-to-End Data Analytics & Business Intelligence
