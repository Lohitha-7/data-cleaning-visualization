# data-cleaning-visualization
An end-to-end data analytics project focused on preprocessing raw datasets, handling outliers/missing values, and building visual data stories using Pandas, Matplotlib, and Seaborn.
# Data Cleaning & Visualization Project

## 📌 Project Overview
This project demonstrates end-to-end data preprocessing, exploratory data analysis (EDA), and data storytelling using Python. The goal is to take a messy, raw dataset, transform it into a clean format, and extract actionable insights through visualization.

### Key Features
* **Data Cleaning:** Handled missing values, treated outliers using the IQR method, and dropped duplicate records.
* **Data Processing:** Standardized column types and engineered new features for better analysis.
* **Data Visualization:** Created distribution plots, correlation matrices, and trend lines using Matplotlib and Seaborn.

---

## 🛠️ Tech Stack & Tools
* **Language:** Python 3.x
* **Libraries:** Pandas, NumPy, Matplotlib, Seaborn

---
pip install -r requirements.txt
---

## 🐍 Core Python Script (`src/data_pipeline.py`)
*Save this code in your `src/` directory. It uses a mock dataset generation so you can run it immediately, but you can swap it out for your own `raw_data.csv` easily.*

```python
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Ensure directories exist
os.makedirs("data", exist_ok=True)
os.makedirs("visuals", exist_ok=True)


def generate_mock_data():
    """Generates a messy dataset for demonstration purposes."""
    np.random.seed(42)
    n_samples = 200

    data = {
        "User_ID": range(1000, 1000 + n_samples),
        "Age": np.random.choice(
            [20, 25, 30, 35, 40, np.nan, 150], size=n_samples, p=[0.2, 0.2, 0.2, 0.2, 0.15, 0.03, 0.02]
        ),
        "Income": np.random.normal(55000, 15000, n_samples),
        "Score": np.random.randint(1, 100, n_samples),
    }

    df = pd.DataFrame(data)
    # Inject a few explicit duplicates
    df = pd.concat([df, df.iloc[[10, 25, 50]]], ignore_index=True)
    df.to_csv("data/raw_data.csv", index=False)
    print("✅ Messy 'raw_data.csv' generated in /data directory.")


def clean_and_visualize():
    # 1. Load Data
    df = pd.read_csv("data/raw_data.csv")
    print(f"\nInitial shape: {df.shape}")

    # 2. Handle Duplicates
    df.drop_duplicates(inplace=True)
    print(f"Shape after removing duplicates: {df.shape}")

    # 3. Handle Missing Values
    # Fill missing Age with the median age
    median_age = df["Age"].median()
    df["Age"].fillna(median_age, inplace=True)
    print("Missing values in 'Age' imputed with median.")

    # 4. Handle Outliers (IQR Method for Age as an example)
    # Removing the unrealistic '150' age outlier injected earlier
    q1 = df["Age"].quantile(0.25)
    q3 = df["Age"].quantile(0.75)
    iqr = q3 - q1
    lower_bound = q1 - 1.5 * iqr
    upper_bound = q3 + 1.5 * iqr

    df = df[(df["Age"] >= lower_bound) & (df["Age"] <= upper_bound)]
    print(f"Shape after removing Age outliers: {df.shape}")

    # Save Cleaned Data
    df.to_csv("data/cleaned_data.csv", index=False)
    print("✅ Cleaned data saved to 'data/cleaned_data.csv'")

    # 5. Data Visualization
    print("\nGenerating plots...")
    sns.set_theme(style="whitegrid")

    # Plot 1: Age Distribution
    plt.figure(figsize=(8, 5))
    sns.histplot(df["Age"], kde=True, color="skyblue")
    plt.title("Distribution of Age (Cleaned)")
    plt.savefig("visuals/distribution_plot.png", dpi=300)
    plt.close()

    # Plot 2: Correlation Heatmap
    plt.figure(figsize=(6, 4))
    sns.heatmap(df[["Age", "Income", "Score"]].corr(), annot=True, cmap="coolwarm", fmt=".2f")
    plt.title("Correlation Matrix")
    plt.tight_layout()
    plt.savefig("visuals/correlation_matrix.png", dpi=300)
    plt.close()

    print("✅ Visuals saved successfully in /visuals directory.")


if __name__ == "__main__":
    generate_mock_data()
    clean_and_visualize()
