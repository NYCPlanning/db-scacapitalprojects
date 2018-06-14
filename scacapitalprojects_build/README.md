# SCA Capital Projects Database

The School Construction Authority (SCA) is purposefully seperated from other City agencies and as a result the authority has its own captial plan.  Each year OMB provides one large lump sum of monies to SCA, and these lump sums are reflected in the Captial Commitment Plan as projects (i.e. FMS ID 040SCA22).  Once SCA receives the funds SCA then has the freedom to spend those monies in whatever ways it thinks are best.  Therefore, the SCA Capital Plan is different and published seperately from OMB's Capital Commitment Plan.

To following instructs how to build the SCA Captial Projects Database

### Prerequisites:

1. Bash > 4.0

2. node.js

3. psql 9.5.5
   
4. If psql role you intend to use is not your unix name, set up a .pgpass file like this:
    *:*:*:dbadmin:dbadmin_password
    ~/.pgpass should have permissions 0600 (chmod 0600 ~/.pgpass)


### Development workflow

#### Fill in configuration files

**sca.config.json**

Your config file should look something like this:
{
"DBNAME":"databasename",
"DBUSER":"databaseuser",
"GEOCLIENT_APP_ID":"id",
"GEOCLIENT_APP_KEY":"key"
}

#### Prepare data-loading-scripts

Clone and configure the data-loading-scripts repo: https://github.com/NYCPlanning/data-loading-scripts 
Make sure the database data-loading-scripts uses is the same one you listed in your sca.config.json file.

#### Build SCA 

Run the scripts in scacapitalprojects_build (PATH : /db-scacapitalprojects/scacapitalprojects_build) in order:

#### 01_dataloading.sh

Download and load all input datasets required to create SCA tables into database from the open source. Datasets created are :
sca_cp_cap_location
sca_cp_cap_schools
sca_cp_prek_location
sca_cp_prek_schools
sca_cp_class_size_reduction
sca_cp_rep_schools
sca_cp_programs
sca_cp_projects

#### 02_build.sh

Build SCA based on the input datasets. It will build intermediate tables and then drop the intermediate tables to create the final three datasets according to the three groups:
Non-capacity Projects - sca_cp_school_programs
Capacity Projects - sca_cp_capacity_projects
Proejcts without dollar amounts - sca_cp_projects

#### 03_export.sh

Export the tables created into .csv and geojson format.

#### Maintenance information

#### Release schedule

Database is updated and released with the publication of each SCA Capital Plan.