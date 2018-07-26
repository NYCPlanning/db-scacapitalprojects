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
ogr2ogr -u $DBUSER -f scacapitalprojects_build/output/sca_cp_capacity_projects $DBNAME "SELECT * FROM sca_cp_capacity_projects AND ST_GeometryType(geom)='ST_Point'"
ogr2ogr -u $DBUSER -f scacapitalprojects_build/output/sca_cp_school_programs $DBNAME "SELECT * FROM sca_cp_school_programs AND ST_GeometryType(geom)='ST_Point'"
ogr2ogr -u $DBUSER -f scacapitalprojects_build/output/sca_cp_projects $DBNAME "SELECT * FROM sca_cp_projects AND ST_GeometryType(geom)='ST_Point'"

# Output individual helper tables
# cpdb_commitments
psql -U $DBUSER -d $DBNAME -c "COPY( SELECT * FROM sca_cp_capacity_projects) TO '$REPOLOC/scacapitalprojects_build/output/sca_cp_capacity_projects.csv' DELIMITER ',' CSV HEADER;"
psql -U $DBUSER -d $DBNAME -c "COPY( SELECT * FROM sca_cp_school_programs) TO '$REPOLOC/scacapitalprojects_build/output/sca_cp_school_programs.csv' DELIMITER ',' CSV HEADER;"
psql -U $DBUSER -d $DBNAME -c "COPY( SELECT * FROM sca_cp_projects) TO '$REPOLOC/scacapitalprojects_build/output/sca_cp_projects.csv' DELIMITER ',' CSV HEADER;"
psql -U $DBUSER -d $DBNAME -c "COPY( SELECT * FROM qa_summary_stats) TO '$REPOLOC/scacapitalprojects_build/output/qa_summary_stats.csv' DELIMITER ',' CSV HEADER;"

\copy (SELECT * FROM sca_cp_capacity_projects) TO '/prod/db-scacaptialprojects/scacapitalprojects_build/output/sca_cp_capacity_projects.csv' DELIMITER ',' CSV HEADER;
\copy (SELECT * FROM sca_cp_school_programs) TO '/prod/db-scacaptialprojects/scacapitalprojects_build/output/sca_cp_school_programs.csv' DELIMITER ',' CSV HEADER;
\copy (SELECT * FROM sca_cp_projects) TO '/prod/db-scacaptialprojects/scacapitalprojects_build/output/sca_cp_projects.csv' DELIMITER ',' CSV HEADER;
\copy (SELECT * FROM qa_summary_stats) TO '/prod/db-scacaptialprojects/scacapitalprojects_build/output/qa_summary_stats.csv'DELIMITER ',' CSV HEADER;
\copy (SELECT * FROM sca_output_carto) TO '/prod/db-scacaptialprojects/scacapitalprojects_build/output/qa_summary_stats.csv'DELIMITER ',' CSV HEADER;