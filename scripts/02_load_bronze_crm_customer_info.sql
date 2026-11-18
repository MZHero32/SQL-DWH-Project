/*
# Load CRM customer data into Bronze

- Import the rows from cust_info.csv into the existing bronze.crm_cust_info table.
- Start at row 2 to skip the column headers, split fields on commas,
  and acquire a table-level lock during the import.
- Replace the example path with the file location accessible to SQL Server.
- Running this script again appends the file's rows to the target table.
*/

USE datawarehouse;
GO

BULK INSERT bronze.crm_cust_info
FROM 'C:\Data\sql-data-warehouse-project\01_datasets\source_crm\cust_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
