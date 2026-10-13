# Findings: Retail Sales & Profit Intelligence

Dataset: Olist Brazilian E-Commerce, Sep 2016 to Aug 2018, 98,666 orders with items. All figures in Brazilian reais (R$), revenue measured on item price (freight excluded).

**How to read this:** sections 1 to 3 use real Olist data. Section 4 uses the simulated profit model, so treat it as a demonstration of method, not as findings about Olist.

## 1. Delivery and geography (real data)

- Orders take **12.0 days** on average to arrive, and **6.6%** of delivered items arrive later than the estimate.
- Delivery speed depends heavily on region. **São Paulo** averages **8.3 days**; **Amazonas (AM)** averages **26.0 days**. Alagoas (AL) and Pará (PA) follow at 24.0 and 23.3 days. (States with at least 100 orders.)
- **Alagoas** has the highest late rate at **20.8%**, followed by Maranhão (18.0%) and Sergipe (16.3%). Alagoas appears in both the slowest-delivery and highest-late lists.
- **São Paulo** alone brings **R$5.20M, 38.3%** of revenue. São Paulo, Rio de Janeiro and Minas Gerais together bring **63.4%**.
- São Paulo has the **lowest average order value** among the top 10 states (R$125.75, against R$152.28 in Bahia).

## 2. Customers and payments (real data)

- Only **3.1% of customers** (3.05%, among 95,420 unique customers) ordered more than once. Almost all revenue comes from first-time buyers.
- **Credit cards carry 79.7%** of revenue. Credit-card orders average **3.6 instalments**; every other payment method averages about 1.
- **Boleto** is the second route at **17.6%**. Voucher and debit card together are about 2.7%.

## 3. Sales trend (real data)

- Revenue in the first half of 2018 (R$5.64M) was **2.8 times** the first half of 2017 (R$2.04M), a sign of how quickly the marketplace was growing in this window.
- **24 November 2017** was the biggest day: R$152.7K across 1,166 orders, about **7 times** the median day (R$20.5K). This date is Black Friday, so the spike is consistent with it.
- After the November 2017 peak, monthly revenue settled around R$0.85M to R$1.0M through 2018.

## 4. Category profit (simulated, method demonstration)

Profit uses a simulated cost model: category base cost of 60% to 75% of price plus per-transaction noise. The overall margin of **33.3%** and the differences below come from the simulation.

- By revenue, the top categories are health_beauty (R$1.26M), watches_gifts (R$1.21M), bed_bath_table (R$1.04M), sports_leisure (R$0.99M) and computers_accessories (R$0.91M). These revenue figures are real.
- Simulated margins range from about 25% to 40% across the top 15 categories. The chart is built to show the type of insight a real cost column would unlock: high revenue with a thin margin (health_beauty, sports_leisure) versus high revenue with a healthy margin (bed_bath_table, watches_gifts).

## 5. What I would look at next

These are interpretations and questions for follow-up, not conclusions the data proves:

- **Retention is the largest gap.** With only 3% repeat buyers, even a small improvement in second purchases could matter more than new acquisition. A cohort analysis would test this.
- **Regional logistics.** Northern and north-eastern states have both slow delivery and high late rates. Comparing seller-to-customer distance with delay would show whether it is distance or carrier performance.
- **Real cost data.** Replacing the simulated cost layer with actual product cost would turn Section 4 into real margin findings.

## Method and limitations

- Cleaning, merging and the profit simulation are in `notebooks/01_cleaning_and_fact_table.ipynb`; totals were cross-checked in SQLite (`sql/validation_queries.sql`).
- The fact table is at order-item grain (112,650 rows). Orders with no items (775) are excluded.
- September 2018 has one order because the dataset ends mid-month; it is excluded from trend charts.
- "Late" is calculated on delivered order items. At order level the rate is 6.8%.
- Payment type is the dominant method per order, so revenue by payment type is an approximation for orders paid with more than one method.
- Repeat customers are identified by `customer_unique_id` within this dataset only.
