-- Enrollment from BB

SELECT
	geo_dist,
   	sum(org_enroll::numeric) AS org_enroll,
   	sum(org_target_cap::numeric) AS org_cap
FROM dcpadmin.doe_bluebook_organization_20162017
GROUP BY geo_dist


-- Exclude citywide and alternative HS (include co-located charter and SPED)

SELECT 
	geo_borocd,
    	sum(org_enroll) AS org_enroll,
   	sum(org_target_cap) AS org_cap
FROM capitalplanning.doe_bb_201617_for_analysis
WHERE x_citywide is null
AND x_alternative is null
GROUP BY geo_borocd
ORDER BY geo_borocd
