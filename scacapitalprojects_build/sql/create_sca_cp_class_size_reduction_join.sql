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
			WHEN (substring(actualestcompl, strpos(actualestcompl,'-')+1, length(actualestcompl)) IN ('Jul','Aug', 'Sep', 'Oct', 'Nov', 'Dec')) THEN substring(actualestcompl, 1, strpos (actualestcompl,'-')-1)::integer+2001
			ELSE substring(actualestcompl, 1, strpos (actualestcompl,'-')-1)::integer+2000
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