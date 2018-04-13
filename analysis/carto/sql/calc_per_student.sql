-- Enrollment from BB

SELECT
	geo_dist,
   	sum(org_enroll::numeric) AS org_enroll,
   	sum(org_target_cap::numeric) AS org_cap
FROM dcpadmin.doe_bluebook_organization_20162017
GROUP BY geo_dist


-- Exclude alternative HS (include co-located charter and SPED)

SELECT 
	geo_borocd,
    	sum(org_enroll) AS org_enroll,
   	sum(org_target_cap) AS org_cap
FROM capitalplanning.doe_bb_201617_for_analysis
WHERE x_alternative is null
AND organization_name not like '%ALTERNATIVE LEARNING CENTER%'
AND organization_name not like '%ADULT LEARNING CENTER%'
GROUP BY geo_borocd
ORDER BY geo_borocd
