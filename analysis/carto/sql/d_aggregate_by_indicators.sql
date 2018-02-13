--Identify high charter areas 
(charter enrollment/total enrollment by school district, excl. enrollment from alternative & citywide programs)
-- Source data: doe_2016_demographics

SELECT
	geo_csd,
  x_charter,
  sum(total_enrollment) AS total_enroll
FROM capitalplanning.doe_2016_demographics
WHERE x_alternative is null
AND x_citywide is null
GROUP BY 
	geo_csd,
  x_charter
  

