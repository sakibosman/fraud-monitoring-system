import pandas as pd
df = pd.read_csv("C:/Users/User/Desktop/fraud-monitoring-system/data/fraud_data.csv")

# Fraud Rules

def detect_fraud_risk(row):

    score = 0

    # Rule 1: High dollar loss
    if row["dollar_loss"] > 50000:
        score += 3

    elif row["dollar_loss"] > 10000:
        score += 2

    # Rule 2: High risk fraud categories
    high_risk_categories = [
        "Investments",
        "Romance",
        "Spear Phishing",
        "Extortion"
    ]

    if row["fraud_category"] in high_risk_categories:
        score += 2

    # Rule 3: High risk solicitation methods
    high_risk_methods = [
        "Internet-social network",
        "Email",
        "Direct call"
    ]

    if row["method"] in high_risk_methods:
        score += 1

    # Rule 4: High risk age groups
    if row["age_range"] in ["60 - 69", "70 - 79", "80 - 89"]:
        score += 1

    # Scoring Engine

    if score >= 5:
        return "HIGH RISK - Block"

    elif score >= 3:
        return "MEDIUM RISK - Escalate"

    else:
        return "LOW RISK - Approve"


# Apply fraud detection rules
df["risk_level"] = df.apply(detect_fraud_risk, axis=1)
print("\nFraud Risk Distribution:")
print(df["risk_level"].value_counts())

# Top high risk cases
high_risk_cases = df[df["risk_level"] == "HIGH RISK"]

print("\nTop High Risk Cases:")
print(high_risk_cases.head(10))

#Overwrite Dataset
df.to_csv("C:/Users/User/Desktop/fraud-monitoring-system/data/fraud_flagged.csv", index=False)

print("\nFraud Detection Successful")