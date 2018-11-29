#!/bin/bash

################################################################################################
### OBTAINING DATA
################################################################################################

## Load all datasets from sources using the civic data loader
## https://github.com/NYCPlanning/data-loading-scripts

cd '/prod/data-loading-scripts'

## Open_datasets - PULLING FROM OPEN DATA
echo 'Loading open source datasets...'
node loader.js install sca_cp_added_projects
node loader.js install sca_cp_advanced_projects
node loader.js install sca_cp_cancelled_projects
node loader.js install sca_cp_class_size_reduction
node loader.js install sca_cp_rep_schools

cd '/prod/db-cbbr'

# make sure we are at the top of the git directory
REPOLOC="$(git rev-parse --show-toplevel)"
cd $REPOLOC

# load config
DBNAME=$(cat $REPOLOC/sca.config.json | jq -r '.DBNAME')
DBUSER=$(cat $REPOLOC/sca.config.json | jq -r '.DBUSER')

echo "Starting to build SCA"

# create the table
echo 'Creating base SCA Projects table'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/create_sca_cp_projects.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/sca_geoms_id_projects.sql

psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/create_sca_cp_class_size_reduction_join.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/create_sca_cp_rep_schools_join.sql