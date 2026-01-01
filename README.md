# Apple Sales & Warranty Analysis (SQL)

## Project Overview
This project analyzes Apple sales, revenue, and warranty data using SQL.  
Multiple transactional tables are combined into a single analytical view to answer business questions related to sales performance, product trends, store performance, and warranty cases over time.

The analysis focuses on yearly trends, rankings, and percentage contributions using aggregations, CTEs, and window functions.

---

## Data Model
A unified SQL view `apple_data` is created by joining the following tables:
- sales
- products
- category
- stores
- warranty

## Key Analyses

### Sales Analysis
- Total units sold per year  
- Units sold by product and category each year  
- Number of sales transactions per store each year  
- Top-selling product by units sold for each year  
- Best-performing store by total units sold each year  

### Product Analysis
- Percentage contribution of each product to total yearly sales  
- Units sold by product, store, and year  
- Best-selling product per year using window functions  
- Warranty cases by product and repair status  

### Revenue Analysis
- Total revenue generated per year  
- Revenue by product category per year  
- Revenue by store and location per year  
- Top revenue-generating product for each year  
- Top revenue-generating store for each year  

---

## SQL Techniques Used
- CREATE VIEW  
- JOIN (multiple tables)  
- GROUP BY & ORDER BY  
- Common Table Expressions (CTEs)  
- Window functions: RANK() OVER (PARTITION BY …)  
- Aggregate functions: SUM(), COUNT()  
- Percentage calculations using window aggregates  

---

## Key Insights
- Identifies top-selling and top-revenue products by year  
- Highlights high-performing stores and regions  
- Analyzes product contribution to total sales volume  
- Evaluates warranty trends across products and years  
