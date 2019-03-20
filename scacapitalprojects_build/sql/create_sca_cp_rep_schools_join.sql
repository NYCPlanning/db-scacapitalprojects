-- creating temp table for replacement projects for sca_cp_capacity_projects
DROP TABLE IF EXISTS sca_cp_rep_schools_join;
CREATE TABLE sca_cp_rep_schools_join AS (
	SELECT existingsiteidentified, 
		proposedleasedfacility, 
		forecastcapacity, 
		district, 
		school, 
		projectnum, 
		'replacement projects'::text as description,
		''::text as location,
   		''::text as latitude,
   		''::text as longitude, 
		actualestcompl,
		(CASE
    		WHEN (split_part(actualestcompl, '-', 1) IN ('Jul','Aug', 'Sep', 'Oct', 'Nov', 'Dec') ) THEN split_part(actualestcompl, '-', 2)::integer+2001
    		ELSE split_part(actualestcompl, '-', 2)::integer+2000
   		END) AS fy, 
   		designstart, 
		constrstart, 
		totalestcost, 
		previousappropriations, 
		fundingreqdfy1519,
		neededtocomplete,
		'sca_cp_rep_schools'::text as source
FROM sca_cp_rep_schools
);

UPDATE sca_cp_rep_schools_join
	SET location = NULL,
		latitude = NULL,
		longitude= NULL;