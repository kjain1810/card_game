import 'package:cards/classes/gameControl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectPlayer extends StatefulWidget {
  @override
  _SelectPlayerState createState() => _SelectPlayerState();
}

class _SelectPlayerState extends State<SelectPlayer> {
  @override
  Widget build(BuildContext context) {
    
    final List<int> playerList = <int>[1, 2, 3, 4];

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Player"),
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.white10,
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: playerList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("Player ${playerList[index]}"),
              onTap: () async { 
                final prefs = await SharedPreferences.getInstance();
                String _uid = prefs.getString("uid");
                String _gameID = prefs.getString("gameID");
                GameControl _gc = new GameControl(gameID: _gameID, uid: _uid);
                String res = await _gc.checkPlayerAvailability(playerList[index]);
                if(res != "Available") {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: new Text("Sorry! Try again"),
                        content: new Text(res),
                        actions: <Widget>[
                          new FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                else {
                  bool isSet = await _gc.setPlayer(playerList[index]);
                  if(isSet) {
                    Navigator.popAndPushNamed(context, "/game");
                  }
                  else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: new Text("Sorry! Try again"),
                          content: new Text("Oops, something went wrong"),
                          actions: <Widget>[
                            new FlatButton(
                              child: new Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }
              },
            );
          },
        ),
      ),
    );
  }
}