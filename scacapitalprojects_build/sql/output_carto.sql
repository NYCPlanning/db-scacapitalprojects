-- Creating table that will be outputted to be uploaded into CARTO for the Capital Planning Platform
DROP TABLE IF EXISTS sca_output_carto;
CREATE TABLE sca_output_carto AS 
(SELECT NULL AS actualestcompletion, 
		NULL AS constrstart, 
		NULL AS designstart, 
		NULL AS forecastcapacity, 
		NULL AS fundingreqdfy15to19, 
		NULL AS location, 
		NULL AS neededtocomplete,
		NULL AS previousappropriations, 
		projectnum AS projectid, 
		total::text AS totalestcost , 
		borough, 
		buildingid, 
		district, 
		school AS schoolname, 
		description, 
		(CASE 
			WHEN description LIKE '%-%' THEN split_part(description,'-',1) 
			ELSE 'School Programs'
		END) AS type,
		geom
FROM sca_cp_school_programs
UNION ALL
SELECT 
	NULL AS actualestcompletion, 
	NULL AS constrstart, 
	NULL AS designstart, 
	NULL AS forecastcapacity, 
	NULL AS fundingreqdfy15to19,
	NULL AS location, 
	NULL AS neededtocomplete, 
	NULL AS previousappropriations, 
	NULL AS projectid, 
	NULL AS totalestcost,
	boro AS borough, 
	bldgid AS buildingid, 
	district, 
	school AS schoolname, 
	programcategory AS description,
	(CASE 
		WHEN source = 'sca_cp_added_projects' THEN 'Added Projects' 
		WHEN source = 'sca_cp_advaned_projects' THEN 'Advanced Projects'
		WHEN source = 'sca_cp_advaned_projects' THEN 'Cancelled Projects' 
		ELSE NULL 
	END) AS type,
	geom
FROM sca_cp_projects
UNION ALL
SELECT 
	NULL AS borough, 
	NULL AS buildingid, 
	actualestcompl AS actualestcompletion, 
	constrstart, 
	designstart, 
	description, 
	district, 
	forecastcapacity, 
	fundingreqdfy1519 AS fundingreqd15to19, 
	location, 
	neededtocomplete, 
	previousappropriations, 
	projectnum AS projectid, 
	school AS schoolname, 
	totalestcost, 
	(CASE 
		WHEN description = 'capacity projects' THEN 'Capacity Projects' 
		WHEN description = 'pre-k capacity projects' THEN 'PreK Capacity Projects' 
		WHEN description = 'Class Size Reduction Capacity Projects' THEN 'Class Size Reduction Projects'
		WHEN description = '' THEN 'Replacement Projects' 
	ELSE NULL
	END) AS type,
	geom
FROM sca_cp_capacity_projects
);