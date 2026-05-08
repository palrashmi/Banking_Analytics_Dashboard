

SELECT
    t.TransactionID,
    t.AccountID AS Transaction_AccountID,
    t.TransactionDate,
    t.Type AS TransactionType,
    t.Amount,
    t.Description,
    t.Currency,
    a.AccountID AS Account_AccountID,
    a.CustomerID AS Account_CustomerID,
    a.Type AS AccountType,
    a.OpenDate,
    a.Balance,
    c.CustomerID,
    c.Name,
    c.Gender,
    c.DateOfBirth,
    c.Address,
    c.Email,
    c.Phone
INTO CombinedBankingDataset
FROM
    Transactions t
    Left JOIN Accounts a ON t.AccountID = a.AccountID
    Left JOIN Customers c ON a.CustomerID = c.CustomerID

    
    select * from CombinedBankingDataset
   -- to see all columns of dataset 

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS


-- check if duplicate value present
SELECT 
    TransactionID,
    COUNT(*) AS Duplicate_Count
FROM CombinedBankingDataset
GROUP BY TransactionID
HAVING COUNT(*) > 1
ORDER BY Duplicate_Count DESC;
-- check if null present
SELECT 
    COUNT(TransactionID) AS Non_Null_Count,
    COUNT(*) AS Total_Rows,
    COUNT(*) - COUNT(TransactionID) AS Null_Count
FROM CombinedBankingDataset;

-- Verify Total Transactions for 2025
SELECT COUNT(TransactionID) AS Total_Transactions_2025
FROM CombinedBankingDataset
WHERE YEAR(TransactionDate) = 2025;

-- Verify Total Amount for 2025
SELECT 
    SUM(Amount) AS Total_Amount,
    ROUND(SUM(Amount)/1000000, 2) AS Total_In_Millions
FROM CombinedBankingDataset
WHERE YEAR(TransactionDate) = 2025;

-- Verify Debit % and Credit % for 2025
SELECT 
    TransactionType,
    COUNT(TransactionID) AS Count,
    ROUND(COUNT(TransactionID) * 100.0 / 
        (SELECT COUNT(TransactionID) 
         FROM CombinedBankingDataset
         WHERE YEAR(TransactionDate) = 2025), 2) AS Percentage
FROM CombinedBankingDataset
WHERE YEAR(TransactionDate) = 2025
GROUP BY TransactionType;

-- See all distinct years in your data
SELECT 
    YEAR(TransactionDate) AS Year,
    COUNT(TransactionID) AS Transaction_Count
FROM CombinedBankingDataset
GROUP BY YEAR(TransactionDate)
ORDER BY Year;

-- Total Customers
SELECT 
    COUNT(DISTINCT CustomerID) AS Total_Customers
FROM CombinedBankingDataset;

-- Check all distinct customers
SELECT 
    DISTINCT CustomerID,
    Name
FROM CombinedBankingDataset
ORDER BY CustomerID;

SELECT COUNT(*) AS Null_Customer_Count
FROM CombinedBankingDataset
WHERE CustomerID IS NULL;

-- total balance 
SELECT 
    SUM(Balance) AS Total_Balance,
    ROUND(SUM(Balance)/1000, 2) AS Balance_In_K
FROM CombinedBankingDataset;

-- total account 
SELECT 
    COUNT(DISTINCT Account_AccountID) AS Total_Accounts
FROM CombinedBankingDataset;