-- =============================================================================
-- 💾 STEP 1: Import Data via Azure Data Studio Flat File Import Wizard
-- =============================================================================
⚠️ NOTE: BULK INSERT is not natively supported on macOS due to OS-level 
-- restrictions. Since I'm working on a MacBook, I used Azure Data Studio's 
-- "Import Flat File Wizard" to load CSV data into SQL Server.
-- This wizard creates temporary tables with auto-generated names (like 
-- [bronze].[bronze.crm_cust_info]), which I manually correct in the next step.
-- =============================================================================


-- =============================================================================
-- ✅ STEP 2: Move Data from Temporary Imported Table to Actual Table
-- =============================================================================

-- CRM Customer Info
INSERT INTO bronze.crm_cust_info
SELECT * FROM [bronze].[bronze.crm_cust_info];

-- Optional check to confirm data was inserted
SELECT COUNT(*) FROM bronze.crm_cust_info;

-- Drop the temporary table created by import wizard
DROP TABLE [bronze].[bronze.crm_cust_info];


-- CRM Product Info
-- Confirm table name created by wizard
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE '%prd_info%';

-- Move data from imported table to actual table
INSERT INTO bronze.crm_prd_info
SELECT * FROM [bronze].[bronze.crm_prd_info];

-- Drop temporary table
DROP TABLE [bronze].[bronze.crm_prd_info];


-- CRM Sales Details
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME LIKE '%sales_details%';
SELECT COUNT(*) FROM [bronze].[bronze.crm_sales_details];

INSERT INTO bronze.crm_sales_details
SELECT * FROM [bronze].[bronze.crm_sales_details];

SELECT * FROM bronze.crm_sales_details;

DROP TABLE [bronze].[bronze.crm_sales_details];


-- ERP Customer AZ12
INSERT INTO bronze.erp_cust_az12
SELECT * FROM [bronze].[CUST_AZ12];

SELECT COUNT(*) FROM bronze.erp_cust_az12;

DROP TABLE [bronze].[CUST_AZ12];


-- ERP Location A101
INSERT INTO bronze.erp_loc_a101
SELECT * FROM [bronze].[LOC_A101];

SELECT COUNT(*) FROM bronze.erp_loc_a101;

DROP TABLE [bronze].[LOC_A101];


-- ERP Product Category G1V2
INSERT INTO bronze.erp_px_cat_g1v2
SELECT * FROM [bronze].[PX_CAT_G1V2];

SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;

DROP TABLE [bronze].[PX_CAT_G1V2];


-- =============================================================================
-- 📊 STEP 3: Check Row Counts of All Bronze Tables
-- =============================================================================
-- This helps validate that the data transfer was successful across all tables.
-- =============================================================================

USE DataWareHouse;
GO

SELECT 
    'DataWareHouse.bronze.' + t.name AS full_table_name,
    SUM(p.rows) AS total_rows
FROM 
    DataWareHouse.sys.tables t
JOIN 
    DataWareHouse.sys.schemas s ON t.schema_id = s.schema_id
JOIN 
    DataWareHouse.sys.partitions p ON t.object_id = p.object_id
WHERE 
    s.name = 'bronze'
    AND p.index_id IN (0, 1) -- 0 = heap, 1 = clustered index
GROUP BY 
    t.name
ORDER BY 
    full_table_name;
