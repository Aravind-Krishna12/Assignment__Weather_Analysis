from sqlalchemy import create_engine
import yaml

def load_config(config_file):
    """Loads database configuration from a YAML file."""
    try:
        with open(config_file, 'r') as file:
            config = yaml.safe_load(file)
        return config['database'] #access the database section
    except FileNotFoundError:
        print(f"Error: Configuration file '{config_file}' not found.")
        return None
    except yaml.YAMLError as e:
        print(f"Error parsing YAML file: {e}")
        return None
    except KeyError as e:
        print(f"Error: {e} section not found in configuration file.")
        return None

def insert_data_to_postgres(df, table_name, config_file="config.yaml"):
    """Inserts a Pandas DataFrame into a PostgreSQL table using SQLAlchemy."""

    config = load_config(config_file)

    if config is None:
        return #stop the function if the config is not properly loaded.

    db_name = config.get("dbname")
    db_host = config.get("host")
    db_username = config.get("username")
    db_password = config.get("password")
    db_port = config.get("port")

    try:
        engine = create_engine(f'postgresql+psycopg2://{db_username}:{db_password}@{db_host}:{db_port}/{db_name}')
        df.to_sql(table_name, con=engine, if_exists="append", index=False)
        print("Data inserted successfully!")
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        if 'engine' in locals():
            engine.dispose()

# Example usage (assuming 'df' is your Pandas DataFrame)
# insert_data_to_postgres(df, "weather_data1")

# create a config.yaml file if it does not exist.
# import os

# if not os.path.exists("config.yaml"):
#     config = {
#         "database": {
#             "dbname": "postgres",
#             "host": "localhost",
#             "username": "db_user",
#             "password": "db_password",
#             "port": "5432"
#         }
#     }
#     with open("config.yaml", "w") as f:
#         yaml.dump(config, f)