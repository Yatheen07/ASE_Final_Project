from django.shortcuts import render
from django.http import HttpResponse
import requests, json
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import numpy as np
from static import Endpoints as apiSource
import json
from DataTransformer.views import transformData
from static.firebaseInitialization import db

def bikeAvailability():
    start = time.time()
    print("*************** Fetching Dublin Bike's API ****************")
    response = requests.get(apiSource.DUBLIN_BIKES_API['source'])

    if response.status_code == 200 or response.status_code == 201:
        # prediction engine call and transforming data
        bikeStationData = transformData(apiResponse=json.loads(response.text))
        bikesCollectionRef = db.collection(u'DublinBikes')
        batch = db.batch()
        for stationData in bikeStationData:
            currentDocRef = bikesCollectionRef.document(stationData.station_id)
            batch.update(currentDocRef, stationData.to_dict())
        batch.commit()
        print("Bikes Batch Transaction Complete..")
    else:
        print("Response code:-", response.status_code)
    end = time.time()
    print(end - start)

