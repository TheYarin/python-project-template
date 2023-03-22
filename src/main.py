import logging
import os
from logging.handlers import RotatingFileHandler

# from settings import EXAMPLE_SETTING, LOGS_FOLDER
from settings import LOGS_FOLDER

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        RotatingFileHandler(os.path.join(LOGS_FOLDER, "log.txt"), maxBytes=100 * 1024**2, backupCount=2),  # 200MB
        logging.StreamHandler()
    ]
)

logger = logging.getLogger(__name__)


def main():
    print('Hello, world!')


if __name__ == '__main__':
    main()
