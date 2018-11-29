#!/bin/bash

# make sure we are at the top of the git directory
REPOLOC="$(git rev-parse --show-toplevel)"
cd $REPOLOC

# load config
DBNAME=$(cat $REPOLOC/sca.config.json | jq -r '.DBNAME')
DBUSER=$(cat $REPOLOC/sca.config.json | jq -r '.DBUSER')

echo "Starting to build SCA"


# create the table
echo 'Creating base SCA Capacity Projects table'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/create_sca_cp_cap_joined.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/create_sca_cp_prek_joined.sql

psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/create_sca_cp_capacity_projects.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/sca_geoms_id_capacity_projects.sql


echo 'Creating base SCA School Programs table'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/sca_geoms_id_school_programs.sql

echo 'Creating the summary statistics table'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/qa_summary_stats.sql