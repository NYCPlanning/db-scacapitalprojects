--Create table sca_cp_projects for Group Projects without dollar amounts
DROP TABLE IF EXISTS sca_cp_rep_schools_join;
CREATE TABLE sca_cp_rep_schools_join AS 
(
SELECT district, school, projectnum, totalestcost, substring(actualestcompl, 1, strpos (actualestcompl,'-')-1) actualestcompl_month,
substring(actualestcompl, strpos(actualestcompl,'-')+1, length(actualestcompl)) actualestcompl_year
FROM sca_cp_rep_schools
);

ALTER TABLE sca_cp_rep_schools_join ADD fy INT;

ALTER TABLE sca_cp_rep_schools_join ALTER COLUMN actualestcompl_year TYPE INTEGER USING (trim(actualestcompl_year)::integer);

UPDATE sca_cp_rep_schools_join 
SET fy = CASE
    WHEN (actualestcompl_month IN ('Jul','Aug', 'Sep', 'Oct', 'Nov', 'Dec') ) THEN actualestcompl_year+2001
    ELSE actualestcompl_year+2000
    END ;


ALTER TABLE sca_rep_schools_join ADD COLUMN longitude text;
ALTER TABLE sca_cp_rep_schools_join ADD COLUMN latitude text;
ALTER TABLE sca_cp_rep_schools_join ADD COLUMN location text;
ALTER TABLE sca_cp_rep_schools_join ADD COLUMN description text;
UPDATE sca_cp_rep_schools_join 
SET description = 'Replacement schools Capacity Projects';