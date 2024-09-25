import logging

# Log the entire JSON configuration
def log_config(config, logger):

    logger.info("Configuration Setup:")
    for key, value in config.items():
        logger.info(f"{key}: {value}")

    return

def setup_logger(log_file):
    
    logging.basicConfig(filename=log_file, level=logging.INFO, format='%(asctime)s - %(message)s')
    logger = logging.getLogger()

    return logger
