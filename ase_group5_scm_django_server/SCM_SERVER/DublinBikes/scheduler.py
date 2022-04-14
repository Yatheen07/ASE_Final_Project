from datetime import datetime
from apscheduler.schedulers.background import BackgroundScheduler
from .views import bikeAvailability


def start_schedulers():
    schedulers = BackgroundScheduler()
    schedulers.add_job(bikeAvailability, 'interval', minutes=5)
    schedulers.start()
