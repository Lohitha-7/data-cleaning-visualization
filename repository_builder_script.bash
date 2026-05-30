#!/bin/bash

# ==============================================================================
# GitHub Repository Automator: Data Cleaning & Visualization Project
# This script builds the entire portfolio-ready directory structure and 
# populates it with starter code, configuration files, and documentation.
# ==============================================================================

echo "🚀 Starting repository generation process..."

# 1. Create directory structure
echo "📁 Creating folders..."
mkdir -p data src visuals notebooks

# 2. Generate requirements.txt
echo "📝 Writing requirements.txt..."
cat << 'EOF' > requirements.txt
pandas>=2.0.0
numpy>=1.24.0
matplotlib>=3.7.0
seaborn>=0.12.0
EOF

# 3. Generate .gitignore (Python specialized)
echo "🙈 Writing .gitignore..."
cat << 'EOF' > .gitignore
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]
*$py.class

# C extensions
*.so

# Distribution / packaging
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
share/python-wheels/
*.egg-info/
.installed.cfg
*.egg

# Jupyter Notebook checkpoints
.ipynb_checkpoints

# Local datasets and generated visuals (keep structure, ignore local temporary output if desired)
# For this starter, we will let users commit the final visual images to show on README,
# but we ignore heavy system check files or local ide configs:
.DS_Store
.vscode/
.idea/
venv/
env/
ENV/
EOF

# 4. Generate MIT License
echo "📜 Writing MIT LICENSE..."
CURRENT_YEAR=$(date +"%Y")
cat << EOF > LICENSE
MIT License

Copyright (c) $CURRENT_YEAR Data Explorer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# 5. Generate README.md
echo "📘 Writing README.md..."
cat << 'EOF' > README.md
# Data Cleaning & Visualization Pipeline

An end-to-end data science portfolio project demonstrating professional data preprocessing, exploratory data analysis (EDA), anomaly handling, and data storytelling using Python.

## 📌 Project Overview
This project targets the common challenges of raw, real-world datasets—such as **missing entries, extreme outliers, duplicated records, and inconsistent data types**—and transforms them into high-value, clean datasets ready for downstream machine learning or business intelligence. 

### Key Capabilities Included:
* **Robust Preprocessing:** Automation of duplicate checks, logical data casting, and statistical imputations.
* **Outlier Engineering:** Statistical isolation of extreme distribution tails using the Interquartile Range (IQR) threshold.
* **Data Storytelling:** Visual generation of distribution insights and high-fidelity feature correlation charts.

---

## 🛠️ Tech Stack & Dependencies
* **Core Runtime:** Python 3.8+
* **Data Manipulation:** `pandas`, `numpy`
* **Visualization Engine:** `matplotlib`, `seaborn`

---

## 📂 Repository Blueprint
```text
├── data/
│   ├── raw_data.csv          # Simulated/messy dataset (input)
│   └── cleaned_data.csv      # Processed, standardized dataset (output)
├── notebooks/
│   └── exploration.ipynb     # Jupyter Notebook scratchpad for prototyping
├── src/
│   └── data_pipeline.py      # Automated pipeline script (reusable modules)
├── visuals/
│   ├── distribution_plot.png # Visual insight: Cleaned Feature Distributions
│   └── correlation_matrix.png# Visual insight: Multi-variable Relationships
├── .gitignore                # Optimized rule-file to exclude cache/env files
├── LICENSE                   # MIT Open Source License file
├── requirements.txt          # Library dependencies specification
└── README.md                 # Interactive portfolio documentation
```

---

## 🚀 Quick Start Guide

### 1. Initialize Virtual Environment & Install Dependencies
First, clone this repository to your local workstation. Create a virtual environment and load the required library list:
```bash
# Clone the repository
git clone [https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git](https://github.com/YOUR_USERNAME/YOUR_REPOSITORY_NAME.git)
cd YOUR_REPOSITORY_NAME

# Setup python virtual environment
python -m venv env
source env/bin/activate  # On Windows, use: env\Scripts\activate

# Install requirements
pip install -r requirements.txt
```

### 2. Run the Processing Pipeline
Execute the pipeline engine to auto-generate sample raw data, clean it, and export production-ready charts:
```bash
python src/data_pipeline.py
```

