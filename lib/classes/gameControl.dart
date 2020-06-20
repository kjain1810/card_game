import 'package:cards/classes/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameControl {
  final String gameID;
  final String uid;

  GameControl({this.gameID, this.uid});

  final CollectionReference games = Firestore.instance.collection("games");
  
  Future<String> checkPlayerAvailability(int i) async {
    dynamic ref;
    try {
      games.document(gameID).get().then((value) {
        ref = value;
      });
    } catch(e) {
      print(e);
      return "Try again!";
    }
    if(ref == null) {
      return "Try again!";
    }
    if(ref.data["player" + i.toString()] != null) {
      return "Player taken";
    }
    return "Available";
  }

  Future<bool> setPlayer(int i) async {
    try{
      await games.document(gameID).setData({
        "player" + i.toString(): uid,
      });
      return true;
    } catch(e) {
      print(e);
      return false;
    }
  }

}