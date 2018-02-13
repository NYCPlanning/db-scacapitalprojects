-- Enrollment from BB

SELECT
	geo_dist,
    sum(org_enroll::numeric) AS org_enroll,
    sum(org_target_cap::numeric) AS org_cap
FROM dcpadmin.doe_bluebook_organization_20162017
GROUP BY geo_dist
