/**4. Add school quality review results for elementary, middle, and high schools
Prep school quality review source datasets. Results from transfer high schools, SPED, ECC, YABC NOT added*/

-- Go to http://schools.nyc.gov/Accountability/tools/report/default.htm
-- Scroll down to Citywide Results and download the following:
  School Quality Reports Results for elementary, middle and K-8 schools
  School Quality Reports Results for high school
-- Create master CSV combining these 2 datasets (de-duped where a school is in both datasets - such as an ISHS)

DELETE FROM capitalplanning.doe_ems_hs_qualityreview_201617
WHERE dbn = '';

ALTER TABLE capitalplanning.doe_ems_hs_qualityreview_201617
ADD COLUMN blended_sqr_score numeric;

UPDATE capitalplanning.doe_ems_hs_qualityreview_201617
SET blended_sqr_score = round((rigorous_instruction + collaborative_teachers + supportive_environment + effective_school_leadership + strong_family_community_ties + trust)/6),2
WHERE rigorous_instruction is not null
OR collaborative_teachers is not null
OR supportive_environment is not null
OR effective_school_leadership is not null
OR strong_family_community_ties is not null
OR trust is not null;

UPDATE capitalplanning.doe_ems_hs_qualityreview_201617
SET blended_sqr_score = round(blended_sqr_score,2);
