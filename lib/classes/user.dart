class User {
  final String uid;
  final String gameID;

  User({this.uid, this.gameID});

  List<String> cards;
  int playerNumber;

  String getUID() {
    return uid;
  }

  String getGameID() {
    return gameID;
  }

}