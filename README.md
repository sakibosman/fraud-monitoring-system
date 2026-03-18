# Fraud Monitoring System

This project demonstrates a comprehensive fraud monitoring pipeline designed to identify, score, and visualize suspicious financial activities. The system provides an end-to-end solution for detecting fraud in high-volume transaction environments.

---

## Business Problem

Financial institutions face billions in losses annually due to increasingly sophisticated fraudulent schemes. The challenge lies in distinguishing legitimate transactions from high-risk activities in real-time without disrupting the customer experience. This project addresses the need for a scalable monitoring system that can flag suspicious patterns—such as investment scams and identity theft—and categorize them into actionable risk levels (Approve, Escalate, or Block).

---

## Dataset Information

> **Note on Data Volume:** The original dataset contains over 350,000 records. To optimize for repository performance and storage, `data/fraud_data.csv` and `data/fraud_flagged.csv` have been reduced to the first **10,000 rows**. However, the insights provided in the SQL analysis and the dashboard reflect findings from the full-scale dataset.

* **Original Source:** [Open Government Portal - Canadian Anti-Fraud Centre Reporting Data](https://open.canada.ca/data/en/dataset/6a09c998-cddb-4a22-beff-4dca67ab892f/resource/43c67af5-e598-4a9b-a484-fe1cb5d775b5)

---

## Project Objectives

* **Data Integrity:** Standardize and clean raw transaction logs to ensure high-quality analysis.
* **Risk Identification:** Implement a multi-factor rule-based scoring engine to quantify transaction risk.
* **Operational Intelligence:** Provide data-driven insights into fraud trends across demographics and solicitation methods.
* **Executive Visualization:** Build an automated dashboard to track Key Performance Indicators (KPIs) such as total dollar loss and high-risk clusters.

---

## Data Pipeline

The system follows a structured ETL and analysis workflow:
1.  **Ingestion:** Raw transaction data is stored in the `data/` directory.
2.  **Processing (SQL):** Aggregation and high-level trend analysis are performed to identify macro-patterns.
3.  **Refinement (Python):** Data is cleaned and preprocessed for the scoring engine.
4.  **Scoring:** A rule-based logic engine assigns risk scores to every record.
5.  **Visualization:** Finalized datasets are exported to Tableau for reporting.

---

## Project Structure

```text
├── data/
│   ├── fraud_data.csv             # Sampled dataset (10k rows)
│   └── fraud_flagged.csv          # Sampled dataset after fraud scoring
├── sql/
│   ├── fraud_analysis.sql         # SQL queries for full-scale fraud insights
│   └── sql_analysis_results/      # CSV outputs of SQL queries (Full dataset)
├── python/
│   ├── fraud_data_cleaning.ipynb  # Data preprocessing and cleaning
│   ├── fraud_analysis.ipynb       # Exploratory data analysis (EDA)
│   └── fraud_scoring_engine.py    # Rule-based fraud detection engine
├── dashboard/
│   └── dashboard.png              # Tableau dashboard visualization
└── README.md
```
---

## Fraud Detection Methodology

The `fraud_scoring_engine.py` employs a cumulative scoring system where points are assigned based on historical risk indicators. Transactions are classified based on the following thresholds:

| Risk Score | Action | Logic Criteria |
| :--- | :--- | :--- |
| **0 - 2** | **LOW RISK - Approve** | Standard transactions with no high-risk flags. |
| **3 - 4** | **MEDIUM RISK - Escalate** | Presence of risky categories (e.g., Extortion) or solicitation methods. |
| **5+** | **HIGH RISK - Block** | Combines high-dollar value (>$10,000) with known high-risk sectors (e.g., Investments). |

**Key Rules Applied:**
* **Monetary Thresholds:** Weighted scoring for transactions exceeding $10k and $50k.
* **Sector Risk:** Automated flagging for high-risk categories like Investments, Romance, and Spear Phishing.
* **Demographic Vulnerability:** Increased monitoring for age groups historically targeted by specific fraud methods.

---

## Key Insights

* **Primary Loss Drivers:** Investment fraud accounts for over 50% of total financial losses, despite lower report volume, indicating high-severity individual impacts.
* **Vector Analysis:** Internet-based solicitation and direct calls remain the most effective methods for high-value fraud, particularly targeting the 60–79 age demographic.
* **Efficiency Gains:** The rule-based engine successfully filtered 75% of reports as "Low Risk," allowing investigators to focus exclusively on the 25% of cases causing significant financial impact.

---

## Dashboard Visualization

The Tableau dashboard (`Canadian Fraud Analysis Dashboard.png`) provides a real-time view of the fraud landscape:

* **Risk Level Distribution:** A circle graph visualizing the breakdown of transactions categorized by the scoring engine into Low, Medium, and High risk tiers.
* **Trend Analysis:** A Monthly Fraud Trend chart comparing the volume of reports against the total financial loss to identify seasonal spikes and patterns.
* **Categorical Breakdown:** A visualization of fraud types and solicitation methods, highlighting which vectors—such as direct calls or social media—yield the highest financial impact.
* **KPI Tiles:** High-level metrics showing Total Reports, Cumulative Dollar Loss, and Average Loss per case for immediate executive review.

> **Development Status:** This dashboard is currently being improved to include real-time data streaming capabilities.

---

## Tech Stack

* **Languages:** Python (Pandas, NumPy), SQL (PostgreSQL/Redshift)
* **Visualization:** Tableau
* **Infrastructure:** AWS Deployment (S3 for raw storage, Redshift for warehousing)

---

## Future Improvements

* **Machine Learning Integration:** Transition from rule-based scoring to an Isolation Forest or Random Forest model for anomaly detection.
* **Streaming Analytics:** Implementing AWS Lambda to trigger the scoring engine in real-time upon transaction entry.
* **Advanced Feature Engineering:** Incorporating velocity checks (e.g., number of transactions in the last hour).

---
