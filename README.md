# SQL-DWH-Project

## 01. Initialize the database

The [initialization script](scripts/01_init_database.sql) creates the `datawarehouse` database in SQL Server and sets up three schemas for the warehouse layers.

1. Switches to `master`. If `datawarehouse` already exists, the script sets it to `SINGLE_USER`, disconnects other sessions, rolls back their uncommitted transactions, and drops the database.
2. Creates a fresh `datawarehouse` database and switches the session to it.
3. Creates the `bronze` schema for raw source data, `silver` for cleaned and standardized data, and `gold` for tables and views used in reporting and analysis.

> **Running this script again deletes all existing data and objects in `datawarehouse`.**

```sql
-- Reset the project database. Re-running this script deletes its existing data.
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
```
