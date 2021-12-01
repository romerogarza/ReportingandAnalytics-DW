import requests
import pandas as pd
import json
import pyodbc 
from datetime import datetime

begin_time = datetime.now()

def get_data():
    url = r'https://datausa.io/api/data?drilldowns=State&measures=Population&year=latest'
    urlData = requests.get(url)
    json_data = urlData.json()
    data = pd.DataFrame(json_data['data'])
    data['UP_DT_TM'] = pd.to_datetime('today')
    
    return data

df = get_data()

def insert_rows():
    try:
        conn = pyodbc.connect('Driver={SQL Server};''Server=LIBRARIAN;''Database=DW;''Trusted_Connection=yes;')

        cursor = conn.cursor()

        for index,row in df.iterrows():
            cursor.execute("INSERT INTO dbo.api_test([ID],[STATE],[ID_YEAR],[YEAR],[POPULATION],[SLUG_STATE],[UP_DT_TM]) values (?,?,?,?,?,?,?)"
                           , row['ID State'], row['State'], row['ID Year'], row['Year'], row['Population'], row['Slug State'], row['UP_DT_TM'])
            conn.commit()

        cursor.close()
        conn.close()
    except:
        status = 'FAILED'
        row_count = '0'
        end_time = datetime.now()
        return status,row_count,end_time
    else:
        status = 'SUCCESS'
        row_count = str(len(df.index))
        end_time = datetime.now()
        return status ,row_count,end_time

run_job = insert_rows()

def job():
    try:
        job_name = 'Census API'
        duration = str(run_job[2] - begin_time)

        job_data = {'Job_name':[job_name]
                    ,'begin_time':[begin_time]
                    ,'end_time':[run_job[2]]
                    ,'duration':[duration]
                    ,'status':[run_job[0]]
                    ,'rows_entered':[run_job[1]]
                    ,'up_dt_tm':[datetime.now()]
                   }

        job_df = pd.DataFrame(job_data)

        conn = pyodbc.connect('Driver={SQL Server};''Server=LIBRARIAN;''Database=DW;''Trusted_Connection=yes;')
        cursor = conn.cursor()

        for index,row in job_df.iterrows():
            cursor.execute("INSERT INTO dbo.python_jobs([JOB_NAME],[BEG_TIME],[END_TIME],[DURATION],[STATUS],[ROW_COUNT],[UP_DT_TM]) values (?,?,?,?,?,?,?)"
                           , row['Job_name'], row['begin_time'], row['end_time'], row['duration'], row['status'], row['rows_entered'], row['up_dt_tm'])
            conn.commit()

        cursor.close()
        conn.close()
    except:
        status = 'FAILED'
        return status
    else:
        status = 'SUCCESS'
        return status

run_python_job = job()

#run at 5 AM