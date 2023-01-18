def clean_stg(cursor, stg, stg_del, connection):

    fall_stg = None
    fall_stg_del = None

    try:
        query = (f"""delete from {stg};""")
        cursor.execute(query)
    except Exception as ex:
        print(f'...Стейджинг {stg} не очищен...')
        print(ex)
        fall_stg = ex

    try:
        query = (f"""delete from {stg_del};""")
        cursor.execute(query)
    except Exception as ex:
        print(f'...Стейджинг {stg_del} не очищен...')
        print(ex)
        fall_stg_del = ex

    if fall_stg is None and fall_stg_del is None:
        connection.commit()
        print(f'Стейджинг {stg} очищен.')
        print(f'Стейджинг {stg_del} очищен.')
    else: print('...gg...')


def catch_meta(schema_name, meta_table_name, cursor, connection):

    fall_meta = None
    max_update_dt = None

    try:
        query = f"""select max_update_dt
                    from {schema_name}.{meta_table_name}"""
        cursor.execute(query)
        max_update_dt = cursor.fetchone()
    except Exception as ex:
        print(f'...Метаданные из таблицы {schema_name}.{meta_table_name} не захвачены...')
        print(ex)
        fall_meta = ex

    if fall_meta is None:
        connection.commit()
        print(f'Метаданные из таблицы {schema_name}.{meta_table_name} захвачены.')
        return max_update_dt
    else: print('...gg...')

