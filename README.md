# Customer Analysis & Business Intelligence Dashboard

## 📊 Project Overview

This project analyzes customer behavior, customer value, profitability, churn risk, product/category performance, returns, and marketing-channel performance using **Python, SQL, and Power BI**.

The goal is to transform customer-level data into actionable business insights that can help management:

* Identify high-value customers
* Understand customer segments and RFM behavior
* Monitor customer lifetime value (CLV)
* Identify customers at higher churn risk
* Analyze category profitability and return behavior
* Evaluate shopping-channel performance
* Support customer retention and marketing decisions

---

## 🎯 Business Objective

The project focuses on answering important business questions related to:

1. Customer value and profitability
2. Customer segmentation
3. CLV and RFM analysis
4. Customer churn risk
5. Product/category performance
6. Return behavior
7. Marketing-channel performance
8. Customer retention
9. Revenue leakage risks
10. Management priorities for further investigation

---

## 🛠️ Tools & Technologies

| Tool                    | Purpose                                             |
| ----------------------- | --------------------------------------------------- |
| 🐍 **Python**           | Data cleaning, preparation and exploratory analysis |
| 🐼 **Pandas**           | Data manipulation and analysis                      |
| 🔢 **NumPy**            | Numerical operations                                |
| 📊 **Matplotlib**       | Data visualization                                  |
| 🗄️ **SQL / MySQL**     | Business analysis, aggregation and advanced queries |
| 📈 **Power BI**         | Interactive dashboard and business reporting        |
| 📓 **Jupyter Notebook** | Python analysis environment                         |

---

# 🔄 Project Workflow

```text
Raw Customer Data
       ↓
Python Data Cleaning & EDA
       ↓
Cleaned Customer Dataset
       ↓
SQL Business Analysis
       ↓
Customer / Segment / Category / Channel Analysis
       ↓
Power BI Dashboard
       ↓
Business Insights & Recommendations
```

---

# 🐍 1. Python — Data Preparation & EDA

The Python notebook was used as the initial analytical layer.

### Key activities

* Loaded the customer dataset
* Reviewed dataset structure and data types
* Checked missing values
* Checked duplicate records
* Checked customer ID uniqueness
* Cleaned selected categorical fields
* Calculated customer return rate
* Explored customer value
* Analyzed CLV
* Analyzed churn risk
* Compared categories
* Examined shopping-channel distribution
* Created exploratory visualizations

### Dataset

The notebook contains:

* **50,000 customer records**
* **53 columns**
* Unique customer IDs
* Customer demographic information
* Spending and purchase information
* CLV-related fields
* Churn-risk information
* Category information
* Shopping-channel information
* Marketing-related information

### Data Quality

The notebook reported:

* **0 duplicate rows**
* Unique customer IDs
* Missing categorical values handled for selected fields
* `return_rate` calculated using:

```text
return_rate = return_count / total_purchases × 100
```

The calculated return rate was rounded to two decimal places.

---

# 🗄️ 2. SQL — Business Analysis

SQL was used to perform structured business analysis on the cleaned customer dataset.

The main analysis table is:

```text
customer_analysis_cleaned_one
```

### SQL Analysis Includes

#### Customer Analysis

* Customer counts by segment
* Customer counts by gender
* Customer counts by country
* Customer counts by loyalty tier

#### Customer Ranking

* Top 10 customers by total spending
* Top 10 customers by CLV
* Top 10 customers by profitability

#### Segment Analysis

* Total spending by customer segment
* Average CLV by customer segment
* Segment-level profitability

#### Customer Value

* CLV category analysis
* Customer-value analysis
* Churn-risk category analysis
* RFM-related analysis

#### Category Analysis

* Category purchase analysis
* Category rankings
* Category-level customer performance

#### Channel Analysis

* Shopping-channel analysis
* Average CLV by shopping channel

---

## Advanced SQL Techniques

The project also demonstrates advanced SQL concepts:

* `GROUP BY`
* `ORDER BY`
* Aggregate functions
* Subqueries
* CTEs
* `JOIN`
* `RANK()`
* `DENSE_RANK()`
* `ROW_NUMBER()`
* `LAG()`
* Running totals
* Contribution percentages
* Category ranking
* Top-3 customers within each segment

Example analytical logic:

```sql
RANK() OVER (
    ORDER BY customer_lifetime_value_usd DESC
)
```

These techniques were used to move beyond basic SQL aggregation and support business-oriented customer ranking and comparison.

---

# 📊 3. Power BI Dashboard

The Power BI dashboard contains **four analytical pages**.

## 1. Executive Overview

Provides a management-level summary of the customer business.

### Includes

* Total Revenue / Spending
* Total Profitability
* Average CLV
* Return Rate
* Average Order Value
* Customer Count
* Age Group slicer
* Preferred Category slicer
* Customer Segment slicer
* Shopping Channel slicer
* Country slicer

**Purpose:** Give management a quick overview of customer and business performance.

---

## 2. Customer Intelligence ⭐

This is the main customer-analysis page.

### Includes

* Repeat Customer Rate
* Customer Segment analysis
* Customer Count
* RFM Category
* Customer Type
* CLV by Segment
* Top Customer analysis

**Purpose:** Identify valuable customers, understand customer behavior and support retention strategies.

---

## 3. Product & Profitability

Analyzes category and profitability performance.

### Includes

