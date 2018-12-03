-- DROP TABLE IF EXISTS qa_summary_stats;
-- CREATE TABLE qa_summary_stats AS 
-- (
-- SELECT 'Non-capacity Projects' AS Group, COUNT(*), (COUNT(geom)*100.00) :: NUMERIC /COUNT(*) AS Percentage_mapped, 'sca_cp_school_programs' AS Table, 'sca_cp_programs' AS OPenSource_Table
-- FROM sca_cp_school_programs
-- UNION ALL
-- SELECT 'Projects with dollar amounts' AS Group, COUNT(*), (COUNT(geom)*100.00) :: NUMERIC /COUNT(*) AS Percentage_mapped, 'sca_cp_projects' AS Table, source AS OPenSource_Table
-- FROM sca_cp_projects
-- GROUP BY source
-- UNION ALL
-- SELECT 'Capacity Projects' AS group, COUNT(*), (COUNT(geom)*100.00) :: NUMERIC /COUNT(*) AS Percentage_mapped, 'sca_cp_capacity_projects' AS Table, CASE 
-- WHEN description = 'Capacity projects' THEN 'Join of sca_cp_cap_location and sca_cp_cap_schools' 
-- WHEN description = 'PRE-K Capacity projects' THEN 'Join of sca_cp_prek_location and sca_cp_prek_schools' 
-- WHEN description = 'Class Size Reduction Capacity projects' THEN 'sca_cp_class_size_reduction' 
-- ELSE 'sca_cp_rep_schools' 
-- END AS OPENSource_Table
-- FROM sca_cp_capacity_projects
-- GROUP BY description
-- );

DROP TABLE IF EXISTS qa_summary_stats;
CREATE TABLE qa_summary_stats AS 
(
SELECT 'Non-capacity Projects' AS Group, COUNT(*), (COUNT(geom)*100.00) :: NUMERIC /COUNT(*) AS Percentage_mapped, 'sca_cp_school_programs' AS Table, 'sca_cp_programs' AS OPenSource_Table
FROM sca_cp_school_programs
UNION ALL
SELECT 'Capacity Projects' AS group, COUNT(*), (COUNT(geom)*100.00) :: NUMERIC /COUNT(*) AS Percentage_mapped, 'sca_cp_capacity_projects' AS Table, CASE 
WHEN lower(description) = 'capacity projects' THEN 'Join of sca_cp_cap_location and sca_cp_cap_schools' 
WHEN lower(description) = 'pre-k capacity projects' THEN 'Join of sca_cp_prek_location and sca_cp_prek_schools' 
WHEN lower(description) = 'pre-k three capacity projects' THEN 'Join of sca_cp_threeprek_location and sca_cp_threeprek_schools' 
ELSE NULL
END AS OPENSource_Table
FROM sca_cp_capacity_projects
GROUP BY description
);