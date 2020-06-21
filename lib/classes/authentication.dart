import 'package:cards/classes/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {

  final String gameID;

  Authentication({this.gameID});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    return user == null ? null : User(uid: user.uid, gameID: gameID);
  }

  Future signIn() async {
    try {
      AuthResult res = await _auth.signInAnonymously();
      FirebaseUser user = res.user;
      return _userFromFirebase(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}