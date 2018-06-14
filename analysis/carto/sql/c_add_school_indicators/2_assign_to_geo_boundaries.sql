/**2. Assign schools to boundaries for analysis**/

ALTER TABLE capitalplanning.doe_2016_demographics
ADD COLUMN geo_csd text,
ADD COLUMN geo_borocd text,
ADD COLUMN geo_subdist text;

UPDATE capitalplanning.doe_2016_demographics 
SET geo_csd = s.schooldist
FROM nyc_school_districts AS s
WHERE ST_Within(doe_2016_demographics.the_geom,s.the_geom);

UPDATE capitalplanning.doe_2016_demographics 
SET geo_borocd = c.borocd
FROM dcpadmin.nyc_communitydistricts AS c
WHERE ST_Within(doe_2016_demographics.the_geom,c.the_geom);

UPDATE capitalplanning.doe_2016_demographics 
SET geo_subdist = s.distzone
FROM dcpadmin.doe_schoolsubdistricts AS s
WHERE ST_Within(doe_2016_demographics.the_geom,s.the_geom);

--Check that each mapped school has been assigned to a geo boundary (query should yield no results)

SELECT * FROM capitalplanning.doe_2016_demographics 
WHERE the_geom is not null
AND (geo_csd is null
OR geo_borocd is null
OR geo_subdist is null);
