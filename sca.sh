#!/bin/bash

# make sure we are at the top of the git directory
REPOLOC="$(git rev-parse --show-toplevel)"
cd $REPOLOC

# load config
DBNAME=$(cat $REPOLOC/sca.config.json | jq -r '.DBNAME')
DBUSER=$(cat $REPOLOC/sca.config.json | jq -r '.DBUSER')

# download the sca plan
curl 'https://dnnhh5cc1.blob.core.windows.net/portals/0/Capital_Plan/Capital_plans/09212017_10_14_CapitalPlan.pdf?sr=b&si=DNNFileManagerPolicy&sig=BnJScVoCkNE8%2B0BQ%2B1I0NrfIxDMQHdokHUFBPOU1wYM%3D' -o sca-scrape/sca_plan.pdf

# scrape
for script in $(ls $REPOLOC/sca-scrape/ | grep 'script_')
do
    node $REPOLOC/sca-scrape/$script
done

# append all outputs into one csv
python $REPOLOC/sca-scrape/merge_csv.py

# push to psql
python $REPOLOC/sca-scrape/sca_to_psql.py
python $REPOLOC/sca-scrape/sca_to_psql_detailed.py

# add building id to sca_cp_detailed from sca_cp

psql -U $DBUSER -d $DBNAME -f $REPOLOC/sql/sca_details_buildingid.sql

# merge geoms by school id
psql -U $DBUSER -d $DBNAME -f $REPOLOC/sql/sca_geoms_id.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/sql/sca_geoms_id_detailed.sql

# get geoms from geoclient
source activate py2
python $REPOLOC/python/sca_geocode.py
source deactivate

# merge geoms by district
psql -U $DBUSER -d $DBNAME -f $REPOLOC/capitalprojects_build/sql/sca_geoms_dist.sql

# merge facility id from facDB
psql -U $DBUSER -d $DBNAME -f $REPOLOC/capitalprojects_build/sql/sca_facid.sql

# merge community district from cds
psql -U $DBUSER -d $DBNAME -f $REPOLOC/capitalprojects_build/sql/sca_cd_detailed.sql

cd $REPOLOC
