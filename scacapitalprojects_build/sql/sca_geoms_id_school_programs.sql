-- get geometries got school programs
DROP TABLE IF EXISTS sca_cp_school_programs;
CREATE TABLE sca_cp_school_programs AS (
	SELECT *
	FROM sca_cp_programs
);

ALTER TABLE sca_cp_school_programs
ADD COLUMN source text,
ADD COLUMN cd text,
ADD COLUMN geom geometry;

UPDATE sca_cp_school_programs
SET source = 'sca_cp_programs';

-- geoms from lcgms
UPDATE sca_cp_school_programs a
SET geom=b.geom
FROM doe_facilities_lcgms b
WHERE a.buildingid = b.buildingcode
AND a.geom is NULL;

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