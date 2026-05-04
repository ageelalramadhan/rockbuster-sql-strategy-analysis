# Rockbuster Stealth — SQL Strategy Analysis

A PostgreSQL analysis of Rockbuster Stealth, a fictional online video rental
service preparing to launch a streaming platform. The leadership team
needed an evidence-based view of where revenue actually comes from before
deciding how to allocate the launch budget.

This repository contains every SQL query, every CSV export, the data
dictionary, the ERD, and the final findings deck.

**Tools:** PostgreSQL · pgAdmin 4 · Tableau Public

**Live case study:** [ageelalramadhan.github.io/rockbuster-case-study.html](https://ageelalramadhan.github.io/rockbuster-case-study.html)
**Tableau dashboard:** [Rockbuster Findings — Task 3.10](https://public.tableau.com/app/profile/a.a5244/viz/RockbusterFindingsTask3_10_17646887206150/Top10Countries)

---

## The brief

Rockbuster's leadership wanted to know:

1. Which movies contributed the most/least to revenue?
2. Which customers paid the highest lifetime totals?
3. What is Rockbuster's geographic customer footprint?
4. Are most customers concentrated in a small number of cities or spread
   evenly across the world?

The answers shape decisions on regional marketing budgets, retention
spending, and catalog investment.

## Headline numbers

| Metric | Value |
|---|---|
| Tables in the database | 15 (3 fact · 2 bridge · 10 dimension) |
| Films in catalog | 1,000 |
| Customers | 599 |
| Stores | 2 |
| Top country by customer count | India (60) |
| Highest-paying customer | Zachary Hite — **$134.71** |
| Average spend among top 5 customers | **$108.54** |
| Most common film rating | PG-13 |
| Avg rental rate | $2.98 |
| Avg film length | 115 min |

## Schema

Snowflake schema with country → city → address normalisation and
film → language / film → category lookup chains. See
[`docs/ERD.png`](docs/ERD.png) for the full diagram and
[`docs/Data_Dictionary.pdf`](docs/Data_Dictionary.pdf) for column-level
documentation.

## Repository layout

```
sql/                  Numbered SQL scripts, runnable against the Rockbuster DB
  03_5_filtering.sql      Title/length/rate/duration filters (WHERE, ILIKE, IN, BETWEEN)
  03_6_summarising.sql    Data-quality scan + descriptive stats + MODE
  03_7_joins.sql          Top-10 countries, top-10 cities, top-5 customers
  03_8_subqueries.sql     "Avg of top 5" using a nested subquery
  03_9_ctes.sql           Same answers as 3.8 — refactored with CTEs

data/                 CSV / XLSX outputs from each query
  35_1a..1e_*.csv         Filtered film lists
  36_*.csv                Descriptive-statistics outputs
  Task_3_10_Final_Output.xlsx   Combined workbook used to build the dashboard
  schema_overview.csv     All 133 columns × 15 tables, with data types

docs/
  ERD.png                 Entity-relationship diagram
  Data_Dictionary.pdf     Final data dictionary (Achievement 3)
  Final_Findings_Task_3_10.pdf   Executive summary deck

dashboards/             Tableau exports (PNG snapshots of each tab)
```

## How to run

The scripts assume a PostgreSQL database named `rockbuster` restored
from the standard course backup. Each file is independent and
read-only — none of them modify the schema.

```bash
psql -d rockbuster -f sql/03_7_joins.sql
```

To reproduce the dashboard, open `data/Task_3_10_Final_Output.xlsx` in
Tableau Desktop or upload the CSVs in `data/` to Tableau Public.

## Headline finding

City-level segmentation is too fragmented to support strategic action —
**Aurora is the only city with more than one customer**; every other city
in the top 10 has exactly one. Country-level focus is the right unit for
go-to-market planning.

A small group of repeat customers drives outsized revenue: the top 5
customers each spend between **$98 and $135**, well above the average
ticket. Premium retention programmes for this tier offer better ROI
than scaling acquisition.

---

**Author:** Ageel Alramadhan — Data Analyst, Hamburg
[Portfolio](https://ageelalramadhan.github.io) · [LinkedIn](https://www.linkedin.com/in/ageel-alramadhan/)
