-- adding on geometries to projects without dollar amounts
ALTER TABLE sca_cp_projects
ADD COLUMN cd text,
ADD COLUMN geom geometry;

-- get geoms from lcgms
UPDATE sca_cp_projects a
SET geom=b.geom
FROM doe_facilities_lcgms b
WHERE a.buildingid = b.buildingcode
AND a.geom is NULL;

-- make geoms blue book
UPDATE sca_cp_projects a
SET geom=ST_Transform(ST_SetSRID(ST_MakePoint(b.x::numeric, b.y::numeric),2263),4326)
FROM doe_facilities_schoolsbluebook b
WHERE a.buildingid = b.bldg_id
AND a.geom is NULL;

-- populate community districts
UPDATE sca_cp_projects a
SET cd = b.borocd
FROM dcp_cdboundaries b
WHERE ST_Within(a.geom, b.geom)
AND a.geom IS NOT NULL;