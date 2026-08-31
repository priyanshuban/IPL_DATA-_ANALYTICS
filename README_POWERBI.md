# Power BI Dashboard Guide

## 1. Load Data
Import:
- `../data/matches_clean.csv`
- `../data/deliveries_clean.csv`

## 2. Data Model
Create relationship:
- `matches[id]` → `deliveries[match_id]`
- Cardinality: One-to-many
- Cross-filter: Single direction from matches to deliveries

## 3. Recommended DAX Measures
```DAX
Total Matches = DISTINCTCOUNT(matches[id])

Total Runs = SUM(deliveries[total_runs])

Batting Runs = SUM(deliveries[batsman_runs])

Total Wickets = SUM(deliveries[is_wicket])

Toss & Match Win % =
DIVIDE(
    CALCULATE([Total Matches], matches[toss_winner] = matches[winner]),
    CALCULATE([Total Matches], NOT ISBLANK(matches[winner]))
) * 100
```

## 4. Dashboard Pages

### Page 1 — Executive Overview
Cards:
- Total Matches
- Total Runs
- Total Wickets
- Seasons
- Toss & Match Win %

Charts:
- Matches by Season
- Wins by Team
- Toss Decision Split
- Top 10 Run Scorers

### Page 2 — Player Analysis
- Top run scorers
- Top wicket takers
- Strike rate
- Economy
- Fours and sixes

### Page 3 — Team & Venue Analysis
- Team win percentage
- Season filter
- Venue match count
- Team-vs-team performance

## 5. Recommended Slicers
- Season
- Team
- Venue
- Match Type
- Toss Decision

## dashboars
