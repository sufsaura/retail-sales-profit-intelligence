# Retail Sales & Profit Intelligence — Power BI Build Guide

Data source: `data/processed/` (fact_sales, dim_date, dim_products, dim_customers, dim_sellers).
Validated against `sql/validation_queries.sql` — total revenue ₹13,591,643.70, profit ₹4,522,515.91, margin 33.27%.

---

## 1. Import & Data Model

**Get Data → Text/CSV**, import these 5 tables only (skip `monthly_rollup.csv` and `category_rollup.csv` — they were for SQL cross-checking, not the model; DAX will compute these live so slicers/filters work correctly):

- `fact_sales.csv`
- `dim_date.csv`
- `dim_products.csv`
- `dim_customers.csv`
- `dim_sellers.csv`

**One transform needed before relating dates:** `fact_sales.order_purchase_timestamp` is a full timestamp, but `dim_date.date` is day-level. In Power Query, add a custom column on `fact_sales`:

```
order_date = Date.From([order_purchase_timestamp])
```

**Relationships (Model view):**

| From | To | Cardinality |
|---|---|---|
| fact_sales[order_date] | dim_date[date] | Many-to-one |
| fact_sales[product_id] | dim_products[product_id] | Many-to-one |
| fact_sales[customer_id] | dim_customers[customer_id] | Many-to-one |
| fact_sales[seller_id] | dim_sellers[seller_id] | Many-to-one |

Right-click `dim_date` → **Mark as Date Table** (using the `date` column). This unlocks time-intelligence DAX (MoM, YoY, YTD).

**Filter out the incomplete tail month:** 2018-09 has only 1 order (dataset just ends mid-month — not a real sales crash). Add a report-level filter: `dim_date[date] <= 2018-08-31`, or note it in a text box on the trend chart instead of hiding it — your call, but don't let it visually read as a crash.

---

## 2. DAX Measures

### Core Sales & Profit
```dax
Total Revenue = SUM(fact_sales[price])
Total Freight = SUM(fact_sales[freight_value])
Total Cost = SUM(fact_sales[cost])
Total Profit = SUM(fact_sales[profit])
Profit Margin % = DIVIDE([Total Profit], [Total Revenue], 0)
Total Orders = DISTINCTCOUNT(fact_sales[order_id])
Total Items Sold = COUNTROWS(fact_sales)
Avg Order Value = DIVIDE([Total Revenue], [Total Orders], 0)
Avg Basket Size = DIVIDE([Total Items Sold], [Total Orders], 0)
```

### Delivery Performance
```dax
Avg Delivery Days = AVERAGE(fact_sales[delivery_days])

Late Delivery % =
DIVIDE(
    CALCULATE(COUNTROWS(fact_sales), fact_sales[is_late] = TRUE(), fact_sales[order_status] = "delivered"),
    CALCULATE(COUNTROWS(fact_sales), fact_sales[order_status] = "delivered"),
    0
)

On-Time Delivery % = 1 - [Late Delivery %]
```

### Time Intelligence (requires dim_date marked as Date Table)
```dax
Revenue MoM % =
VAR PrevMonth = CALCULATE([Total Revenue], DATEADD(dim_date[date], -1, MONTH))
RETURN DIVIDE([Total Revenue] - PrevMonth, PrevMonth, 0)

Revenue YoY % =
VAR PrevYear = CALCULATE([Total Revenue], SAMEPERIODLASTYEAR(dim_date[date]))
RETURN DIVIDE([Total Revenue] - PrevYear, PrevYear, 0)

Profit YTD = TOTALYTD([Total Profit], dim_date[date])
```

### Category & Product
```dax
Category Revenue Rank =
RANKX(ALL(dim_products[category]), [Total Revenue], , DESC)

Best Margin Category =
CALCULATE(
    VALUES(dim_products[category]),
    TOPN(1, ALL(dim_products[category]), [Profit Margin %], DESC)
)
```

### Geography
```dax
Revenue by State Rank =
RANKX(ALL(dim_customers[customer_state]), [Total Revenue], , DESC)
```

### Payment & Customer
```dax
Avg Installments = AVERAGE(fact_sales[payment_installments])

Credit Card Revenue Share =
DIVIDE(
    CALCULATE([Total Revenue], fact_sales[payment_type] = "credit_card"),
    [Total Revenue], 0
)

Repeat Customer % =
VAR CustomerOrderCounts =
    SUMMARIZE(fact_sales, dim_customers[customer_unique_id], "OrderCount", DISTINCTCOUNT(fact_sales[order_id]))
VAR RepeatCustomers = COUNTROWS(FILTER(CustomerOrderCounts, [OrderCount] > 1))
VAR TotalCustomers = COUNTROWS(CustomerOrderCounts)
RETURN DIVIDE(RepeatCustomers, TotalCustomers, 0)
```

