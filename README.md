# 📊 Sales Funnel Analysis — BigQuery SQL + Consulting Report

> End-to-end sales funnel analysis using Google BigQuery to track user behavior from page view to purchase, measure conversion rates, and derive revenue insights — packaged as a full consulting-style business report.

---

## 👤 Author

**Mohammad Asad Rahmani**

GitHub: [@rahmani3101](https://github.com/rahmani3101)

---

## 📁 Project Overview

This project analyzes a complete e-commerce sales funnel using **Google BigQuery (Standard SQL)**. Starting from raw user event data, the queries uncover where users drop off, which traffic sources convert best, how long it takes users to purchase, and how revenue flows through the funnel.

The findings are synthesized into a **professional consulting report** (.docx) with strategic recommendations, KPI summaries, and projected business impact — bridging the gap between raw data and real business decisions.

---

## 🗂️ Repository Structure

```
📦 sales-funnel-analysis
 ┣ 📄 sales_funnel_analysis.sql         # All BigQuery SQL queries
 ┣ 📄 Sales_Funnel_Analysis_Report.docx # Full consulting report
 ┣ 📄 README.md                         # Project documentation
 ┗ 📁 dataset/                          # Sample dataset (if included)
```

---

## 📋 Consulting Report Highlights

The `.docx` report covers the complete analytical lifecycle:

| Section | Content |
|---|---|
| Executive Summary | Key findings, strategic impact, top-line recommendations |
| Problem Statement | Root cause analysis of revenue inefficiency |
| Data Insights | Funnel conversion breakdown, channel performance table |
| Strategic Recommendations | 4 actionable strategies with expected outcomes |
| Projected Business Impact | CAC reduction targets, ROI estimates, LTV improvement |
| Key Consulting Takeaway | Core strategic principle driving the analysis |

**Top findings from the report:**
- Checkout Start → Purchase conversion: **80%+** (operationally strong)
- Social Media drives **~30% of traffic** but converts at only **~6%** (low efficiency)
- Email converts at **13%+** — the highest-performing channel, significantly under-leveraged
- Average Order Value: **$115** with no CAC guardrails in place

---

## 🔍 SQL Analyses Included

### 1. 🧪 Funnel Stage Counts
Counts distinct users at each stage of the funnel (page view → add to cart → checkout → payment → purchase) over the last 30 days.

### 2. 📉 Conversion Rate Analysis
Calculates step-by-step and overall conversion rates across all 5 funnel stages.

### 3. 🌐 Funnel by Traffic Source
Breaks down views, carts, and purchases by acquisition channel to identify the highest-performing sources.

### 4. ⏱️ Time-to-Conversion Analysis
For completed purchasers, measures average time from view → cart, cart → purchase, and total journey duration (in minutes).

### 5. 💰 Revenue Funnel Analysis
Aggregates total revenue, orders, AOV, revenue per buyer, and revenue per visitor.

---

## 🗃️ Dataset

| Field | Description |
|---|---|
| `user_id` | Unique identifier per user |
| `event_type` | Funnel stage event (`page_view`, `add_to_cart`, `checkout_start`, `payment_info`, `purchase`) |
| `event_date` | Timestamp of the event |
| `traffic_source` | Acquisition channel (organic, paid, social, email, etc.) |
| `amount` | Transaction value for purchase events |

**BigQuery Table:** `sales-funnel-analysis-487918.users.user_events`

---

## 🛠️ Tech Stack

- **Google BigQuery** — Cloud data warehouse & SQL engine
- **Standard SQL** — CTEs, conditional aggregation, timestamp functions
- **Google Cloud Platform (GCP)** — Project hosting
- **Microsoft Word / docx** — Consulting report format

---

## 🚀 How to Run the Queries

1. Upload the dataset to your BigQuery project under `your-project.users.user_events`
2. Open the [BigQuery Console](https://console.cloud.google.com/bigquery)
3. Copy any query from `sales_funnel_analysis.sql`
4. Update the project/dataset reference to match your own
5. Run and explore results

---

## 📌 Key SQL Concepts Used

- `WITH` (Common Table Expressions / CTEs)
- `COUNT(DISTINCT CASE WHEN ...)` for conditional funnel counting
- `TIMESTAMP_DIFF` for time-between-events analysis
- `HAVING` clause for filtering aggregated results
- `DATE_SUB` + `CURRENT_DATE()` for rolling 30-day windows
- `ROUND` for clean percentage formatting
- `GROUP BY` with multi-metric aggregation

---

## 💡 Strategic Recommendations Summary

| Action | Expected Outcome |
|---|---|
| Preserve existing checkout flow | Protect 80%+ conversion rate |
| Reallocate social spend to retargeting | Lower blended CAC, higher ROAS |
| Scale email as core revenue engine | Higher LTV, reduced acquisition dependency |
| Implement CAC governance ($30–$40 ceiling) | Sustainable unit economics |

> **Key Takeaway:** Revenue growth does not come from increasing traffic — it comes from improving traffic quality and enforcing financial discipline.

---

*Built as part of a data engineering & analytics portfolio. Full strategic analysis available in the consulting report.*
