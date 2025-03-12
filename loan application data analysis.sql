-- SQL Queries for Loan & Credit Risk Analysis
USE ibm_hr_database;

-- 1. Default Rate by Credit Score Category
SELECT 
    CASE 
        WHEN Credit_Score < 580 THEN 'Poor'
        WHEN Credit_Score BETWEEN 580 AND 669 THEN 'Fair'
        WHEN Credit_Score BETWEEN 670 AND 739 THEN 'Good'
        WHEN Credit_Score BETWEEN 740 AND 799 THEN 'Very Good'
        ELSE 'Excellent' 
    END AS Credit_Category,
    COUNT(*) AS Total_Applicants,
    SUM(CASE WHEN Loan_Status = 'Approved' THEN 1 ELSE 0 END) AS Approved,
    ROUND(SUM(CASE WHEN Loan_Status = 'Approved' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Approval_Rate
FROM loan_applications
GROUP BY Credit_Category;

-- 2. Loan Approval Rate by Employment Status
SELECT Employment_Status, 
       COUNT(*) AS Total_Applicants, 
       SUM(CASE WHEN Loan_Status = 'Approved' THEN 1 ELSE 0 END) AS Approved_Loans, 
       ROUND(SUM(CASE WHEN Loan_Status = 'Approved' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Approval_Rate
FROM loan_applications
GROUP BY Employment_Status;

-- 3. Average Debt-to-Income Ratio for Defaulters vs Non-Defaulters
SELECT Loan_Status, 
       ROUND(AVG(Debt_To_Income_Ratio), 2) AS Avg_DTI 
FROM loan_applications
GROUP BY Loan_Status;

-- 4. Most Common Loan Purposes Among Loan Applicants
SELECT Loan_Purpose, 
       COUNT(*) AS Approved_loan
FROM loan_applications
WHERE Loan_Status = 'Approved'
GROUP BY Loan_Purpose
ORDER BY Approved_loans DESC
LIMIT 5;
