'''
To easily load settings from a file instead of adding them as environment variables, create a file named '.env' at the root of the project with content like this:

EXAMPLE_SETTING='hello'

'''

import os
from dotenv import load_dotenv

load_dotenv()


def get_env_var_yell_if_missing(key: str) -> str:
    if (value := os.getenv(key)) is None:
        raise Exception('Missing environment variable: ' + key)

    return value


LOGS_FOLDER = './logs'
# EXAMPLE_SETTING = get_env_var_yell_if_missing("EXAMPLE_SETTING")
