-- creating geometries for capacity projects
ALTER TABLE sca_cp_capacity_projects
	ADD cd text,
	ADD borough text,
	ADD csd text,
	ADD geom geometry;

UPDATE sca_cp_capacity_projects a
SET geom=ST_SetSRID(ST_MakePoint(a.longitude::numeric, a.latitude::numeric),4326)
WHERE a.geom is NULL
AND a.longitude IS NOT NULL;

UPDATE sca_cp_capacity_projects a
SET geom=ST_SetSRID(ST_MakePoint(b.longitude::numeric, b.latitude::numeric),4326)
FROM sca_cp_cap_location_process b
WHERE a.geom is NULL
AND b.school = a.school
AND b.longitude IS NOT NULL;

-- community districts
UPDATE sca_cp_capacity_projects a
SET cd = b.borocd
FROM dcp_cdboundaries b
WHERE ST_Within(a.geom, b.geom)
AND a.geom IS NOT NULL;

-- boroughs
UPDATE sca_cp_capacity_projects a
SET borough = b.boroname
FROM dcp_boroboundaries_wi b
WHERE ST_Within(a.geom, b.geom)
AND a.geom IS NOT NULL;
-- school districts
UPDATE sca_cp_capacity_projects a
	SET csd = b.schooldist::text	
	FROM dcp_school_districts as b
	WHERE ST_Intersects(a.geom,b.geom);