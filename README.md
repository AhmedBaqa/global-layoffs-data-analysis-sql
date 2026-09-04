# Global Layoffs Data Analysis (SQL Project)

## Project Overview
This project analyzes global layoff trends between 2020 and 2023 using SQL for data cleaning and exploratory data analysis (EDA). The goal of this project was to clean a real-world dataset, identify meaningful workforce trends, and uncover business insights across industries, countries, and company stages.

---

## Dataset Information
- Dataset: Global Layoffs Dataset
- Time Period: 2020 – 2023
- Total Companies Analyzed: 1,893
- Countries Included: 60
- Industries Included: 32

---

## Tools & Technologies Used
- MySQL
- SQL

---

## Data Cleaning Process
The dataset contained duplicates, inconsistent formatting, blank values, and incorrect data types. The following cleaning steps were performed:

- Removed duplicate records using `ROW_NUMBER()`
- Created staging tables to preserve raw data
- Standardized inconsistent industry and country names
- Converted date columns into proper SQL date format
- Handled null and blank values
- Removed unnecessary rows and columns
- Improved overall dataset consistency for accurate analysis

---

## Exploratory Data Analysis (EDA)
The analysis focused on:
- Total layoffs by company
- Layoffs by industry
- Layoffs by country
- Layoffs by company stage
- Yearly and monthly layoff trends
- Companies with complete workforce reductions
- Rolling monthly layoff totals
- Top companies with highest layoffs each year

---

## Key Insights

- Total reported layoffs exceeded **385,000 employees** across **1,893 companies** between 2020 and 2023.

- **2022 recorded the highest number of layoffs**, with over **161,000 employees affected**, highlighting the impact of economic uncertainty and market slowdowns.

- The **United States experienced the largest share of layoffs**, accounting for more than **250,000 employees laid off**, making it the most impacted country in the dataset.

- The most affected industries were **Consumer, Retail, Transportation, and Finance**, indicating that consumer-facing sectors faced major operational and financial pressures.

- Companies in the **Post-IPO stage** recorded the highest layoffs, suggesting that publicly traded companies focused heavily on restructuring and cost reduction.

- Major technology companies such as Amazon, Google, Meta, and Salesforce reported some of the largest workforce reductions in the dataset.

- The dataset identified **116 companies** that laid off **100% of their workforce**, indicating complete shutdowns or business closures.

- Layoffs continued beyond the COVID-19 period, with workforce reductions remaining high throughout 2022 and 2023, showing long-term economic instability rather than a short-term pandemic effect.

- Rolling monthly trend analysis revealed that layoffs occurred consistently over time instead of isolated spikes, indicating prolonged workforce restructuring across industries.

- Data cleaning significantly improved dataset reliability by removing duplicates, standardizing inconsistent values, handling null records, and converting date columns into proper SQL date format.

---

## SQL Skills Demonstrated
This project demonstrates practical use of:

- Data Cleaning
- Exploratory Data Analysis (EDA)
- Common Table Expressions (CTEs)
- Window Functions
- `ROW_NUMBER()`
- `DENSE_RANK()`
- Joins
- Aggregations
- Rolling Totals
- Date Functions
- Trend Analysis

---

## Conclusion
This project demonstrates how SQL can be used to clean messy real-world data and transform it into meaningful business insights. Through data cleaning, transformation, and exploratory analysis, the project highlights global workforce trends and the economic impact of layoffs across industries and countries.
