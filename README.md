# Retail Sales & Profit Intelligence

Sales, profit, and delivery performance analysis on the Olist Brazilian E-Commerce dataset (99K+ orders, 2016–2018).

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
- Total revenue: ₹13,591,643.70
- Total profit (simulated): ₹4,522,515.91
- Overall margin: 33.27%
- Late delivery rate: ~6.6%
- Top state by revenue: São Paulo (SP), ~38% of total

## Note on profit data
The raw Olist dataset has no cost/profit column — only `price` and `freight_value`. Profit here is a **simulated cost model**: each product category gets a base cost ratio (60–75% of price), with per-transaction random noise, so margins vary realistically instead of being flat. This is clearly a modeling choice made for portfolio demonstration, not real Olist financials.

## Dashboard theme: "The Ledger"
A financial-terminal aesthetic (near-black canvas, copper profit accent, monospace figures) — see `powerbi_build_guide` for the full design system and DAX measures.
