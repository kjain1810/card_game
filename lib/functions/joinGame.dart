import 'package:cards/classes/database.dart';

Future<bool> joinGame(String name) async {

  DataBaseServices db = new DataBaseServices(name: name);

  bool alreadyExist = await db.checkGameExistence();
	if(alreadyExist == false) {
		return false;
	}

  bool spotAvailable = await db.checkAvailability();
  if(spotAvailable == false) {
    return false;
  }

  String gameID = await db.getGameID();

  // TODO: anon login and set up stream of uid

  db.updatePlayers();

  // TODO: set up stream of gameID

  return true; // TODO: REMOVE

}