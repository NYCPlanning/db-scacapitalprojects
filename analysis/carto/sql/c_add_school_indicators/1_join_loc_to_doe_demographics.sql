
/**1. Join school location to DOE demographics data (only at org_id level, NOT separated by buildings)
In order of preference - LCGMS by ats_sys_code of primary building location, 2017-18 school locations by ats_sys_code of primary building location, BB by org id
Exclude D79 schools like Pathways to Graduation and Restart Academy (citywide Alternative programs with multiple locations but grouped in same org id here)**/
UPDATE capitalplanning.doe_2016_demographics
SET the_geom = l.the_geom
FROM doe_lcgms_201617 AS l
WHERE doe_2016_demographics.dbn = l.dcp_dbn;

ALTER TABLE capitalplanning.doe_2016_demographics
ADD COLUMN geom_source text;

UPDATE capitalplanning.doe_2016_demographics
SET geom_source = 'LCGMS 201617'
WHERE the_geom is not null;

UPDATE capitalplanning.doe_2016_demographics
SET the_geom = l.the_geom
FROM doe_2017_school_locations AS l
WHERE doe_2016_demographics.dbn = l.dcp_dbn;

UPDATE capitalplanning.doe_2016_demographics
SET geom_source = 'School Locations 201718'
WHERE the_geom is not null
AND geom_source is null;

UPDATE capitalplanning.doe_2016_demographics
SET the_geom = b.the_geom
FROM dcpadmin.doe_bluebook_organization_20162017 AS b
WHERE doe_2016_demographics.the_geom is null
AND doe_2016_demographics.org_id = b.org_id
AND dbn not like '79%';

UPDATE capitalplanning.doe_2016_demographics
SET geom_source = 'Blue Book 201617'
WHERE geom_source is null
AND the_geom is not null;
