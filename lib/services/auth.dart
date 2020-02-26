import 'package:firebase_auth/firebase_auth.dart';
import 'package:pushapp/models/user.dart';
import 'package:pushapp/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // sign in with email
  Future signInWithEmailAndPassword(email, password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
  }
  }
  // register with email
  Future registerWithEmailAndPassword(email, password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid)
            .updateUserData(sugar: '0', name: 'new user', strength: 100, token: ' ');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
  }
  }

  // authentication change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        // .map((FirebaseUser user) => _userFromFirebaseUser(user)); sugared to below
        .map(_userFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future singOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
