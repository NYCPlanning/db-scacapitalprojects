#!/bin/bash

# make sure we are at the top of the git directory
REPOLOC="$(git rev-parse --show-toplevel)"
cd $REPOLOC

# load config
DBNAME=$(cat $REPOLOC/sca.config.json | jq -r '.DBNAME')
DBUSER=$(cat $REPOLOC/sca.config.json | jq -r '.DBUSER')

start=$(date +'%T')
echo "Starting to build SCA"

# create the table
echo 'Creating base SCA table'
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/create_sca_cp_projects.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/create_sca_cp_cap_joined.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/create_sca_cp_prek_joined.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/create_sca_cp_class_size_reduction_join.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/create_sca_cp_rep_schools_join.sql
psql -U $DBUSER -d $DBNAME -f $REPOLOC/scacapitalprojects_build/sql/create_sca_cp_capacity_projects.sql




	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/bbl.sql

	# # populate RPAD data
	# echo 'Adding on RPAD data attributes'
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/allocated.sql
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/geocodes.sql

	# # add on CAMA data attributes
	# echo 'Adding on CAMA data attributes'
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/cama_bsmttype.sql
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/cama_lottype.sql
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/cama_proxcode.sql
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/cama_bldgarea.sql
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/cama_easements.sql

	# # populate other fields from misc sources
	# echo 'Adding on data attributes from other sources'
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/landuse.sql
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/lpc.sql
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/zoning.sql
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/far.sql
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/edesignation.sql

	# echo 'Transform RPAD data attributes'
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/irrlotcode.sql
	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/colp.sql

	# psql -U $DBUSER -d $DBNAME -f $REPOLOC/pluto_build/sql/ipis.sql