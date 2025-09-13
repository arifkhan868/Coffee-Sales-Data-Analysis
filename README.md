
# ☕ Coffee Sales Analysis using Advanced SQL  

## 📌 Project Overview
This project dives into a **Coffee Retail Dataset** to analyze customer behavior, sales trends, and market potential across multiple cities.  
By leveraging **Advanced SQL (PostgreSQL/MySQL)**, I explored 10 real-world business problems and transformed raw sales data into actionable insights.  

The analysis provides a strong foundation for **decision-making** in areas like revenue optimization, customer segmentation, product strategy, and market expansion.  

---

## 🗂️ Dataset Description
The database contains **4 core tables**:  

1. **City** → `city_id`, `city_name`, `population`, `estimated_rent`  
2. **Customers** → `customer_id`, `city_id`  
3. **Products** → `product_id`, `product_name`, `product_category`  
4. **Sales** → `sale_id`, `customer_id`, `product_id`, `sale_date`, `total`  

---

## ⚙️ Skills & SQL Features Applied
- ✅ **Joins & Subqueries** → for combining multi-table datasets  
- ✅ **Common Table Expressions (CTEs)** → cleaner, modular queries  
- ✅ **Window Functions** → `LAG`, `DENSE_RANK` for growth & ranking analysis  
- ✅ **Aggregations** → `SUM`, `COUNT`, `ROUND`, `EXTRACT`  
- ✅ **Segmentation & Ranking** → to identify top customers, cities & products  
- ✅ **Business Problem Solving** → translating data → strategy insights  

---

## 🔎 Business Questions & SQL Solutions

### 1️⃣ Coffee Consumers Count
Estimate coffee consumers (25% of population assumption) in each city.  
📊 *Helps measure total addressable market size.*  

### 2️⃣ Quarterly Revenue (Q4 2023)
Total sales revenue across all cities in the last quarter of 2023.  
📊 *Useful for seasonal performance analysis.*  

### 3️⃣ Sales Count by Product
Number of units sold per product.  
📊 *Identifies best & worst performing coffee items.*  

### 4️⃣ Average Sales per Customer by City
City-level customer spending insights.  
📊 *Reveals high-value vs low-value customer regions.*  

### 5️⃣ City Population vs Coffee Consumers
Compare actual active customers vs estimated coffee drinkers.  
📊 *Highlights penetration gap → growth opportunities.*  

### 6️⃣ Top 3 Products per City
Use `DENSE_RANK()` to find top selling products in each city.  
📊 *Supports localized marketing campaigns.*  

### 7️⃣ Customer Segmentation by City
Unique customer count by city for coffee category.  
📊 *Assists in targeted segmentation strategies.*  

### 8️⃣ Avg Sale vs Rent
Average customer sale vs average rent per city.  
📊 *Compares affordability vs spending power.*  

### 9️⃣ Monthly Sales Growth %
Calculate growth using `LAG()` function.  
📊 *Tracks sales momentum and seasonal shifts.*  

### 🔟 Market Potential Analysis
Top 3 cities by sales, rent, customers, and coffee consumers.  
📊 *Guides expansion and resource allocation.*  

---

## 📈 Key Insights
- 🌍 **Only a handful of cities drive the majority of total revenue.**  
- 💡 **Product preferences differ by city**, so localized promotions are more effective.  
- 📉 Certain cities show **negative monthly growth**, signaling retention challenges.  
- 💸 Higher rent does not always mean higher spending → affordability plays a key role.  
- 🚀 Market potential analysis shows **3 cities hold strongest expansion opportunities.**  

---

## 🚀 Future Enhancements
- 📊 Build **Power BI / Tableau dashboards** for visualization.  
- 🧑‍🤝‍🧑 Add **demographic segmentation** (age, gender, income).  
- 📈 Apply **predictive analytics (ARIMA/ML)** to forecast sales & customer demand.  
- 🌐 Extend analysis to **multi-channel sales (online vs offline)**.  

---

## 📂 Project Structure
