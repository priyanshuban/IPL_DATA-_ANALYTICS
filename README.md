# IPL Data Analytics — Python, SQL, Excel, Power BI & Statistics

## Project Overview
An end-to-end IPL cricket data analytics project built from Kaggle match and ball-by-ball data. The project demonstrates data cleaning, exploratory analysis, SQL querying, Excel reporting, Power BI dashboard design, and statistical interpretation.

## Tools
- **Python:** Pandas, NumPy, Matplotlib
- **SQL:** SQLite-compatible queries
- **Excel:** KPI summary, team/batting/bowling analysis
- **Power BI:** Interactive dashboard (build using the clean CSV files)
- **Statistics:** Descriptive statistics and confidence interval for toss → match outcome

## Dataset
Input files:
- `matches(1).csv`
- `deliveries(1).csv`

Cleaned files are in `data/`.

## Repository Structure
```text
IPL_Data_Analytics_GitHub_Project/
├── data/
│   ├── matches_clean.csv
│   ├── deliveries_clean.csv
│   ├── team_season_summary.csv
│   ├── batting_summary.csv
│   ├── bowling_summary.csv
│   ├── season_summary.csv
│   └── season_winners.csv
├── python/
│   └── ipl_analysis.py
├── sql/
│   └── ipl_analysis_queries.sql
├── excel/
│   └── IPL_Data_Analytics.xlsx
├── powerbi/
│   └── README_POWERBI.md
├── reports/
│   └── statistical_findings.md
├── requirements.txt
└── README.md
```

## How to Run Python
```bash
pip install -r requirements.txt
python python/ipl_analysis.py
```

## SQL
Import `data/matches_clean.csv` and `data/deliveries_clean.csv` into SQLite/PostgreSQL/MySQL, then run `sql/ipl_analysis_queries.sql`.

## Excel
Open `excel/IPL_Data_Analytics.xlsx`. The workbook contains KPI, team performance, batting, bowling, season and winner analysis sheets.

## Power BI
Use `data/matches_clean.csv` and `data/deliveries_clean.csv` as the two source tables. Follow `powerbi/README_POWERBI.md` for the model, DAX measures, visuals, and dashboard layout.

## Business Questions
1. Which teams have the strongest win percentage?
2. Who are the leading run scorers and wicket takers?
3. Does winning the toss correspond to winning the match?
4. How has the number of matches changed by season?
5. Which venues host the most matches?
6. Which dismissal types occur most often?
7. Which teams dominate particular seasons?

## Resume Project Description
**IPL Data Analytics Dashboard | Python, SQL, Excel, Power BI, Statistics**
- Analyzed 1,095 IPL matches and 260K+ ball-by-ball records to identify team, player, venue, and season performance trends.
- Cleaned and transformed match-level and delivery-level data using Python/Pandas and created reusable analytical datasets.
- Wrote SQL queries for KPIs including team wins, top run scorers, wicket takers, toss impact, and season trends.
- Built an Excel reporting workbook and designed a Power BI dashboard with DAX measures for interactive performance analysis.
- Applied descriptive statistics and a 95% confidence interval to evaluate the relationship between toss results and match outcomes.

## Interview Pitch
"I built an end-to-end IPL analytics project using match and ball-by-ball data. I cleaned the data with Python, created player and team performance metrics, used SQL for analytical queries, prepared an Excel reporting workbook, and designed a Power BI dashboard. I also used statistics to examine whether winning the toss was associated with winning the match. The main goal was to convert raw cricket data into decision-ready insights."
