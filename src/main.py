from dotenv import load_dotenv
import sys
import os
import logging
from connectors.airbyte import AirbyteClient


if __name__ == "__main__":
    load_dotenv()
    from logger import logger
    logger.info("Starting the application") 

    AIRBYTE_USERNAME = os.environ.get("AIRBYTE_USERNAME")
    AIRBYTE_PASSWORD = os.environ.get("AIRBYTE_PASSWORD")
    AIRBYTE_SERVER_NAME = os.environ.get("AIRBYTE_SERVER_NAME")
    AIRBYTE_CONNECTION_ID = os.environ.get("AIRBYTE_CONNECTION_ID")

    # Check if all environment variables are set
    if not all([AIRBYTE_USERNAME, AIRBYTE_PASSWORD, AIRBYTE_SERVER_NAME, AIRBYTE_CONNECTION_ID]):
        raise ValueError("One or more environment variables are missing. Please check your .env file.")

    # Logging setup
    logging.basicConfig(level=logging.INFO)

    try:
        airbyte_client = AirbyteClient(server_name=AIRBYTE_SERVER_NAME, username=AIRBYTE_USERNAME, password=AIRBYTE_PASSWORD)

        if airbyte_client.valid_connection():
            logging.info("Connection is valid")
            airbyte_client.trigger_sync(connection_id=AIRBYTE_CONNECTION_ID)
        else:
            logging.error("Connection is invalid")
    except Exception as e:
        logging.error(f"An error occurred: {str(e)}")
        
    logger.info("Finished populating the Northind data to snowflake")