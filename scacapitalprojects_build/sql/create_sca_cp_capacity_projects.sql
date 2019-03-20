-- creating master capacity projects table
DROP TABLE IF EXISTS sca_cp_capacity_projects;
CREATE TABLE sca_cp_capacity_projects AS
    (SELECT *
	FROM sca_cp_cap_joined 
	UNION ALL 
	SELECT *
	FROM sca_cp_prek_joined 
	UNION ALL
	SELECT *
	FROM sca_cp_threeprek_joined
	ORDER BY school);

DROP TABLE sca_cp_cap_joined;
DROP TABLE sca_cp_prek_joined;
DROP TABLE sca_cp_threeprek_joined;

-- Only to be run when there is an amendment update

DROP TABLE IF EXISTS sca_cp_capacity_projects;
CREATE TABLE sca_cp_capacity_projects AS
	(SELECT *
	FROM sca_cp_cap_joined 
	UNION ALL 
	SELECT *
	FROM sca_cp_prek_joined 
	UNION ALL
	SELECT *
	FROM sca_cp_threeprek_joined
	UNION ALL
	SELECT *
	FROM sca_cp_class_size_reduction_join
    UNION ALL
    SELECT *
	FROM sca_cp_rep_schools_join
	ORDER BY school);

DROP TABLE sca_cp_class_size_reduction_join;
DROP TABLE sca_cp_rep_schools_join;