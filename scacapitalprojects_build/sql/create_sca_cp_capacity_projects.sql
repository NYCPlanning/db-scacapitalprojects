--Create table sca_cp_projects for Group Projects without dollar amounts
DROP TABLE IF EXISTS sca_cp_capacity_projects;
CREATE TABLE sca_cp_capacity_projects AS
    (SELECT existingsiteidentified, proposedleasedfacility, district, school, projectnum, forecastcapacity, designstart, constrstart, actualestcompl, description, location,latitude, longitude, totalestcost, fy, previousappropriations, fundingreqdfy1519, neededtocomplete
	FROM sca_cp_cap_joined 
	UNION ALL 
	SELECT existingsiteidentified, proposedleasedfacility, district, school, projectnum, forecastcapacity, designstart, constrstart, actualestcompl, description, location,latitude, longitude, totalestcost, fy, previousappropriations, fundingreqdfy1519, neededtocomplete
	FROM sca_cp_prek_joined 
	UNION ALL 
	SELECT existingsiteidentified, proposedleasedfacility, district, school, projectnum, forecastcapacity, designstart, constrstart, actualestcompl, description, location,latitude, longitude, totalestcost, fy, previousappropriations, fundingreqdfy1519, neededtocomplete
	FROM sca_cp_class_size_reduction_join
    UNION ALL
    SELECT existingsiteidentified, proposedleasedfacility, district, school, projectnum, forecastcapacity, designstart, constrstart, actualestcompl, description, location,latitude, longitude, totalestcost, fy, previousappropriations, fundingreqdfy1519, neededtocomplete
	FROM sca_cp_rep_schools_join
	ORDER BY school);

DROP TABLE sca_cp_cap_joined ;
DROP TABLE sca_cp_prek_joined ;
DROP TABLE sca_cp_class_size_reduction_join ;
DROP TABLE sca_cp_rep_schools_join ;