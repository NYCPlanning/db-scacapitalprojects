-- get sca_cp geometries
ALTER TABLE sca_cp_projects
ADD geom geometry;

ALTER TABLE sca_cp_projects
ADD cd text;

ALTER TABLE sca_cp_projects
ADD school_district text;

-- geoms from lcgms
UPDATE sca_cp_projects a
SET geom=b.geom
FROM doe_facilities_lcgms b
WHERE a.bldgid = b.buildingcode
AND a.geom is NULL;

-- blue book
UPDATE sca_cp_projects a
SET geom=ST_Transform(ST_SetSRID(ST_MakePoint(b.x::numeric, b.y::numeric),2263),4326)
FROM doe_facilities_schoolsbluebook b
WHERE a.bldgid = b.bldg_id
AND a.geom is NULL;

-- community districts
UPDATE sca_cp_projects a
SET cd = b.borocd
FROM dcp_cdboundaries b
WHERE ST_Within(a.geom, b.geom)
AND a.geom IS NOT NULL;

-- school districts
UPDATE sca_cp_projects a
SET school_district = b.school_dist
FROM dcp_school_districts b
WHERE ST_Within(a.geom, b.wkb_geometry)
AND a.geom IS NOT NULL;