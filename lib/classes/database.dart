import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseServices {
	final String name;

	DataBaseServices({this.name});

	final CollectionReference games = Firestore.instance.collection("games");

	String gameID;

	Future<bool> checkGameExistence() async {
		bool exist;
		QuerySnapshot qs;
		try {
			qs = await games.where("name", isEqualTo: name).getDocuments();
 		} catch(e) {
			print(e);
		}
		if(qs.documents.length >= 1) {
			exist = true;
		} else {
			exist = false;
		}
		return exist;
	}

	Future<String> insertGame() async {
		final ref = await games.add({
			"name": name,
			"current_move": null,
			"last_move": null,
			"player1": null,
			"player2": null,
			"player3": null,
			"player4": null,
			"round_number": 0,
			"score1": 0,
			"score2": 0,
			"cnt_players": 0,
		});
		print(ref.documentID);
		return gameID = ref.documentID;
	}

	Future<bool> checkAvailability() async {
		QuerySnapshot qs;
		try {
			qs = await games.where("name", isEqualTo: name).getDocuments();
 		} catch(e) {
			print(e);
		}
		if(qs.documents.length == 0) {
			return false;
		}
		return (qs.documents[0].data["cnt_players"] < 4);
	}

	Future<String> getGameID() async {
		QuerySnapshot qs;
		try {
			qs = await games.where("name", isEqualTo: name).getDocuments();
 		} catch(e) {
			print(e);
		}
		gameID = qs.documents[0].documentID;
		return gameID;
	}

	Future updatePlayers() async {
		QuerySnapshot qs;
		try {
			qs = await games.where("name", isEqualTo: name).getDocuments();
 		} catch(e) {
			print(e);
		}
		int currentCount = qs.documents[0].data["cnt_players"];
		int newCount = currentCount + 1;
		await games.document(qs.documents[0].documentID).updateData({
			"cnt_players": newCount,
		});
	}


  // TODO: TEST ALL FUNCTIONS FROM HERE
  Future updateRoundNumber() async {
    QuerySnapshot qs;
		try {
			qs = await games.where("name", isEqualTo: name).getDocuments();
 		} catch(e) {
			print(e);
		}
		int currentRound = qs.documents[0].data["round_number"];
		int newRound = currentRound + 1;
		await games.document(qs.documents[0].documentID).updateData({
			"round_number": newRound,
		});
  }

  Future updateScore(int winner) async {
    QuerySnapshot qs;
		try {
			qs = await games.where("name", isEqualTo: name).getDocuments();
 		} catch(e) {
			print(e);
		}
		String nameWinner = "score1";
    if(winner == 2) {
      nameWinner = "score2";
    }
    int currentScore = qs.documents[0].data[nameWinner];
		int newScore = currentScore + 1;
		await games.document(qs.documents[0].documentID).updateData({
			nameWinner: newScore,
		});
  }

  Future updateCurrentPlayer() async {
    QuerySnapshot qs;
		try {
			qs = await games.where("name", isEqualTo: name).getDocuments();
 		} catch(e) {
			print(e);
		}
		String prevPlayer = qs.documents[0].data["current_move"];
    String newPlayer;
    List<String> players = [qs.documents[0].data["player1"].toString(), qs.documents[0].data["player2"].toString(),
      qs.documents[0].data["player3"].toString(), qs.documents[0].data["player4"].toString()];
    for(int i = 0; i < 4; i++) {
      if(prevPlayer == players[i]) {
        newPlayer = players[(i + 1) % 4];
        break;
      }
    }
    await games.document(qs.documents[0].documentID).updateData({
			"current_move": newPlayer,
		});
  }

}