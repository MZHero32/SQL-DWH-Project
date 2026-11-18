/*
# Initialize the data warehouse

- Switch to `master`, then drop `datawarehouse` if it exists. SQL Server disconnects other sessions and rolls back their uncommitted transactions.
- Create a fresh `datawarehouse` database and switch the session to it.
- Create `bronze` for raw data, `silver` for cleaned data, and `gold` for reporting and analysis.

> **Re-running this script deletes the existing `datawarehouse` database and all its data.**
*/

USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = N'datawarehouse')
BEGIN
    ALTER DATABASE datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE datawarehouse;
END;
GO

CREATE DATABASE datawarehouse;
GO

USE datawarehouse;
GO

CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
