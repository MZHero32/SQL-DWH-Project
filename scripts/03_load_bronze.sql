/*
# Load the Bronze layer

- Refresh six existing Bronze tables from three CRM and three ERP CSV files.
- Truncate each table before loading its file and start at row 2 to skip the header.
- Print the duration of each table load and the total run. Print SQL Server error details if a load fails.

## Before running

- Create the six target tables in the bronze schema.
- Replace the example dataset paths with paths that SQL Server can read.
- The EXEC statement at the end runs the refresh and replaces the existing Bronze rows.
*/

USE datawarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    DECLARE @start_time DATETIME,
            @end_time DATETIME,
            @bronze_start_time DATETIME,
            @bronze_end_time DATETIME;

    SET @bronze_start_time = GETDATE();

    BEGIN TRY
        PRINT '==================================';
        PRINT 'Loading Bronze data';
        PRINT '==================================';

        PRINT '==================================';
        PRINT 'Loading CRM tables';
        PRINT '==================================';

        SET @start_time = GETDATE();
        PRINT 'Truncating table: bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT 'Inserting into: bronze.crm_cust_info';
        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Data\sql-data-warehouse-project\01_datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(50)) + ' seconds';
        PRINT '---------------';

        SET @start_time = GETDATE();
        PRINT 'Truncating table: bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT 'Inserting into: bronze.crm_prd_info';
        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Data\sql-data-warehouse-project\01_datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(50)) + ' seconds';
        PRINT '---------------';

        SET @start_time = GETDATE();
        PRINT 'Truncating table: bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT 'Inserting into: bronze.crm_sales_details';
        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Data\sql-data-warehouse-project\01_datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(50)) + ' seconds';
        PRINT '---------------';

        PRINT '==================================';
        PRINT 'Loading ERP tables';
        PRINT '==================================';

        SET @start_time = GETDATE();
        PRINT 'Truncating table: bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT 'Inserting into: bronze.erp_cust_az12';
        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Data\sql-data-warehouse-project\01_datasets\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(50)) + ' seconds';
        PRINT '---------------';

        SET @start_time = GETDATE();
        PRINT 'Truncating table: bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT 'Inserting into: bronze.erp_loc_a101';
        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Data\sql-data-warehouse-project\01_datasets\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(50)) + ' seconds';
        PRINT '---------------';

        SET @start_time = GETDATE();
        PRINT 'Truncating table: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT 'Inserting into: bronze.erp_px_cat_g1v2';
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Data\sql-data-warehouse-project\01_datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();
        PRINT 'Load duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR(50)) + ' seconds';
        PRINT '---------------';
    END TRY
    BEGIN CATCH
        PRINT '***********************';
        PRINT 'Bronze load failed';
        PRINT '***********************';
        PRINT 'Error message: ' + ERROR_MESSAGE();
        PRINT 'Error number: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
        PRINT 'Error state: ' + CAST(ERROR_STATE() AS VARCHAR(10));
    END CATCH;

    SET @bronze_end_time = GETDATE();
    PRINT 'Bronze load duration: '
        + CONVERT(VARCHAR(50), DATEDIFF(SECOND, @bronze_start_time, @bronze_end_time))
        + ' seconds';
END;
GO

EXEC bronze.load_bronze;
