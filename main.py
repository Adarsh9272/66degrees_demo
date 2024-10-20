import os
import kaggle
import pandas as pd
from google.cloud import bigquery
from datetime import datetime


file_name = 'supermarket_sales - Sheet1.csv'
data_path = 'C:/Users/adarsh.vishwakarm/OneDrive - TTEC Digital/Desktop/66'
kaggle_dataset = 'aungpyaeap/supermarket-sales'

Customers = ['Customer type', 'Gender', 'City', 'Branch']
Products = ['Product line', 'Unit price']
Sales = ['Invoice ID', 'Date', 'Time', 'Quantity', 'Tax 5%', 'Total', 'cogs', 'gross margin percentage', 'gross income', 'Rating', 'Payment', 'Product line', 'Branch']

dataset_id = '66d_demo'
customers_table = f'{dataset_id}.customers'
products_table = f'{dataset_id}.products'
sales_table = f'{dataset_id}.sales'

# kaggle.api.authenticate()
# kaggle.api.dataset_download_files(f'{kaggle_dataset}', path=f'{data_path}/data', unzip=True)

df = pd.read_csv(f'{data_path}/data/{file_name}')

df_customers = df[Customers]
df_products = df[Products]
df_sales = df[Sales]

def convert_date(date_str):
    try:
        return datetime.strptime(date_str, '%m-%d-%Y')
    except ValueError:
        return datetime.strptime(date_str, '%m/%d/%Y')

df_sales['Date'] = df_sales['Date'].apply(convert_date)
df_sales['Order Timestamp'] = pd.to_datetime(df_sales['Date'].astype(str) + ' ' + df_sales['Time'], format='%Y-%m-%d %H:%M')
df_sales.drop(['Date', 'Time'], axis=1, inplace=True)

client = bigquery.Client()
def load_to_bigquery(df, table_id):
    job = client.load_table_from_dataframe(df, table_id)
    job.result()
    print(f"Loaded {df.shape[0]} rows into {table_id}")

load_to_bigquery(df_customers, customers_table)
load_to_bigquery(df_products, products_table)
load_to_bigquery(df_sales, sales_table)
