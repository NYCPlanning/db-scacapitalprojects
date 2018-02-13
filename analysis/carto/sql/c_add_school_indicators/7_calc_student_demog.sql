-- General Academic schools only (district and charter)
-- Excludes citywide schools, SPED, alternative, transfer hs, career technical, home school

SELECT
	geo_csd,
    sum(total_enrollment) as total_enroll,
    sum(__white) as num_white,
    sum(__poverty) as num_poverty,
FROM capitalplanning.doe_2016_demographics
WHERE x_citywide is null
AND x_alternative is null
AND x_school_type = 'General Academic'
GROUP BY geo_csd ASC

-- Calc school quality review score (average of schools in area with score)

SELECT
	geo_csd,
    sum(blended_sqr_score)/ count(blended_sqr_score) AS sqr,
    count(blended_sqr_score) AS num_w_sqr
FROM capitalplanning.doe_2016_demographics
WHERE x_citywide is null
AND x_alternative is null
AND x_school_type = 'General Academic'
AND blended_sqr_score is not null
GROUP BY geo_csd
