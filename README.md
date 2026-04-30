# SQL + Power BI Layoffs Data Analysis Project (2020–2023)

## 📌 Project Overview

This project focuses on cleaning, transforming, and analyzing layoffs data from various companies and locations between 2020 and 2023.

The workflow follows an end-to-end data analysis pipeline:

* Data Cleaning (MySQL)
* Exploratory Data Analysis (SQL)
* Data Visualization (Power BI)

The goal was to convert raw, inconsistent data into a structured format and derive meaningful insights using interactive dashboards.

---

## 🛠️ Tools & Technologies

* MySQL
* MySQL Workbench
* Power BI

---

## 🧹 Data Cleaning (SQL)

The raw dataset contained duplicates, inconsistent formatting, and missing values. The following steps were performed:

* Created staging tables to preserve raw data
* Identified and removed duplicate records using `ROW_NUMBER()`
* Trimmed extra spaces from company names
* Standardized inconsistent values (industry, country)
* Converted date column from text format to `DATE`
* Replaced string `'NULL'` values with actual `NULL`
* Populated missing industry values using self-joins
* Removed rows with insufficient layoff data
* Dropped helper columns after cleaning

---

## 📊 Exploratory Data Analysis (SQL)

Performed SQL-based analysis to understand patterns in layoffs:

* Total layoffs across dataset
* Layoffs by country
* Layoffs by year
* Monthly layoff trends
* Top companies by layoffs

---

## 📈 Power BI Dashboard

The cleaned dataset was visualized using Power BI to create an interactive and insight-driven dashboard.

### 🔹 Dashboard Features:

* KPI Cards:

  * Total Layoffs
  * Top Country
  * Top Company
* Trend Analysis:

  * Layoffs over time (2020–2023)
* Comparative Analysis:

  * Top 5 countries by layoffs
  * Top 5 companies by layoffs

### 🖼️ Dashboard Preview:

![Dashboard](images/dashboard_screenshot.png)

---

## 📁 Project Structure

```
sql-powerbi-layoffs-analysis/
│
├── data/
│   └── layoffs_raw.csv
│
├── layoffs_data_cleaning.sql
│
|── layoffs_eda.sql
│
├── powerbi/
│   └── layoffs_dashboard.pbix
│
├── images/
│   └── dashboard_screenshot.png
│
├── README.md
├── setup.md
└── insights.md
```

---

## 📂 Dataset

* Source: Public layoffs dataset (2020–2023)
* File: `data/layoffs_raw.csv`
* Includes:

  * Company
  * Location
  * Industry
  * Total layoffs
  * Percentage laid off
  * Date
  * Funding raised

> Note: Dataset is used for educational and analysis purposes only.

---

## 🎯 Key Insights

* Layoffs peaked significantly during 2022–2023
* A small number of companies contributed heavily to total layoffs
* The United States recorded the highest layoffs among all countries
* Layoffs trends showed strong temporal patterns across months and years

---

## 🚀 Outcome

This project demonstrates:

* Strong understanding of SQL data cleaning techniques
* Ability to transform raw data into analysis-ready datasets
* Capability to build interactive dashboards using Power BI
* End-to-end data analysis workflow from raw data to insights

---

## 👤 Author

**Rishi Raj**
