/*
Stored procedure : Load bronze Layer (Source-> Bornze)
Purpose: store procedure loads data into the 'bronze' schema from external csv files 
actions performed :
truncates the bronze table before loading data.
uses the 'BULK INSERT' command to load data from csv files to bronze table 
*/



--CREATE SAVE FREQUENTLY USED SCRIPTS 
-- CREATE SCRIPT PROCEDURE IN DATABASE 
--EXEC bronze.load_bronze
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time  DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
BEGIN TRY
	SET @batch_start_time = GETDATE();
	PRINT 'loading Bronze Layer';
	PRINT 'loading CRM tables ';


SET @start_time = GETDATE();
PRINT'>> TRUNCATING TABLE : bronze.crm_cust_info';
TRUNCATE TABLE bronze.crm_cust_info;
PRINT '>> INSERTING DATA INTO : bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\singh\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',', 
	TABLOCK
);
SELECT COUNT(*) FROM bronze.crm_cust_info
SET @end_time = GETDATE();
PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
	
SET @start_time = GETDATE();
PRINT'>> TRUNCATING TABLE : bronze.crm_prd_info';
TRUNCATE TABLE bronze.crm_prd_info;
PRINT '>> INSERTING DATA INTO : bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\singh\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
SELECT COUNT(*) FROM bronze.crm_prd_info
SET @end_time = GETDATE();
PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'

SET @start_time = GETDATE();
TRUNCATE TABLE bronze.crm_sales_details;
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\singh\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
SELECT COUNT(*) FROM bronze.crm_sales_details
SET @end_time = GETDATE();
PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';


PRINT 'Loading ERP'
PRINT '>> TRUNCATING TABLE : bronze.crm_cust_info'
SET @start_time = GETDATE();
TRUNCATE TABLE bronze.erp_cust_az12
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\singh\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
SELECT COUNT(*) FROM bronze.erp_cust_az12
SET @end_time = GETDATE();
PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';

SET @start_time = GETDATE();
TRUNCATE TABLE bronze.erp_loc_a101
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\singh\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
SELECT COUNT(*) FROM bronze.erp_loc_a101
SET @end_time = GETDATE();
PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';


SET @start_time = GETDATE();
TRUNCATE TABLE bronze.erp_px_cat_g1v2
BULK INSERT bronze.erp_px_cat_g1v2
FROM 'C:\Users\singh\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
WITH(
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2
SET @end_time = GETDATE();
PRINT '>> Load Duration : ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
SET @batch_end_time = GETDATE();  
PRINT 'Loading Bronze Layer Completed';
PRINT '- TOTAL LOAD DURATION:  ' + CAST(DATEDIFF(SECOND , @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';

 END TRY 
 BEGIN CATCH 
	PRINT'============================';
	PRINT 'ERROR OCCURED DURING BRONZE LAYER ';
	PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
	PRINT 'ERROR MESSAGE' + CAST (ERROR_MESSAGE() AS NVARCHAR);
	PRINT 'ERROR MESSAGE' + CAST (ERROR_STATE() AS NVARCHAR);
	PRINT'============================';
 END CATCH
END

