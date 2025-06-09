import database_connection
import pandas as pd
import os
def read_tables(table_names:list,conn):
    dataframes = {}
    for table in table_names:
        query = f"SELECT * FROM {table}"
        dataframes[f"{table}_df"] = pd.read_sql_query(query, conn)
    return dataframes
def load_data(db_path):
    conn=database_connection.connect_to_database(db_path)
    cursor=conn.cursor()
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()
    table_names= [table[0] for table in tables]
    data_frames=read_tables(table_names,conn)
    return data_frames
data_frames=load_data('database/final_data.db')
for name,data_frame in data_frames.items():
    data_frame.to_csv(f"data/{name}.csv", index=False)
    print(f"wrote {name} to file")
