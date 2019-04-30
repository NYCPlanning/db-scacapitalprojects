-- creating temp table for pre k capacity projects for sca_cp_capacity_projects
DROP TABLE IF EXISTS sca_cp_prek_joined_cur;
CREATE TABLE sca_cp_prek_joined_cur AS (
	SELECT a.existingsiteidentified, 
		a.proposedleasedfacility, 
		a.forecastcapacity,
		a.district, 
		a.school, 
		a.projectnum, 
		'pre-k capacity projects'::text AS description, 
		b.location, 
		b.latitude, 
		b.longitude, 
		a.actualestcompl, 
		(CASE 
			WHEN (split_part(a.actualestcompl,'-',2)) IN ('Jul','Aug', 'Sep', 'Oct', 'Nov', 'Dec') THEN split_part(a.actualestcompl,'-',1)::integer+2001
			ELSE split_part(a.actualestcompl,'-',1)::integer+2000
		END) AS fy,
		a.designstart, 
		a.constrstart, 
		a.totalestcost, 
		a.previousappropriations, 
		a.fundingreqdfy1519, 
		a.neededtocomplete,
		'sca_cp_prek_schools_FY2020-24'::text AS source
	FROM sca_cp_prek_schools a
	LEFT JOIN sca_cp_prek_location b
	ON a.school = b.school);

DROP TABLE IF EXISTS sca_cp_prek_joined_prev;
CREATE TABLE sca_cp_prek_joined_prev AS (
	SELECT a.existingsiteidentified, 
		a.proposedleasedfacility, 
		a.forecastcapacity,
		a.district, 
		a.school, 
		a.projectnum, 
		'pre-k capacity projects'::text AS description, 
		b.location, 
		b.latitude, 
		b.longitude, 
		a.actualestcompl, 
		(CASE 
			WHEN (split_part(a.actualestcompl,'-',2)) IN ('Jul','Aug', 'Sep', 'Oct', 'Nov', 'Dec') THEN split_part(a.actualestcompl,'-',1)::integer+2001
			ELSE split_part(a.actualestcompl,'-',1)::integer+2000
		END) AS fy,
		a.designstart, 
		a.constrstart, 
		a.totalestcost, 
		a.previousappropriations, 
		a.fundingreqdfy1519, 
		a.neededtocomplete,
		'sca_cp_prek_schools_FY2015-19'::text AS source
	FROM sca_cp_prek_schools_prev a
	LEFT JOIN sca_cp_prek_location_prev b
	ON a.school = b.school);

DROP TABLE IF EXISTS sca_cp_prek_joined;
CREATE TABLE sca_cp_prek_joined AS (
SELECT a.* FROM sca_cp_prek_joined_cur a
UNION 
SELECT b.* FROM sca_cp_prek_joined_prev b
WHERE b.projectnum NOT IN (SELECT a.projectnum FROM sca_cp_prek_joined_cur a));

ALTER TABLE sca_cp_prek_joined
ADD COLUMN inprev text;
UPDATE sca_cp_prek_joined
SET inprev = 'Y'
WHERE projectnum IN (SELECT a.projectnum FROM sca_cp_prek_joined_prev a);

DROP TABLE IF EXISTS sca_cp_prek_joined_cur;
DROP TABLE IF EXISTS sca_cp_prek_joined_prev;