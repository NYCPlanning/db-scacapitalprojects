-- creating temp table for class size reduction projects for sca_cp_capacity_projects
DROP TABLE IF EXISTS sca_cp_class_size_reduction_join;
CREATE TABLE sca_cp_class_size_reduction_join AS (
	SELECT existingsiteidentified, 
		''::text as proposedleasedfacility,
		forecastcapacity, 
		district, 
		school, 
		projectnum, 
		'class size reduction projects'::text as description,
		''::text as location,
   		''::text as latitude,
   		''::text as longitude, 
		actualestcompl,
		(CASE 
			WHEN (split_part(actualestcompl, '-', 1) IN ('Jul','Aug', 'Sep', 'Oct', 'Nov', 'Dec')) THEN split_part(actualestcompl, '-', 2)::integer+2001
			ELSE split_part(actualestcompl, '-', 2)::integer+2000
		END) AS fy,
		designstart, 
		constrstart,
		totalestcost, 
   		previousappropriations, 
   		fundingreqdfy1519, 
   		neededtocomplete,
   		'sca_cp_class_size_reduction'::text
FROM sca_cp_class_size_reduction
);

UPDATE sca_cp_class_size_reduction_join
	SET proposedleasedfacility = NULL,
		location = NULL,
		latitude = NULL,
		longitude= NULL;

ALTER TABLE sca_cp_class_size_reduction_join
ADD COLUMN inprev text;