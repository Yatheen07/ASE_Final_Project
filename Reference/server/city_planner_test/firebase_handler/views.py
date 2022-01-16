from django.shortcuts import render
from django.http import HttpResponse

#FIREBASE CONFIGURATION: This part of the code should be executed before the server starts
import os
from django.conf import settings
credentialsFilePath = os.path.join(settings.BASE_DIR, 'privateKey.json')
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
cred = credentials.Certificate(credentialsFilePath)
app = firebase_admin.initialize_app(cred)
print(f"Firebase Intialised Successfully...")
db = firestore.client()

# Create your views here.
def writeData(request):
    #Get predictions from ML_Pipeline here - creating a placeholder
    data = {}
    from datetime import datetime
    from random import random
    data['ModeOfTransport'] = 'Luas'
    data['Co2 Emission'] = random()

    #Firebase write data logic
    documentName = str(datetime.now().strftime("%Y/%m/%d %H:%M"))
    doc_ref = db.collection(u'Luas').document(documentName)
    doc_ref.set(data)

    return HttpResponse(f"<b> {documentName} </b>")
