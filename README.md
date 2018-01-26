# SCA Capital Projects Database

The School Construction Authority (SCA) is purposefully seperated from other City agencies and as a result the authority has its own captial plan.  Each year OMB provides one large lump sum of monies to SCA, and these lump sums are reflected in the Captial Commitment Plan as projects (i.e. FMS ID 040SCA22).  Once SCA receives the funds SCA then has the freedom to spend those monies in whatever ways it thinks are best.  Therefore, the SCA Capital Plan is different and published seperately from OMB's Capital Commitment Plan.

To following instructs how to build the SCA Captial Projects Database

## Setup

1) In *sca.sh* update the url of the curl command to the desired SCA Captial Plan you'd like to download and scrape data from.

2) Update the page numbers of the sections that need scraping in each of the the *sca-scrape/script_XXXX.js* files

The section of code that will need to be updated looks like this:
```javascript
  //we only want 195 thru 357 
    for (var i=194; i<357; i++) {
    var pageText = pages[i];
```
The page numbers are referenced as an index; therefore, beginning at 0 so the starting page number will be one less than the actual page number of the pdf.

Unfortunately, the format of the SCA Capital Plan can change year to year.  Therefore, the detials in the scripts that scrape the data may need to be updated or new scrapers may need to be written for future SCA Capital Plans.

### Key sections

These are the sections of the SCA Captial Plan that are scraped and compiled to create the SCA Captial Projects Database. The page references refer to [this verison](https://dnnhh5cc1.blob.core.windows.net/portals/0/Capital_Plan/Capital_plans/02212017_15_19_CapitalPlan.pdf?sr=b&si=DNNFileManagerPolicy&sig=OX9FirACJei0K5EVkBEMSB4BGQO2ri18hqNu%2BpsuTWE%3D) of SCA's Captial Plan.  

#### Capital investments
1) Added Projects (p 130)
2) Cancelled Projects (p 202)
3) Projects Advanced to FY 20XX (p 127)
4) School Based Report (p 213)

#### Capacity projects
1) Capacity Projects (p 71)
2) Capacity Site Locations (p 76)
3) PreK Capacity Projects (p 79)
4) PreK Capacity Site Locations (p 83)
5) Replacement Projects (p 85)
6) Replacement Site Locations (page missing from 02212017_15_19_CapitalPlan)

## Run 

Run **sca.sh** which does the following
1) Downloads the SCA plan
2) Runs *sca-scrape/script_* files to scrape the data from the specified sections and outputs a series of .csv files
3) Appends all of the .csvs, except *output_SchoolBasedReport.csv* into one .csv
4) Pushes the data into the postgres database as *sca_cp* and *sca_cp_detailed*
5) Adds building id to sca_cp_detailed from sca_cp to enable mapping of these data
6) Appends point geometries by matching the building id in sca_cp and sca_cp_detailed to the building id in the *doe_facilities_lcgms* or *doe_facilities_schoolsbluebook* table
7) Appends point geometries from lat/long data obtained from GeoClient for recrods that do not have a building id but do have an address
8) Appends school district geometries onto records that could not be mapped to a specific site
9) Adds on the facility id, which links to the Facilities Database, and the Community District ID
10) Exports the database tables into */output* so that the files can be uploaded to Carto
	* sca_cp.csv
	* sca_cp_detailed.csv
	* sca_cp_pts.geojson
	* sca_cp_poly.geojson
	* sca_cp_detailed_pts.geojson
	* sca_cp_detailed_poly.geojson


