---

## 3. Theme — "The Ledger"

A financial-terminal aesthetic, deliberately different from the Dubai project's navy/gold — this one should look like a quant analyst's internal tool, not a corporate sales slide.

| Role | Value |
|---|---|
| Canvas | `#0B0C10` (near-black) |
| Panel | `#16181D` |
| Hairline dividers | `#2A2D35` — 1px lines only, zero border-radius, zero drop shadows anywhere |
| Profit accent (hero color) | `#C9762C` deep copper — reserved ONLY for profit figures |
| Revenue accent | `#4C8C86` muted steel teal |
| Late/alert accent | `#A23E33` muted brick — used sparingly, only for late-delivery flags |
| Text — headers | `#E8E6E1` |
| Text — labels | `#9CA0A8`, sentence case, never ALL CAPS |

**Typography:** `Space Grotesk` for titles/headers, `JetBrains Mono` for every number, KPI, and table figure — tabular monospace numbers are what make it read as a terminal instead of a slide deck. Install both (free Google Fonts) locally so Power BI Desktop can use them — Power BI themes only work with fonts already installed on your machine.

**Import the theme:** Power BI Desktop → View → Themes → Browse for themes → select `the_ledger_theme.json` (provided alongside this guide).

**Signature moves — the details that make it look like the top 1%, not a template:**
1. **Ticker strip instead of KPI cards.** Page 1's top row is one continuous horizontal strip with thin vertical hairline dividers between metrics — like a stock ticker — not rounded cards with shadows. Build it as a single rectangle with card visuals placed edge-to-edge inside it, borders off on each card, one shared border around the strip.
2. **One hero number.** Total Profit rendered huge (use the `callout` text class — 32pt JetBrains Mono, copper) alone in a corner of Page 1, nothing else competing with it. Every other KPI is smaller and quieter by comparison.
3. **Bump chart for category rank**, not a static bar chart (see Page 2) — shows how category revenue rank shifts month to month. This single chart type is what most portfolio dashboards never attempt and instantly reads as more sophisticated.
4. Flat and architectural throughout: no rounded corners, no gradients, no soft grey card shadows.

---

## 4. Page-by-Page Layout (4 pages, same structure as the Dubai project)

### Page 1 — Executive Overview
- **Hero number, top-left:** Total Profit alone, huge copper monospace (callout text class), small grey label beneath it — nothing else in that corner
- **Ticker strip, top row (right of hero):** Total Revenue · Profit Margin % · Total Orders · Avg Order Value · Late Delivery % — edge-to-edge cards, hairline dividers, no individual borders/shadows
- **Line chart:** Revenue & Profit trend by month (dual-line, teal + copper, `dim_date[year_month]` on axis)
- **Bar chart:** Top 5 categories by revenue (teal bars, copper highlight on #1)
- **Filled map:** Revenue by customer state (Brazil), copper-to-dark gradient instead of default blue
- **Slicer:** Date range (year/month), order status — styled as plain text toggles, not default dropdown chrome

### Page 2 — Category & Product Performance
- **Bump chart (signature visual):** Category revenue rank by month — shows categories rising/falling in rank over time, not just a static snapshot. This is the chart that separates this dashboard from a template.
- **Table:** Category, Items Sold, Revenue, Profit, Margin % — sorted by revenue, monospace numbers, copper conditional formatting on Margin %
- **Scatter/bubble chart:** Revenue (x) vs Margin % (y), bubble size = items sold, one bubble per category — shows health_beauty as high-revenue/low-margin vs bed_bath_table as high-revenue/high-margin
- **Bar chart:** Bottom 5 categories by margin (brick-accent watch-list)

### Page 3 — Geography & Delivery
- **Filled/bubble map:** Orders and revenue by state
- **Bar chart:** Avg delivery days by state
- **Bar chart:** Late delivery % by state
- **Card:** Overall avg delivery days, on-time %

### Page 4 — Customer & Payment Insights
- **Donut chart:** Revenue share by payment type
- **Bar chart:** Avg installments by payment type
- **Card:** Repeat customer %
- **Table:** Top 10 states by customer count and revenue

---

## 5. Export & Publish

1. Save as `powerbi/retail_sales_profit.pbix`
2. Export each page to PDF/PNG → save into `screenshots/` (e.g. `dashboard_page1_overview.png`)
3. Push the whole repo structure to GitHub as `sufsaura/retail-sales-profit-intelligence`
4. Use `findings.md` for the write-up + LinkedIn post, same pattern as the Dubai project

**Note for the README:** since cost/profit isn't in the raw Olist dataset, explicitly state that profit figures are a *simulated cost model* (60–75% category base + transaction-level noise) for portfolio demonstration — this is honest and actually shows methodology maturity to anyone reviewing your GitHub.
