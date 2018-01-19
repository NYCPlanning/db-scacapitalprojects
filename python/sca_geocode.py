import pandas as pd
import subprocess
import os
import sqlalchemy as sql
import json
from nyc_geoclient import Geoclient

# make sure we are at the top of the repo
wd = subprocess.check_output('git rev-parse --show-toplevel', shell = True)
os.chdir(wd[:-1]) #-1 removes \n

# load config file
with open('sca.config.json') as conf:
    config = json.load(conf)

DBNAME = config['DBNAME']
DBUSER = config['DBUSER']
# load necessary environment variables
app_id = config['GEOCLIENT_APP_ID']
app_key = config['GEOCLIENT_APP_KEY']

# connect to postgres db
engine = sql.create_engine('postgresql://{}@localhost:5432/{}'.format(DBUSER, DBNAME))

# read in sca table
sca = pd.read_sql_query('SELECT * FROM sca_cp WHERE geom is NULL AND location is not NULL;', engine)

# get the geo data

g = Geoclient(app_id, app_key)

def get_loc(num, street, boro):
    geo = g.address(num, street, boro)
    try:
        b_in = geo['buildingIdentificationNumber']
    except:
        b_in = 'none'
    try:
        lat = geo['latitude']
    except:
        lat = 'none'
    try:
        lon = geo['longitude']
    except:
        lon = 'none'
    loc = pd.DataFrame({'bin' : [b_in],
                        'lat' : [lat],
                        'lon' : [lon]})
    return(loc)

locs = pd.DataFrame()
for i in range(len(sca)):
    new = get_loc(sca['location'][i].split(' ',1)[0],
                  sca['location'][i].split(' ',1)[1],
                  sca['borough'][i]
    )
    locs = pd.concat((locs, new))
locs.reset_index(inplace = True)

# update the sca geom based on bin

for i in range(len(sca)):
    if locs['bin'][i] != 'none': 
        upd = "UPDATE sca_cp a SET geom = ST_Centroid(b.geom) FROM doitt_buildingfootprints b WHERE a.location = '"+ sca['location'][i] + "' AND b.bin = '"+ locs['bin'][i] + "';"
    elif (locs['lat'][i] != 'none') & (locs['lon'][i] != 'none'):
        upd = "UPDATE sca_cp a SET geom = ST_SetSRID(ST_MakePoint(" + str(locs['lon'][i]) + ", " + str(locs['lat'][i]) + "), 4326) WHERE location = '" + sca['location'][i] + "';"
    engine.execute(upd)



# not deleting because if I ever figure it out this is probably a better way of doing this... 
#md = sql.MetaData(engine)
#table = sql.Table('sca', md, autoload=True)
#upd = table.update(values={
