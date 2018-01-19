from sqlalchemy import create_engine
import pandas as pd
import subprocess
import os
import json

# make sure we are at the top of the repo
wd = subprocess.check_output('git rev-parse --show-toplevel', shell = True)
os.chdir(wd[:-1]) #-1 removes \n

# load config file
with open('./sca.config.json') as conf:
    config = json.load(conf)

DBNAME = config['DBNAME']
DBUSER = config['DBUSER']

# connect to postgres db
engine = create_engine('postgresql://{}@localhost:5432/{}'.format(DBUSER, DBNAME))

# read in data from csv
sca = pd.read_csv('/sca-scrape/auto_output.csv')
sca.columns = [c.replace('_','') for c in sca.columns]

# write new table to postgres
sca.to_sql('sca_cp_detailed', engine, if_exists='replace', index=False)