---

## 📊 Key Insights & Visualizations

Upon executing the data pipeline successfully, visual plots are exported directly to the `/visuals` folder for diagnostic review:

### Feature Linear Association
This matrix analyzes linear relationships between different numerical components of the cleaned target audience:

![Correlation Matrix](visuals/correlation_matrix.png)

### Cleaned Demographic Features
We track the visual outcome of our statistical outlier removal steps to inspect distribution shapes:

![Distribution Plot](visuals/distribution_plot.png)

---

## 📈 Expected Outcomes & Portfolio Takeaways
* **Operational Pipelines:** Transitioned functional prototype steps into modular, reusable pipeline scripts.
* **Aggressive Anomaly Resolution:** Mastered quantitative outlier isolation utilizing standard statistical heuristics ($Q1 - 1.5 \times IQR$ and $Q3 + 1.5 \times IQR$).
* **Aesthetic Standardizations:** Implemented Seaborn configurations that emphasize data clarity, high contrast, and clean layout patterns for stakeholder delivery.
EOF

# 6. Generate Core Python Pipeline script
echo "🐍 Writing src/data_pipeline.py..."
cat << 'EOF' > src/data_pipeline.py
"""
Data Cleaning & Visualization Pipeline Engine
Author: Portfolio Project Template
Description: Performs synthetic messy data simulation, performs professional preprocessing 
             (null imputation, outlier clipping, deduplication), and writes analytical plots.
"""

import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Configure global execution output directories
RAW_DATA_PATH = "data/raw_data.csv"
CLEANED_DATA_PATH = "data/cleaned_data.csv"
DIST_PLOT_PATH = "visuals/distribution_plot.png"
CORR_PLOT_PATH = "visuals/correlation_matrix.png"

def simulate_dirty_dataset():
    """
    Generates a highly corrupted mock dataset with duplicates,
    missing values, invalid types, and extreme outliers to simulate real-world data issues.
    """
    print("⏳ Simulating raw dirty data streams...")
    np.random.seed(42)
    sample_size = 250
    
    # Base structural properties
    user_ids = range(1001, 1001 + sample_size)
    
    # Age generation with natural gaps, structural nan values, and a physical outlier (e.g., age 175)
    ages = np.random.choice(
        [18, 22, 29, 35, 42, 55, np.nan, 175], 
        size=sample_size, 
        p=[0.25, 0.25, 0.20, 0.15, 0.08, 0.04, 0.02, 0.01]
    )
    
    # Incomes containing realistic noise
    incomes = np.random.normal(loc=62000, scale=18000, size=sample_size)
    
    # Scores (1 to 100 scale)
    scores = np.random.randint(low=1, high=101, size=sample_size)
    
    df = pd.DataFrame({
        "User_ID": user_ids,
        "Age": ages,
        "Income": incomes,
        "Performance_Score": scores
    })
    
    # Inject deliberate exact duplicates (5 rows)
    duplicates = df.iloc[[12, 45, 87, 103, 199]]
    df = pd.concat([df, duplicates], ignore_index=True)
    
    # Write to local file
    df.to_csv(RAW_DATA_PATH, index=False)
    print(f"✅ Generated and saved raw dataset containing {df.shape[0]} rows to: {RAW_DATA_PATH}")


