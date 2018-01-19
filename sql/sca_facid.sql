-- Merge facility id to sca
ALTER TABLE sca_cp ADD COLUMN facuid varchar(30);

UPDATE sca_cp
SET facuid = b.uid
FROM facdb_facilities b
WHERE bin = b.bin;

ALTER TABLE sca_cp_detailed ADD COLUMN facuid varchar(30);

UPDATE sca_cp_detailed
SET facuid = b.uid
FROM facdb_facilities b
WHERE bin = b.bin;