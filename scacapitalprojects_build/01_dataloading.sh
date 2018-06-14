#!/bin/bash

################################################################################################
### OBTAINING DATA
################################################################################################
### NOTE: This script requires you to setup the DATABASE_URL environment variable.
### Directions are in the README.md.

## Load all datasets from sources using the civic data loader
## https://github.com/NYCPlanning/data-loading-scripts

cd '/prod/data-loading-scripts'

## Open_datasets - PULLING FROM OPEN DATA
echo 'Loading open source datasets...'
node loader.js install sca_cp_added_projects
node loader.js install sca_cp_advanced_projects
node loader.js install sca_cp_cancelled_projects
node loader.js install sca_cp_cap_location
node loader.js install sca_cp_class_size_reduction
node loader.js install sca_cp_prek_location
node loader.js install sca_cp_prek_schools
node loader.js install sca_cp_programs
node loader.js install sca_cp_rep_schools

## Other_datasets - PULLING FROM PLUTO GitHub repo
##echo 'Loading datasets from PLUTO GitHub repo...'
