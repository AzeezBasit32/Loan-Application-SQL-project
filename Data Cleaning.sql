
SET sql_safe_updates=0;

-- Data Cleaning Script for Loan Applications
USE ibm_hr_database;

-- Remove duplicates based on Client_ID
DELETE FROM loan_applications
WHERE Client_ID NOT IN (
    SELECT MIN(Client_ID) FROM loan_applications GROUP BY Client_ID
);

-- Handle missing values: Replace NULLs in critical fields
UPDATE loan_applications
SET Credit_Score = 600
WHERE Credit_Score IS NULL;

UPDATE loan_applications
SET Annual_Income = (SELECT AVG(Annual_Income) FROM loan_applications)
WHERE Annual_Income IS NULL;

UPDATE loan_applications
SET Debt_To_Income_Ratio = 0.3
WHERE Debt_To_Income_Ratio IS NULL;

-- Standardize text values
UPDATE loan_applications
SET Gender = UPPER(Gender);

UPDATE loan_applications
SET Marital_Status = UPPER(Marital_Status);

UPDATE loan_applications
SET Loan_Status = UPPER(Loan_Status);

-- Remove unrealistic values
DELETE FROM loan_applications WHERE Age < 18 OR Age > 100;
DELETE FROM loan_applications WHERE Credit_Score < 300 OR Credit_Score > 850;
DELETE FROM loan_applications WHERE Loan_Amount <= 0;

-- Ensure Employment_Status is valid
UPDATE loan_applications
SET Employment_Status = 'Unemployed'
WHERE Employment_Status NOT IN ('Employed', 'Self-employed', 'Unemployed', 'Retired');

SET sql_safe_updates=1;
