import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pushapp/models/brew.dart';
import 'package:pushapp/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserData({String sugar, String name, int strength, String token}) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugar,
      'name': name,
      'strength': strength,
      'token': token,
    });
  }

  Future updateUserToken({String token}) async {
    return await brewCollection.document(uid).updateData({
      'token': token
    });
  }

  Future updateUserName({String name}) async {
    return await brewCollection.document(uid).updateData({
      'name': name
    });
  }

// make brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugars: doc.data['sugars'] ?? '0',
        token: doc.data['token'] ?? '0',
      );
    }).toList();
  }

  // UserData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      sugars: snapshot.data['sugars'],
      name: snapshot.data['name'],
      strength: snapshot.data['strength'],
      token: snapshot.data['token'],
    ); 
  }

  // get brew doc stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }
}
