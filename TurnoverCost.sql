/* he Question: Which manager/department is burning through budget due to turnover costs? The SQL Skill: Calculating "Financial Impact" (The FP&A part).

The Insight: Turnover isn't free. We will assume replacement cost is 50% of annual salary.
*/

SELECT 
	Department, 
	JobRole,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Total_Leavers,
	AVG(MonthlyIncome) * 12 AS Avg_Annual_Salary,

	--Financial Impact Calculation
	(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * (AVG(MonthlyIncome) * 12) * 0.50) AS Est_Turnover_Cost

FROM dbo.ibm
GROUP BY Department, JobRole
ORDER BY Est_Turnover_Cost DESC;