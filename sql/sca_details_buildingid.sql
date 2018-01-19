-- Add on building id to sca_cp_detailed table

ALTER TABLE sca_cp_detailed
DROP COLUMN IF EXISTS buildingid;
ALTER TABLE sca_cp_detailed
ADD COLUMN buildingid text;

WITH buildingids AS (
	SELECT DISTINCT schoolname, buildingid
	FROM sca_cp
)

UPDATE sca_cp_detailed a
SET buildingid = b.buildingid
FROM buildingids b
WHERE TRIM(LEFT(a.schoolname, strpos(a.schoolname, '-') - 1)) = b.schoolname;