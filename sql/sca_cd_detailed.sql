-- get cd 
ALTER TABLE sca_cp_detailed
ADD cd text;

-- cds 
UPDATE sca_cp_detailed a
SET cd=b.borocd
FROM dcp_cdboundaries b
WHERE ST_Within(a.geom, b.geom)
AND a.geom is NOT NULL;

-- get cd 
ALTER TABLE sca_cp
ADD cd text;

-- cds 
UPDATE sca_cp a
SET cd=b.borocd
FROM dcp_cdboundaries b
WHERE ST_Within(a.geom, b.geom)
AND a.geom is NOT NULL;