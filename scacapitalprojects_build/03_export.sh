#!/bin/bash

# make sure we are at the top of the git directory
REPOLOC="$(git rev-parse --show-toplevel)"
cd $REPOLOC

# load config
DBNAME=$(cat $REPOLOC/sca.config.json | jq -r '.DBNAME')
DBUSER=$(cat $REPOLOC/sca.config.json | jq -r '.DBUSER')

# eventually these should copy directly from psql to carto
# for now, write to files which can by copied

# points
ogr2ogr -f "GeoJSON" scacapitalprojects_build/output/sca_cp_capacity_projects.geojson PG:"host=localhost dbname=$DBNAME user=$DBUSER" -sql "SELECT * FROM sca_cp_capacity_projects WHERE ST_GeometryType(geom)='ST_Point'"
ogr2ogr -f "GeoJSON" scacapitalprojects_build/output/sca_cp_school_programs.geojson PG:"host=localhost dbname=$DBNAME user=$DBUSER" -sql "SELECT * FROM sca_cp_school_programs WHERE ST_GeometryType(geom)='ST_Point'"
#ogr2ogr -f "GeoJSON" scacapitalprojects_build/output/sca_cp_projects.geojson PG:"host=localhost dbname=$DBNAME user=$DBUSER" \
#-sql "SELECT * FROM sca_cp_projects AND ST_GeometryType(geom)='ST_Point'"

# Output individual helper tables
# cpdb_commitments
psql -U $DBUSER -d $DBNAME -c "COPY( SELECT * FROM sca_cp_capacity_projects) TO '$REPOLOC/scacapitalprojects_build/output/sca_cp_capacity_projects.csv' DELIMITER ',' CSV HEADER;"
psql -U $DBUSER -d $DBNAME -c "COPY( SELECT * FROM sca_cp_school_programs) TO '$REPOLOC/scacapitalprojects_build/output/sca_cp_school_programs.csv' DELIMITER ',' CSV HEADER;"
psql -U $DBUSER -d $DBNAME -c "COPY( SELECT * FROM sca_cp_projects) TO '$REPOLOC/scacapitalprojects_build/output/sca_cp_projects.csv' DELIMITER ',' CSV HEADER;"
psql -U $DBUSER -d $DBNAME -c "COPY( SELECT * FROM qa_summary_stats) TO '$REPOLOC/scacapitalprojects_build/output/qa_summary_stats.csv' DELIMITER ',' CSV HEADER;"

\copy (SELECT * FROM sca_cp_capacity_projects) TO '/prod/db-scacaptialprojects/scacapitalprojects_build/output/sca_cp_capacity_projects.csv' DELIMITER ',' CSV HEADER;
\copy (SELECT * FROM sca_cp_school_programs) TO '/prod/db-scacaptialprojects/scacapitalprojects_build/output/sca_cp_school_programs.csv' DELIMITER ',' CSV HEADER;
#\copy (SELECT * FROM sca_cp_projects) TO '/prod/db-scacaptialprojects/scacapitalprojects_build/output/sca_cp_projects.csv' DELIMITER ',' CSV HEADER;
\copy (SELECT * FROM qa_summary_stats) TO '/prod/db-scacaptialprojects/scacapitalprojects_build/output/qa_summary_stats.csv'DELIMITER ',' CSV HEADER;
\copy (SELECT * FROM sca_output_carto) TO '/prod/db-scacaptialprojects/scacapitalprojects_build/output/sca_output_carto.csv'DELIMITER ',' CSV HEADER;

\copy (SELECT * FROM sca_cp_capacity_projects WHERE geom IS NULL) TO '/prod/db-scacaptialprojects/scacapitalprojects_build/output/sca_cp_capacity_projects_nogeom.csv' DELIMITER ',' CSV HEADER;
\copy (SELECT * FROM sca_cp_school_programs WHERE geom IS NULL) TO '/prod/db-scacaptialprojects/scacapitalprojects_build/output/sca_cp_school_programs_nogeom.csv' DELIMITER ',' CSV HEADER;