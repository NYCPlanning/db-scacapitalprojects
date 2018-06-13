-- get sca_cp geometries
DROP TABLE IF EXISTS sca_cp_school_programs;
CREATE TABLE sca_cp_school_programs AS
(
	SELECT *
	FROM sca_cp_programs
);


ALTER TABLE sca_cp_school_programs
ADD geom geometry;

-- geoms from lcgms
UPDATE sca_cp_school_programs a
SET geom=b.geom
FROM doe_facilities_lcgms b
WHERE a.buildingid = b.buildingcode
AND a.geom is NULL;

-- blue book
UPDATE sca_cp_school_programs a
SET geom=ST_Transform(ST_SetSRID(ST_MakePoint(b.x::numeric, b.y::numeric),2263),4326)
FROM doe_facilities_schoolsbluebook b
WHERE a.buildingid = b.bldg_id
AND a.geom is NULL;
