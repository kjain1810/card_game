import 'package:cards/classes/authentication.dart';
import 'package:cards/classes/database.dart';

Future<String> joinGame(String name) async {

  DataBaseServices db = new DataBaseServices(name: name);

  bool alreadyExist = await db.checkGameExistence();
	if(alreadyExist == false) {
		return "Game does not exist";
	}

  bool spotAvailable = await db.checkAvailability();
  if(spotAvailable == false) {
    return "Game full";
  }

  String gameID = await db.getGameID();

  db.updatePlayers();

  final Authentication _auth = Authentication(gameID: gameID);
  dynamic res = await _auth.signIn();
  if(res == null) {
    return "Sign-in failed, create with new game name";
  }

  return "No errors";

}