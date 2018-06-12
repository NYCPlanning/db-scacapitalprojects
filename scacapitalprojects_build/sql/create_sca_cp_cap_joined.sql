--Create table sca_cp_projects for Group Projects without dollar amounts
DROP TABLE IF EXISTS sca_cp_cap_joined;
CREATE TABLE sca_cp_cap_joined AS 
(SELECT a.district, a.school, a.projectnum, 'capacity projects' AS description, b.location, b.latitude, b.longitude, a.totalestcost, substring(a.actualestcompl, 1, strpos (a.actualestcompl,'-')-1) actualestcompl_month,
substring(a.actualestcompl, strpos(a.actualestcompl,'-')+1, length(a.actualestcompl)) actualestcompl_year
FROM sca_cp_cap_schools a
LEFT JOIN sca_cp_cap_location b
ON a.school = b.school);

ALTER TABLE sca_cp_cap_joined ADD COLUMN fy INT;

ALTER TABLE sca_cp_cap_joined ALTER COLUMN actualestcompl_year TYPE INTEGER USING (trim(actualestcompl_year)::integer);

UPDATE sca_cp_cap_joined 
SET fy = CASE
    WHEN (actualestcompl_month IN ('Jul','Aug', 'Sep', 'Oct', 'Nov', 'Dec') ) THEN actualestcompl_year+2001
    ELSE actualestcompl_year+2000
    END ;
