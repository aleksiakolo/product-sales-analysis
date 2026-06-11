# Product Sales Data Analysis

## Overview
This project analyzes global product sales data to understand product performance and regional sales trends by cleaning the raw sales data and going through exploratory analysis and visualization.

---

## Objectives

- Identify the products, categories, and sub-categories that perform best 
- Determine the regions, markets, and countries that contribute the most
- Search for temporal trends in sales activity over time
- Understand how customer segments contribute to performance
- Analyze return behavior and its relationship to products and regions
- Gather organizational data by linking regional performance to managers

---

## Key Questions

### Product Performance
- Which products generate the highest total sales?
- Which product categories and sub-categories perform best overall?
- Are there products or categories that consistently underperform?

### Regional & Market Performance
- Which regions contribute the most to total sales?
- How does performance differ across markets (e.g., EU, LATAM)?
- Are certain regions specialized in specific product categories?

### Customer Segments
- How do sales differ across customer segments (Consumer, Corporate, Home Office)?
- Are certain product categories more dominant within specific segments?
- Do segments have different purchasing patterns in different regions?

### Returns Analysis
- Which products or categories have the highest return rates?
- Are returns concentrated in specific regions or markets?
- Is there a direct relationship between high sales volume and return frequency?

### Temporal Trends
- How do sales evolve over time?
- Are there seasonal or cyclical patterns in ordering behavior?
- Do temporal trends differ across regions, product categories, or customer segments?

### Organizational Perspective
- How does regional performance align with assigned personnel?
- Are there noticeable differences in performance across regions managed by different individuals?


---

## Dataset Description

This project uses a multi-sheet sales dataset containing **three related tables**: **Orders**, **Returns**, and **People**. Together, they provide information about sales transactions, returned orders, and regional personnel assignments.

---

### 1. Orders 

This dataset contains individual customer orders. Each row represents a single order with information about dates, customers, products, and geographic segmentation. Key columns include:

- **Order Information**
    - `order_id`: Unique identifier for each order
    - `order_date`: Date when the order was placed
    - `ship_date`: Date when the order was shipped
    - `ship_mode`: Shipping method used

- **Customer Information**
    - `customer_name`: Customer placing the order
    - `segment`: Customer segment (Consumer, Corporate, Home Office)

- **Geographic Information**
    - `state`: Customer state or province
    - `country`: Customer country
    - `market`: Broad market classification (e.g., APAC, EU, LATAM)
    - `region`: Sub-region within the market

- **Product Information**
    - `product_id`: Unique product identifier
    - `category`: High-level product category
    - `sub_category`: Product sub-category
    - `product_name`: Product description

---

### 2. Returns

This table contains information about orders that were returned. Each row represents a returned order and can be linked back to the Orders table using `order_id`.

**Columns:**
- `returned`: Indicates whether the order was returned (e.g., "Yes")
- `order_id`: Order identifier (joins with Orders table)
- `market`: Market where the return occurred

---

### 3. People

This table maps managers or representatives to geographic regions.

**Columns:**
- `person`: Name of the individual
- `region`: Region they are responsible for

---

## Relationships Between Tables

- `Orders.order_id` ↔ `Returns.order_id`  
  Used to identify which sales were returned.

- `Orders.region` ↔ `People.region`  
  Used to associate sales performance with regional personnel.

---

## Methodology

### Data Cleaning
- Inspection of data structure and variable types
- Handling missing values
- Removal of duplicate records
- Creation of a cleaned dataset for analysis

### Exploratory Data Analysis (EDA)
- Summary statistics
- Grouped aggregations by product and region
- Visual exploration using plots and charts

---

## Results & Insights

### Product Performance
- Technology is the highest-revenue and most profitable category; Furniture generates comparable revenue but with significantly lower profit margins.
- A Pareto-style concentration is present: a small share of orders account for the majority of total sales.
- Discount level is the strongest order-level predictor of profit (coefficient −235.85, standardized −0.287), outweighing category, quantity, and priority. Higher discounts reliably erode profitability.
- Larger orders reduce the probability of a loss: the log-sales logistic model shows a clear downward trend in loss probability as order size increases.

### Geographic & Market Performance
- Regional profit margins differ significantly (one-way ANOVA, p < 0.05), with Central and South regions underperforming relative to others.
- Return probability is not independent of region (chi-square test significant), indicating geographically concentrated return risk.
- Discount sensitivity varies by region: the interaction term `profit ~ discount * region` is significant, meaning the cost of discounting differs across markets.

### Customer Segments
- Segment margins are statistically different (ANOVA significant); the Consumer segment generates the highest volume, while Home Office tends to have higher per-order profitability.
- Return probability differs significantly across segments (chi-square test), with Corporate orders showing a higher return rate.
- The effect of discounting on profit also varies by segment (`profit ~ discount * segment` interaction significant).

### Returns & Discounts
- Returned orders have significantly lower mean profit than non-returned orders (Welch t-test, p < 0.05).
- Higher discount levels are associated with higher return probability (logistic regression significant).
- Return rates and profit both differ significantly across discount buckets (chi-square and ANOVA both significant), reinforcing that heavy discounting carries compounding risk.

### Temporal Trends
- No statistically significant structural shift in profitability after 2013 (regression p = 0.426).
- No detectable long-run upward or downward sales trend at the order level (year coefficient p = 0.836).
- Return risk shows a weak downward trend over time (logistic regression p ≈ 0.075), but this does not reach conventional significance.
- Discount intensity has remained broadly stable over the observed period (p = 0.181).
- Most performance variation is therefore driven by cross-sectional factors — product mix, region, segment, and discount policy — rather than time.

---

## Project Structure

```text
product-sales-analysis/
├── data/
│   ├── raw/                          # Original Excel source file
│   └── processed/                    # Cleaned CSVs (Orders, Returns, People)
├── notebooks/
│   ├── dataset_analysis.ipynb        # Initial data loading and cleaning
│   ├── orders_statistics.ipynb       # Descriptive statistics for Orders table
│   ├── inferential_analysis_plan.md  # Plan mapping EDA observations to inference tests
│   ├── analysis/                     # Numeric EDA notebooks (01–07 by topic)
│   ├── visualization/                # Plot-focused notebooks (01–07 by topic)
│   └── inferential_statistics/       # Inferential/modelling notebooks (01–07 by topic)
├── R/
│   ├── analysis_helpers.R            # Shared join, filter, summary, and plot helpers
│   ├── apply_factors.R               # Factor-level encoding for all three tables
│   └── temporal_helpers.R            # Time period helpers and trend plots
├── renv/
│   ├── activate.R
│   └── settings.json
├── renv.lock
├── .Rprofile
├── .gitignore
└── README.md
```
---

## Dashboards

Interactive dashboards for this project are published on Tableau Public:

https://public.tableau.com/shared/JYZ57XWWT?:display_count=n&:origin=viz_share_link