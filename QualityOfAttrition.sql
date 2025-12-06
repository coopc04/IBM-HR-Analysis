-- This query selects the different deparments, take their total staff and sees how many people are leaving.
-- It checks to see the quality of employees they are losing, with the average performance rating of the department

SELECT Department,
       COUNT(EmployeeNumber) AS Total_Staff,
       SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Leavers,
       CAST((SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 1.0) / COUNT(EmployeeNumber) AS DECIMAL(10,2)) AS Attrition_Rate,
       AVG(CAST(PerformanceRating AS FLOAT)) AS Avg_PerformanceRating
FROM dbo.ibm
GROUP BY Department
ORDER BY Department;