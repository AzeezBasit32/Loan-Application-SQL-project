-- Stored Procedures for Home Credit Default Risk Analysis
USE ibm_hr_data;

-- Procedure to Calculate Average Credit Score by Loan Status
DELIMITER $$
CREATE PROCEDURE AvgCreditScoreByStatus()
BEGIN
    SELECT Loan_Status, AVG(Credit_Score) AS Avg_Credit_Score
    FROM loan_applications
    GROUP BY Loan_Status;
END $$
DELIMITER ;

-- Procedure to Identify High-Risk Applicants
DELIMITER $$
CREATE PROCEDURE HighRiskApplicants()
BEGIN
    SELECT Client_ID, Age, Credit_Score, Debt_To_Income_Ratio, Loan_Status
    FROM loan_applications
    WHERE Default_Risk = 'High'
    ORDER BY Credit_Score ASC;
END $$
DELIMITER ;

-- Procedure to Get Loan Summary by Employment Status
DELIMITER $$
CREATE PROCEDURE LoanSummaryByEmployment()
BEGIN
    SELECT Employment_Status, COUNT(*) AS Loan_Count, AVG(Loan_Amount) AS Avg_Loan_Amount
    FROM loan_applications
    GROUP BY Employment_Status;
END $$
DELIMITER ;

-- Procedure to Retrieve Client Details by ID
DELIMITER $$
CREATE PROCEDURE GetClientDetails(IN client_id INT)
BEGIN
    SELECT * FROM loan_applications WHERE Client_ID = client_id;
END $$
DELIMITER ;
