import 'package:cards/classes/database.dart';

Future<bool> createGame(String name) async {
	// TODO: check if game with name = name exists

  DataBaseServices db = new DataBaseServices(name: name);

	bool alreadyExist = await db.checkGameExistence();
	if(alreadyExist == true) {
		return false;
	}

	String gameID = await db.insertGame();
  db.updatePlayers();

  // TODO: anon login and set up stream of uid

	// TODO: set up stream of gameID

  return true;

}