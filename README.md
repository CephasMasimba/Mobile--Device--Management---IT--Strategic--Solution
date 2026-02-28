# IT Strategy: Quantitative Decision Analysis

A data-driven approach to IT infrastructure strategy and vendor selection. This project demonstrates how to bridge the gap between business requirements and technical implementation using a weighted decision matrix.

## 📊 Project Overview
This repository showcases a professional "Strategic Recommendation" workflow. It uses a **PostgreSQL-driven decision model** to evaluate Enterprise SaaS solutions against specific business constraints (Cost, Security, Scalability).

## 🛠️ The Technical "Home-Brewn" Model
While the final report provides the executive summary, the underlying logic is powered by a relational data model:
- **Requirements Weighting:** Assigning business-value weights to technical needs.
- **Vendor Scoring:** Quantifying platform performance across categories.
- **Weighted Analytics:** A PostgreSQL view that calculates the final "Winning Recommendation" based on weighted score gaps.

## 📁 Repository Structure
- `/sql`: PostgreSQL scripts containing the decision matrix schema, data, and analytical views.
- `/docs`: The Final Strategic Recommendation Report (Anonymized).
- `README.md`: Project overview and methodology.

## 📈 Key Outcomes
- **Technical Rigor:** Moved the decision process from "gut feel" to a reproducible, data-driven SQL model.
- **Cost Optimization:** Identified a solution path that begins at $0 CAPEX while maintaining an enterprise growth path.
- **Strategic Alignment:** Directly linked technical features (UEM/MDM) to business risks (Data Privacy/Operational Velocity).

## 🚀 How to Run the Analysis
1. Load the [SQL Schema](/sql/decision_matrix.sql) into your local PostgreSQL instance.
2. Query the recommendation view:
   ```sql
   SELECT * FROM strategy.recommendation_summary;
   ```
3. Read the [Strategic Report](/docs/Recommendation-Report.md) to see how the data translates into business decisions.

---
*Created by [Cephas Masimba](https://github.com/CephasMasimba)*
