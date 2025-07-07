# Data Warehouse and Analytics Project

Welcome to the Data Warehouse project repository! 🚀
This project demonstrates a modern data engineering workflow using SQL Server and follows the Medallion Architecture—focusing on building robust Bronze and Silver layers.

# Data Architecture - Medallion Approach
![High-level architecture](https://github.com/user-attachments/assets/d93324ac-c135-4e63-9f6a-8a0ca5751446)
1. **Bronze Layer**: Stores raw data as-is from CSV source files (ERP & CRM systems). Acts as the staging layer.
2. **Silver Layer**: Processes, cleans, and transforms the Bronze data into structured and standardized tables ready for analysis and modeling.
3. **Gold Layer**:(analytical star schema) is under development and will be added soon.
 
## 🔧 Key Features
1. **End-to-end SQL-based ETL pipelines
2. **Data quality improvements: null handling, type conversions, trimming, normalization
3. **Error handling and logging via stored procedures
4. **Clean separation of raw vs. refined data stages

## 🗂️ Repository Structure
```
data-warehouse-project/
│
├── datasets/            # Raw ERP and CRM CSV files
│
├── scripts/
│   ├── bronze/          # SQL scripts to load raw data into Bronze tables
│   └── silver/          # SQL procedures for data cleaning & transformation
│
├── README.md            # Project overview and usage
├── .gitignore
└── LICENSE
```
---

## ✅ Tech Stack
- **Azure Data Studio**
- **CSV (source format)**
- **Draw.io**
- **Git & GitHub**

## 🚧 In Progress
1. **Building the Gold Layer (fact/dimension modeling)
2. **Adding test validations for Silver transformations





