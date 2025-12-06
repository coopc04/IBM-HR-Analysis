
/*
  Purpose: Return all JobRole rows with counts, average pay for new hires (<=2 years)
  and veterans (>=5 years), plus the pay gap and a flag if new hires earn more.
*/
SELECT
    JobRole,
    COUNT(*) AS Total_Employees,
    COUNT(CASE WHEN YearsAtCompany <= 2 THEN 1 END) AS NewHireCount,
    COUNT(CASE WHEN YearsAtCompany >= 5 THEN 1 END) AS VeteranCount,
    ROUND(AVG(CASE WHEN YearsAtCompany <= 2 THEN TRY_CAST(MonthlyIncome AS FLOAT) END), 2) AS Avg_New_Hire_Pay,
    Round(AVG(CASE WHEN YearsAtCompany >= 5 THEN TRY_CAST(MonthlyIncome AS FLOAT) END), 2) AS Avg_Veteran_Pay,
    ROUND(AVG(TRY_CAST(MonthlyIncome AS FLOAT) * 12), 0) AS Avg_Salary,
    ROUND(AVG(CASE WHEN YearsAtCompany <= 2 THEN TRY_CAST(MonthlyIncome AS FLOAT) END)
      - AVG(CASE WHEN YearsAtCompany >= 5 THEN TRY_CAST(MonthlyIncome AS FLOAT) END), 2) AS Pay_Inversion_Gap,
    CASE WHEN AVG(CASE WHEN YearsAtCompany <= 2 THEN TRY_CAST(MonthlyIncome AS FLOAT) END)
              > AVG(CASE WHEN YearsAtCompany >= 5 THEN TRY_CAST(MonthlyIncome AS FLOAT) END)
         THEN 1 ELSE 0 END AS NewHireHigherFlag
FROM dbo.ibm
GROUP BY JobRole
ORDER BY JobRole;
