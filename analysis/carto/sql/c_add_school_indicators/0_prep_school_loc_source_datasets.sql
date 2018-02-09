/**0. Prep source data sets for school locations**/
ALTER TABLE capitalplanning.doe_lcgms_201617
ADD COLUMN dcp_dbn text;

UPDATE capitalplanning.doe_lcgms_201617
SET dcp_dbn = left(ats_system_code,6);

UPDATE capitalplanning.doe_2017_school_locations
SET the_geom = ST_Transform(ST_SetSRID(ST_Makepoint(x_coordinate::numeric, y_coordinate::numeric), 2263), 4326)
WHERE x_coordinate <> 'NULL';

ALTER TABLE capitalplanning.doe_2017_school_locations
ADD COLUMN dcp_dbn text;

UPDATE capitalplanning.doe_2017_school_locations
SET dbn = left(ats_system_code,6);
