import csv
import json
 
 
# Function to convert a CSV to JSON
# Takes the file paths as arguments
def writeDataToFirebase(csvFilePath,db):
     
    # create a dictionary
    data = {}
     
    # Open a csv reader called DictReader
    with open(csvFilePath, encoding='utf-8') as csvf:
        csvReader = csv.DictReader(csvf)
         
        # Convert each row into a dictionary
        # and add it to data
        for rows in csvReader:
            currentStation = {}
            # Assuming a column named 'No' to
            # be the primary key
            stationNumber = rows['Number']
            currentStation['Latitude'] = rows['Latitude']
            currentStation['Longitude'] = rows['Longitude']
            currentStation['Name'] = rows['Name']
            data[stationNumber] = currentStation
            doc_ref = db.collection(u'DublinBikesStationMarkers').document(stationNumber)
            doc_ref.set(currentStation);
    return data
    
         
# Driver Code
 
# Decide the two file paths according to your
# computer system
csvFilePath = r'bikeStationData.csv'
 
# Call the make_json function


import firebase_admin
from firebase_admin import credentials

from firebase_admin import firestore

cred = credentials.Certificate("privateKey.json")
app = firebase_admin.initialize_app(cred)

print(f"auth successful for {app.name}")

db = firestore.client()

writeDataToFirebase(csvFilePath,db)