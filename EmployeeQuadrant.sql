/*Putting employees into 4 quadrants based on their overtime work and job satisfaction
*/

--Use CTE to segment the employees
WITH Burnout_Segments AS (
	SELECT
		EmployeeNumber,
		Attrition,
		YearsSinceLastPromotion,
		CASE
			WHEN OverTime = 'Yes' AND JobSatisfaction <= 2 THEN 'Burned Out (High Risk)'
			WHEN OverTime = 'Yes' AND JobSatisfaction >= 3 THEN 'Grinder (Loyal)'
			WHEN OverTime = 'No' AND JobSatisfaction <= 2 THEN 'Disengaged'
			WHEN OverTime = 'No' AND JobSatisfaction >= 3 THEN 'Stable'
		END AS Employee_Quadrant
	FROM dbo.ibm
)

--Query the CTE
SELECT
	Employee_Quadrant,
	COUNT(EmployeeNumber) AS Number_Of_Employees,
	AVG(YearsSinceLastPromotion) AS Avg_Years_No_Promotion,
	SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM Burnout_Segments
GROUP BY Employee_Quadrant
ORDER BY Attrition_Count DESC;