def run_preprocessing_pipeline():
    """
    Ingests raw dataset, cleans outliers, missing items, and duplicates, 
    and outputs the visualizations into portfolio directory targets.
    """
    if not os.path.exists(RAW_DATA_PATH):
        raise FileNotFoundError(f"Input file {RAW_DATA_PATH} not found. Please run simulations first.")
        
    print("\n⚡ Initializing Cleaning Pipeline...")
    df = pd.read_csv(RAW_DATA_PATH)
    print(f"📊 Input shape: {df.shape}")
    
    # Step A: Duplicate Removal
    duplicated_count = df.duplicated().sum()
    df.drop_duplicates(inplace=True)
    print(f"🧹 Removed {duplicated_count} duplicate records.")
    
    # Step B: Missing Values Imputation
    null_count = df["Age"].isnull().sum()
    median_age = df["Age"].median()
    df["Age"] = df["Age"].fillna(median_age)
    print(f"🧹 Imputed {null_count} nulls in 'Age' column using dataset median age ({median_age}).")
    
    # Step C: Outlier Mitigation using IQR Method on 'Age'
    q1 = df["Age"].quantile(0.25)
    q3 = df["Age"].quantile(0.75)
    iqr = q3 - q1
    lower_limit = q1 - (1.5 * iqr)
    upper_limit = q3 + (1.5 * iqr)
    
    # Filter rows inside the standard IQR interval bounds
    pre_outlier_count = df.shape[0]
    df = df[(df["Age"] >= lower_limit) & (df["Age"] <= upper_limit)]
    post_outlier_count = df.shape[0]
    print(f"🧹 Filtered {pre_outlier_count - post_outlier_count} age outliers outside boundary interval [{lower_limit:.1f}, {upper_limit:.1f}].")
    
    # Save the pipeline outcome
    df.to_csv(CLEANED_DATA_PATH, index=False)
    print(f"💾 Production data exported to: {CLEANED_DATA_PATH}")
    
    # Step D: Pipeline Visualization Generation
    print("\n🎨 Generating professional visual plots...")
    sns.set_theme(style="ticks")
    
    # Plot 1: Age Distribution Histogram
    plt.figure(figsize=(10, 6))
    sns.histplot(df["Age"], kde=True, color="#4A90E2", bins=12, edgecolor="black", alpha=0.7)
    plt.axvline(df["Age"].mean(), color="red", linestyle="dashed", linewidth=1.5, label=f"Mean: {df['Age'].mean():.1f}")
    plt.axvline(df["Age"].median(), color="green", linestyle="dotted", linewidth=1.5, label=f"Median: {df['Age'].median():.1f}")
    plt.title("Distribution profile of Cleaned Demographic Age Feature", fontsize=14, pad=15, fontweight="bold")
    plt.xlabel("Age Group", fontsize=11)
    plt.ylabel("Data Frequency Count", fontsize=11)
    plt.legend(frameon=True, shadow=True)
    sns.despine(top=True, right=True)
    plt.tight_layout()
    plt.savefig(DIST_PLOT_PATH, dpi=300)
    plt.close()
    print(f"📈 Distribution plot successfully saved to: {DIST_PLOT_PATH}")
    
    # Plot 2: Correlation Heatmap Matrix
    plt.figure(figsize=(8, 6))
    corr_matrix = df[["Age", "Income", "Performance_Score"]].corr()
    mask = np.triu(np.ones_like(corr_matrix, dtype=bool)) # Elegant upper-triangle mask
    
    sns.heatmap(
        corr_matrix, 
        mask=mask,
        annot=True, 
        cmap="coolwarm", 
        fmt=".2f", 
        linewidths=1.0, 
        square=True,
        cbar_kws={"shrink": 0.8}
    )
    plt.title("Pearson Correlation Coefficient Metrics", fontsize=14, pad=15, fontweight="bold")
    plt.tight_layout()
    plt.savefig(CORR_PLOT_PATH, dpi=300)
    plt.close()
    print(f"📈 Correlation heatmap successfully saved to: {CORR_PLOT_PATH}")


if __name__ == "__main__":
    simulate_dirty_dataset()
    run_preprocessing_pipeline()
    print("\n🎉 Setup complete. Ready to publish on GitHub!")
EOF

# 7. Initialize Git Repository
echo "⚙️ Initializing Local Git Repository..."
git init
git add .
git commit -m "Initial commit: Set up pipeline file structure, requirements, .gitignore, and script engine"

echo "========================================================================="
echo "⭐ Repository Setup Complete!"
echo "========================================================================="
echo "To get everything working on your computer:"
echo "  1. Run 'bash setup_repo.sh' in your terminal."
echo "  2. It will build: requirements.txt, .gitignore, README.md, and code files."
echo "  3. Create an empty public repository on GitHub."
echo "  4. Follow the steps on your screen to push this folder up to GitHub:"
echo "       git remote add origin <your-github-repo-url>"
echo "       git branch -M main"
echo "       git push -u origin main"
echo "========================================================================="