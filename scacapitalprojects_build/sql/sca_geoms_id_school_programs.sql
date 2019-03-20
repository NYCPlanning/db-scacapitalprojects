-- get geometries got school programs
DROP TABLE IF EXISTS sca_cp_school_programs;
CREATE TABLE sca_cp_school_programs AS (
SELECT a.*, 'sca_cp_programs_cur'::text AS source
FROM sca_cp_programs a
UNION 
SELECT b.*, 'sca_cp_programs_prev'::text AS source FROM sca_cp_programs_prev b
WHERE b.projectnum NOT IN (SELECT a.projectnum FROM sca_cp_cap_schools a));

ALTER TABLE sca_cp_school_programs
ADD COLUMN cd text,
ADD COLUMN csd text,
ADD COLUMN geom geometry;

-- geoms from lcgms
UPDATE sca_cp_school_programs a
SET geom=ST_SetSRID(ST_MakePoint(b.longitude::numeric, b.latitude::numeric),4326)
FROM doe_facilities_lcgms b
WHERE a.buildingid = b.buildingcode
AND a.geom is NULL
AND b.longitude IS NOT NULL;

-- lat long from blue book
UPDATE sca_cp_school_programs a
SET geom=ST_Transform(ST_SetSRID(ST_MakePoint(b.x::numeric, b.y::numeric),2263),4326)
FROM doe_facilities_schoolsbluebook b
WHERE a.buildingid = b.bldg_id
AND a.geom is NULL;

-- community districts
UPDATE sca_cp_school_programs a
SET cd = b.borocd
FROM dcp_cdboundaries b
WHERE ST_Within(a.geom, b.geom)
AND a.geom IS NOT NULL;

-- school districts
UPDATE sca_cp_school_programs a
	SET csd = b.school_dist::text	
	FROM dcp_school_districts as b
	WHERE ST_Intersects(a.geom,b.wkb_geometry);