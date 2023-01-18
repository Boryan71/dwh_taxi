#!/usr/bin/python3
import psycopg2
import pandas as pd
import taxi_config as conf
from inc_func import clean_stg, catch_meta

# ***** Подключение к хранилищу

dwh_fault = None
bank_fault = None
taxi_fault = None

try:
    connection_dwh = psycopg2.connect(
        database=conf.dwh_database,
        host=conf.dwh_host,
        user=conf.dwh_user,
        password=conf.dwh_password,
        port=conf.dwh_port)
except Exception as ex:
    print('...Ошибка подключения к хранилищу...')
    print(ex)
    dwh_fault = ex
finally:
    if dwh_fault is None:
        print('Подключение к хранилищу установлено.')

# ***** Подключение к банку

try:
    connection_bank = psycopg2.connect(
        database=conf.bank_database,
        host=conf.bank_host,
        user=conf.bank_user,
        password=conf.bank_password,
        port=conf.bank_port)
except Exception as ex:
    print('...Ошибка подключения к банку...')
    print(ex)
    bank_fault = ex
finally:
    if bank_fault is None:
        print('Подключение к банку установлено.')

# ***** Подключение к такси

try:
    connection_taxi = psycopg2.connect(
        database=conf.taxi_database,
        host=conf.taxi_host,
        user=conf.taxi_user,
        password=conf.taxi_password,
        port=conf.taxi_port)
except Exception as ex:
    print('...Ошибка подключения к службе такси...')
    print(ex)
    taxi_fault = ex
finally:
    if taxi_fault is None:
        print('Подключение к службе такси установлено.')

# ***** Отключение автокоммита

connection_dwh.autocommit = False

# ***** Создание курсоров

dwh_cursor = connection_dwh.cursor()
bank_cursor = connection_bank.cursor()
taxi_cursor = connection_taxi.cursor()


# ******************************************************************************************************************
# ************************************** Работа с измерением Drivers ***********************************************
# ******************************************************************************************************************

# ***** Очистка стейджингов Drivers

cursor = dwh_cursor
stg = 'dwh_ryazan.stg_drivers'
stg_del = 'dwh_ryazan.stg_drivers_del'
connection = connection_dwh

clean_stg(cursor, stg, stg_del, connection)

# ***** Формирование переменной с метаданными:

schema_name = 'dwh_ryazan'
meta_table_name = 'meta_drivers'
max_update_dt = None
# cursor = dwh_cursor
# connection = connection_dwh

max_update_dt = catch_meta(schema_name, meta_table_name, dwh_cursor, connection_dwh)
print(max_update_dt[0])


