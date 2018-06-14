

ALTER TABLE capitalplanning.doe_2016_demographics
ADD COLUMN blended_sqr_score numeric;

UPDATE capitalplanning.doe_2016_demographics
SET blended_sqr_score = q.blended_sqr_score
FROM doe_ems_hs_qualityreview_201617 AS q
WHERE doe_2016_demographics.dbn = q.dbn;

SELECT sum(total_enrollment), count (*) FROM capitalplanning.doe_2016_demographics
WHERE blended_sqr_score is null
AND x_alternative is null
AND x_charter is null
AND x_school_type = 'General Academic';
