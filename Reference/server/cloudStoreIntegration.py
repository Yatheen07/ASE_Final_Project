import firebase_admin
from firebase_admin import credentials

from firebase_admin import firestore

cred = credentials.Certificate("privateKey.json")
app = firebase_admin.initialize_app(cred)

print(f"auth successful for {app.name}")

db = firestore.client()

# users_ref = db.collection(u'Sample')
# docs = users_ref.stream()

# for doc in docs:
#     print(f'{doc.id} => {doc.to_dict()}')

doc_ref = db.collection(u'Sample2').document("newDocument")
doc_ref.set({
    u'first': u'Shubham',
    u'middle': u'middler',
    u'last': u'maurya',
    u'born': 1812
})