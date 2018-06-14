/**3. Add flags for various school types**/

ALTER TABLE capitalplanning.doe_2016_demographics
ADD COLUMN x_charter text,
ADD COLUMN x_alternative text,
ADD COLUMN x_citywide text,
ADD COLUMN x_school_type text;

UPDATE capitalplanning.doe_2016_demographics
SET x_charter = 'Charter'
WHERE left(dbn,2) = '84';

UPDATE capitalplanning.doe_2016_demographics
SET x_alternative = 'Alternative'
WHERE left(dbn,2) = '79';

UPDATE capitalplanning.doe_2016_demographics
SET x_citywide = 'Citywide'
WHERE org_id IN ('X445',
'K449',
'K430',
'M692',
'X696',
'Q687',
'R605',
'M475',
'M539',
'M334',
'M012',
'K686',
'Q300');

UPDATE capitalplanning.doe_2016_demographics
SET x_school_type = l.location_type_description
FROM doe_2017_school_locations AS l
WHERE doe_2016_demographics.dbn = l.dcp_dbn;
