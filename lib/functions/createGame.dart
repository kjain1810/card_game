import 'package:cards/classes/authentication.dart';
import 'package:cards/classes/database.dart';

Future<String> createGame(String name) async {

  DataBaseServices db = new DataBaseServices(name: name);

	bool alreadyExist = await db.checkGameExistence();
	if(alreadyExist == true) {
		return "Game already exists";
	}

	String gameID = await db.insertGame();
  db.updatePlayers();

  final Authentication _auth = Authentication(gameID: gameID);
  dynamic res = await _auth.signIn();
  if(res == null) {
    return "Sign-in failed, create with new game name";
  }

  return "No errors";

}