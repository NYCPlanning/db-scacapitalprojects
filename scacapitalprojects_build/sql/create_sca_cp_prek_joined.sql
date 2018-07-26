-- creating temp table for pre k capacity projects for sca_cp_capacity_projects
DROP TABLE IF EXISTS sca_cp_prek_joined;
CREATE TABLE sca_cp_prek_joined AS (
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
			WHEN (substring(a.actualestcompl, strpos(a.actualestcompl,'-')+1, length(a.actualestcompl)) IN ('Jul','Aug', 'Sep', 'Oct', 'Nov', 'Dec')) THEN substring(a.actualestcompl, 1, strpos (a.actualestcompl,'-')-1)::integer+2001
			ELSE substring(a.actualestcompl, 1, strpos (a.actualestcompl,'-')-1)::integer+2000
		END) AS fy,
		a.designstart, 
		a.constrstart, 
		a.totalestcost, 
		a.previousappropriations, 
		a.fundingreqdfy1519, 
		a.neededtocomplete,
		'sca_cp_prek_schools' AS source
	FROM sca_cp_prek_schools a
	LEFT JOIN sca_cp_prek_location b
	ON a.school = b.school);