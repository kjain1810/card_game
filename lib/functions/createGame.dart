import 'package:cards/classes/authentication.dart';
import 'package:cards/classes/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("gameID", gameID);
  prefs.setString("uid", res.uid);

  return "No errors";

}