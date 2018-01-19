-- get sca_cp geometries
ALTER TABLE sca_cp
ADD geom geometry;

-- geoms from lcgms
UPDATE sca_cp a
SET geom=b.geom
FROM doe_facilities_lcgms b
WHERE a.buildingid = b.buildingcode
AND a.geom is NULL;

-- blue book
UPDATE sca_cp a
SET geom=ST_Transform(ST_SetSRID(ST_MakePoint(b.x::numeric, b.y::numeric),2263),4326)
FROM doe_facilities_schoolsbluebook b
WHERE a.buildingid = b.bldg_id
AND a.geom is NULL;
