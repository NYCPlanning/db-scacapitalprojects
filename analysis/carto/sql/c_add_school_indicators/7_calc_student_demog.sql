SELECT
	geo_csd,
    sum(total_enrollment) as total_enroll,
    sum(__white) as num_white,
    sum(__poverty) as num_poverty,
FROM capitalplanning.doe_2016_demographics
WHERE x_citywide is null
AND x_alternative is null
AND x_charter is null
AND x_school_type = 'General Academic'
GROUP BY geo_csd ASC
