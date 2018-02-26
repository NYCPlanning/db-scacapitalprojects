-- Enrollment from BB

SELECT
	geo_dist,
   	sum(org_enroll::numeric) AS org_enroll,
   	sum(org_target_cap::numeric) AS org_cap
FROM dcpadmin.doe_bluebook_organization_20162017
GROUP BY geo_dist


-- Exclude citywide and alternative HS (include co-located charter and SPED)

SELECT 
	geo_dist,
  	geo_subdist,
    	sum(ps_enroll) AS ps_enroll,
   	 sum(ps_capacity) AS ps_cap,
  	sum(ms_enroll) AS ms_enroll,
    	sum(ms_capacity) AS ms_cap
FROM capitalplanning.doe_bb_201617_for_analysis
WHERE x_citywide is null
AND x_alternative is null
GROUP BY geo_dist, geo_subdist
ORDER BY geo_dist, geo_subdist
