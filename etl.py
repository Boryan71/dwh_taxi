#!/usr/bin/python3
import psycopg2
import pandas as pd
import taxi_config as conf

# ************************************** Подключение к хранилищу

try:
    connection_dwh = psycopg2.connect(
        database=conf.dwh_database,
        host=conf.dwh_host,
        user=conf.dwh_user,
        password=conf.dwh_password,
        port=conf.dwh_port)
except Exception as ex:
    print('...Ошибка подключения...')
    print(ex)
finally: print('Подключение к хранилищу установлено.')

# ************************************** Подключение к банку

try:
    connection_bank = psycopg2.connect(
        database=conf.bank_database,
        host=conf.bank_host,
        user=conf.bank_user,
        password=conf.bank_password,
        port=conf.bank_port)
except Exception as ex:
    print('...Ошибка подключения...')
    print(ex)
finally: print('Подключение к банку установлено.')

# ************************************** Подключение к такси

try:
    connection_taxi = psycopg2.connect(
        database=conf.taxi_database,
        host=conf.taxi_host,
        user=conf.taxi_user,
        password=conf.taxi_password,
        port=conf.taxi_port)
except Exception as ex:
    print('...Ошибка подключения...')
    print(ex)
finally: print('Подключение к такси установлено.')

# ************************************** Отключение автокоммита

connection_dwh.autocommit = False

# ************************************** Создание курсоров

dwh_cursor = connection_dwh.cursor()
bank_cursor = connection_bank.cursor()
taxi_cursor = connection_taxi.cursor()


# **************************************
# ************************************** Работа с измерением Drivers
# **************************************

# ************************************** Очистка стейджингов Drivers

try:
  with dwh_cursor as cursor:
      query = ("""delete from dwh_ryazan.stg_drivers;""")
      cursor.execute(query)
except Exception as ex:
    print('...Стейджинг Drivers не очищен...')
    print(ex)
finally:
    connection_dwh.commit()
    print('Стейджинг Drivers очищен.')