* Profitability by category
* Total Revenue
* Total Spending
* Profit Margin %
* Return Rate
* Top/Bottom product-oriented analysis

**Purpose:** Understand where revenue, profitability and return-related issues are concentrated.

---

## 4. Marketing Intelligence

Analyzes customer acquisition and shopping-channel performance.

### Includes

* Customer Acquisition Cost
* Return Rate
* Profitability
* Revenue
* Conversion Rate
* Customer Count by Shopping Channel

**Purpose:** Compare channel performance using multiple business metrics rather than customer volume alone.

---

# 🔍 Key Business Insights

## Customer Value

* The **Very High customer-value** category is the largest customer-value group in the Python analysis.
* **High CLV** is the dominant CLV category.
* SQL provides ranking logic for identifying high-value customers.

### Business implication

High-value customers should be monitored and protected through targeted retention strategies.

---

## Churn Risk

The analysis shows that:

* Low and Very Low churn-risk groups are larger.
* High and Very High churn-risk groups are smaller but strategically important.

### Business implication

High-risk customers should be prioritized based on:

* CLV
* Recency
* Spending
* Profitability
* Customer activity

---

## Returns

The Python analysis shows that:

> **Health & Personal Care has the highest average plotted return rate.**

### Business implication

Management should investigate:

* Return reasons
* Product mix
* Customer complaints
* Returned purchase value
* Product/category-specific return patterns

---

## Category Performance

The category analysis compares:

* Spending
* Customer profitability
* Returns

The analysis indicates that **Toys has the lowest plotted total customer profitability**, but its spending is also relatively low.

Therefore, the available evidence is **not sufficient to classify Toys as a high-revenue/low-profit category**.

---

## Shopping Channels

Customer counts are broadly distributed across:

* In-store
* Marketplace
* Online
* Mobile App

The dashboard provides additional metrics such as:

* Revenue
* Conversion
* Acquisition Cost
* Profitability
* Return Rate

Therefore, channel quality should be evaluated using **value and profitability**, not customer count alone.

---

# 💡 Management Recommendations

### 1. Investigate Health & Personal Care Returns

Analyze return reasons, complaints, product mix and financial impact.

### 2. Create a High-Risk Customer Watchlist

Prioritize High and Very High churn-risk customers using CLV, spending and profitability.

### 3. Protect High-Value Customers

Develop targeted retention strategies for customers with high customer value and CLV.

### 4. Monitor Category Profitability

Compare category revenue, spending, profitability and margin before making product decisions.

### 5. Evaluate Marketing Channels by Value

Compare acquisition cost, conversion, CLV, revenue and profitability rather than relying only on customer volume.

---

# ⚠️ Important Analytical Limitations

Some business questions cannot be reliably answered from the supplied project artifacts.

### Monthly Revenue Decline

The available analysis does not contain a monthly revenue time series sufficient to determine:

* Whether revenue decreased last month
* The size of the decline
* The exact reason for the decline

### Cohort Retention

A cohort-retention matrix is not present in the supplied data.

### Exact Repeat Purchase Rate

Power BI contains a Repeat Customer Rate measure, but the rendered value/measure definition is not available in the source artifacts reviewed.

### Highest-Value Marketing Channel

SQL contains a query for average CLV by shopping channel, but the saved query result is not available.

### Revenue Leakage

The project identifies potential leakage areas such as:

* Returns
* Churn/inactivity
* Low profitability
* Channel quality

However, the analysis does not provide a verified dollar amount of revenue loss.

---

# 📁 Project Structure

```text
Customer-Analysis/
│
├── Customer_Analysis_Project.ipynb
│
├── Customer_Analysis_Project_Sql.sql
│
├── Customer_Analysis_Dashboard.pbix
│
├── Customer_Analysis_Business_Analysis_Report.docx
│
├── Customer_Analysis_Business_Analysis_Report.pdf
│
└── README.md
```

---

# 📌 Key Skills Demonstrated

This project demonstrates practical experience in:

* Data Cleaning
* Exploratory Data Analysis
* Customer Analytics
* Customer Segmentation
* RFM Analysis
* Customer Lifetime Value (CLV)
* Churn-Risk Analysis
* SQL Aggregation
* SQL Joins
* CTEs
* Subqueries
* Window Functions
* Ranking Analysis
* Power BI Dashboard Development
* KPI Development
* Business Intelligence
* Business Reporting
* Data-driven Recommendations

---

# 🚀 Future Improvements

To make the analysis stronger, the following enhancements could be added:

1. Add transaction-level date data.
2. Build a monthly revenue trend.
3. Create a month-over-month revenue bridge.
4. Add first-purchase cohort information.
5. Build a cohort retention matrix.
6. Quantify revenue lost through returns.
7. Calculate the exact monetary impact of churn.
8. Compare channel-level CLV and profitability with saved results.
9. Add product/SKU-level profitability analysis.
10. Build a customer retention watchlist.

---

# 🎯 Final Outcome

The project demonstrates an end-to-end **Customer Analytics and Business Intelligence workflow**:

**Python** was used for data preparation and exploratory analysis, **SQL** was used for structured business analysis and advanced customer ranking, and **Power BI** was used to convert the analysis into interactive management dashboards.

The strongest business themes identified are:

> **Customer Value → CLV → Churn Risk → Returns → Profitability → Marketing Channels**

This project demonstrates how technical analysis can be translated into practical business questions, insights and management recommendations.
