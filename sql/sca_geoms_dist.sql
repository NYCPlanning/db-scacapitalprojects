-- based on school district
UPDATE sca_cp a
SET geom=b.wkb_geometry
FROM dcp_school_districts b
WHERE a.geom IS NULL AND
      LPAD(a.district, 2, '0') = LPAD(b.school_dist, 2, '0');

UPDATE sca_cp_detailed a
SET geom=b.wkb_geometry
FROM dcp_school_districts b
WHERE a.geom IS NULL AND
      LPAD(a.district, 2, '0') = LPAD(b.school_dist, 2, '0');