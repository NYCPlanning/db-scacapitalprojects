ALTER TABLE sca_cp_capacity_projects
ADD geom geometry;

ALTER TABLE sca_cp_capacity_projects
ADD cd text;

ALTER TABLE sca_cp_capacity_projects
ADD school_district text;

-- geoms from lcgms
UPDATE sca_cp_capacity_projects a
SET geom=ST_SetSRID(ST_MakePoint(a.longitude::numeric, a.latitude::numeric),4326)
WHERE a.geom is NULL;

-- community districts
UPDATE sca_cp_capacity_projects a
SET cd = b.borocd
FROM dcp_cdboundaries b
WHERE ST_Within(a.geom, b.geom)
AND a.geom IS NOT NULL;

-- school districts
UPDATE sca_cp_capacity_projects a
SET school_district = b.school_dist
FROM dcp_school_districts b
WHERE ST_Within(a.geom, b.wkb_geometry)
AND a.geom IS NOT NULL;