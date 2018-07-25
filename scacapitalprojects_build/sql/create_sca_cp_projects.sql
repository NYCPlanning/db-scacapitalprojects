--Create table sca_cp_projects for Group Projects without dollar amounts
DROP TABLE IF EXISTS sca_cp_projects;
CREATE TABLE sca_cp_projects AS (
	SELECT bldgid, 
			district, 
			boro, 
			school, 
			programcategory,
			'sca_cp_added_projects' AS source
	FROM sca_cp_added_projects  
	UNION ALL 
	SELECT buildingid, 
		   district, 
		   boro, 
		   school, 
		   programcategory,
		   'sca_cp_advanced_projects' AS source
	FROM sca_cp_advanced_projects 
	UNION ALL 
	SELECT bldid, 
		   district, 
		   boro, 
		   school, 
		   programcategory, 
		   'sca_cp_cancelled_projects' AS source
	FROM sca_cp_cancelled_projects 
	ORDER BY bldgid, school
);