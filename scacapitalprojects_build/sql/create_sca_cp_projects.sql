-- creating the sca projects without dollar amounts table
DROP TABLE IF EXISTS sca_cp_projects;
CREATE TABLE sca_cp_projects AS (
	SELECT bldgid as buildingid, 
			district, 
			boro as borough, 
			school, 
			programcategory,
			'sca_cp_added_projects' AS source
	FROM sca_cp_added_projects  
	UNION ALL 
	SELECT buildingid, 
		   district, 
		   boro as borough, 
		   school, 
		   programcategory,
		   'sca_cp_advanced_projects' AS source
	FROM sca_cp_advanced_projects 
	UNION ALL 
	SELECT bldid as buildingid, 
		   district, 
		   boro as borough, 
		   school, 
		   programcategory, 
		   'sca_cp_cancelled_projects' AS source
	FROM sca_cp_cancelled_projects 
	ORDER BY buildingid, school
);
-- updating boro codes to be boro names
UPDATE sca_cp_projects
SET borough = (CASE
				WHEN borough = 'M' THEN 'Manhattan'
				WHEN borough = 'X' THEN 'Bronx'
				WHEN borough = 'K' THEN 'Brooklyn'
				WHEN borough = 'Q' THEN 'Queens'
				WHEN borough = 'R' THEN 'Staten Island'
				ELSE NULL
			END);