"""
IPL DATA ANALYTICS — PYTHON / PANDAS
Run: python python/ipl_analysis.py
"""
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
matches = pd.read_csv(ROOT/"data/matches_clean.csv", parse_dates=["date"])
deliveries = pd.read_csv(ROOT/"data/deliveries_clean.csv")

# 1. Overview
print("Matches:", matches.shape)
print("Deliveries:", deliveries.shape)
print("Seasons:", matches["season"].nunique())

# 2. Team performance
team = pd.concat([
    matches[["season","team1"]].rename(columns={"team1":"team"}),
    matches[["season","team2"]].rename(columns={"team2":"team"})
]).value_counts(["season","team"]).reset_index(name="matches_played")
wins = matches.dropna(subset=["winner"]).groupby(["season","winner"]).size().reset_index(name="wins")
team = team.merge(wins, left_on=["season","team"], right_on=["season","winner"], how="left").drop(columns="winner")
team["wins"] = team["wins"].fillna(0)
team["win_pct"] = team["wins"]/team["matches_played"]*100

# 3. Batting
bat = deliveries.groupby("batter").agg(
    runs=("batsman_runs","sum"),
    balls=("batsman_runs","size"),
    fours=("batsman_runs", lambda x: (x==4).sum()),
    sixes=("batsman_runs", lambda x: (x==6).sum())
).reset_index()
bat["strike_rate"] = bat["runs"]/bat["balls"]*100

# 4. Bowling
wk = deliveries[(deliveries.is_wicket==1) &
                 (~deliveries.dismissal_kind.isin(["run out","retired hurt","obstructing the field"]))]
bowl = deliveries.groupby("bowler").agg(
    runs_conceded=("total_runs","sum"), balls=("total_runs","size")
).reset_index()
bowl["overs"] = bowl["balls"]/6
bowl["economy"] = bowl["runs_conceded"]/bowl["overs"]
w = wk.groupby("bowler").size().reset_index(name="wickets")
bowl = bowl.merge(w, on="bowler", how="left").fillna({"wickets":0})

# 5. Statistical question: does winning the toss relate to winning?
valid = matches.dropna(subset=["winner"])
toss_win_rate = (valid["toss_winner"] == valid["winner"]).mean()*100
print(f"Toss winner also won match: {toss_win_rate:.2f}%")

# 6. Export analysis tables
(ROOT/"reports").mkdir(exist_ok=True)
team.to_csv(ROOT/"reports/team_performance_python.csv", index=False)
bat.sort_values("runs", ascending=False).to_csv(ROOT/"reports/batting_python.csv", index=False)
bowl.sort_values("wickets", ascending=False).to_csv(ROOT/"reports/bowling_python.csv", index=False)

# 7. Visualizations
plt.figure(figsize=(10,5))
matches.groupby("season")["id"].count().plot(kind="bar")
plt.title("IPL Matches by Season")
plt.xlabel("Season"); plt.ylabel("Matches")
plt.tight_layout(); plt.savefig(ROOT/"reports/matches_by_season.png", dpi=160); plt.close()

plt.figure(figsize=(10,5))
bat.nlargest(10,"runs").sort_values("runs").plot(x="batter", y="runs", kind="barh", legend=False)
plt.title("Top 10 Run Scorers")
plt.xlabel("Runs"); plt.ylabel("Batter")
plt.tight_layout(); plt.savefig(ROOT/"reports/top_run_scorers.png", dpi=160); plt.close()

print("Analysis complete. See reports/ for outputs.")
