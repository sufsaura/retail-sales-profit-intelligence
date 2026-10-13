# Retail Sales & Profit Intelligence

Sales, profit, and delivery performance analysis on the Olist Brazilian E-Commerce dataset (92K+ orders, 2016–2018).

## Stack
Python (pandas) → SQLite (validation) → Power BI (dashboard)

## Structure
- `data/raw/` — original 9 Olist CSVs
- `data/processed/` — cleaned fact table + star-schema dimension tables
- `notebooks/01_cleaning_and_fact_table.ipynb` — full cleaning, merging, and cost/profit simulation pipeline
- `sql/validation_queries.sql` — independent SQL cross-check of the Python output
- `powerbi/` — the .pbix dashboard file (add after building)
- `screenshots/` — dashboard page exports (add after building)

## Key numbers (validated in both Python and SQL)
- Total revenue: ₹12,611,643.70
- Total profit (simulated): ₹4,522,515.91
- Overall margin: 33.27%
- Late delivery rate: ~6.6%
- Top state by revenue: São Paulo (SP), ~38% of total

## Note on profit data
The raw Olist dataset has no cost/profit column — only `price` and `freight_value`. Profit here is a **simulated cost model**: each product category gets a base cost ratio (60–75% of price), with per-transaction random noise, so margins vary realistically instead of being flat. This is clearly a modeling choice made for portfolio demonstration, not real Olist financials.

## Dashboard theme: "The Ledger"
A financial-terminal aesthetic (near-black canvas, copper profit accent, monospace figures) — see `powerbi_build_guide` for the full design system and DAX measures.

## Dashboard Page
1.Executive Overview -- calculating KPI cards with 92k+ orders with over a margin of 33.27% and revenue of profit by month ,escalating with top 5 categories by revenues.
2.Category & Product -- estimation revenue vs margin by category of calculating the profit margin % of sau paulo and ranking the top 15 categories by revenue.
3.Geography & Delivery -- calculating the highest vs lowest delivery rate by state and orders & lateness by state with more time delivery 93.4%
4.Customer & Payment --  About 97% of customers buy only once (repeat rate 3.1%), so retention is the biggest gap.Credit cards carry 79.7% of revenue. Credit-card orders average 3.6 instalments, versus about 1 for every other method.

##Screenshots
<img width="1317" height="740" alt="Screenshot 2026-10-13 122649" src="https://github.com/user-attachments/assets/95e2594d-f179-47d2-a5ae-f69061ae2065" />
<img width="1314" height="740" alt="Screenshot 2026-10-13 122718" src="https://github.com/user-attachments/assets/54aa6a67-44b7-4084-8783-84feb74ddd0a" />
<img width="1315" height="739" alt="Screenshot 2026-10-13 122734" src="https://github.com/user-attachments/assets/a433c8dd-174a-4181-90b0-0ee8e718ae76" />
<img width="1314" height="740" alt="Screenshot 2026-10-13 122752" src="https://github.com/user-attachments/assets/30e03dfc-d100-4fd3-87f2-c3a5813c9dd8" />

- Boleto is the second route at 17.6%. Voucher and debit card together are under 3%.
- São Paulo alone brings R$5.2M (38% of revenue), and SP, RJ and MG together bring 63%.
  SP also has the lowest average order value of the top 10 states (125.75, against 152.28 in BA).





