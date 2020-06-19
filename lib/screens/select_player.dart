import 'package:cards/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectPlayer extends StatefulWidget {
  @override
  _SelectPlayerState createState() => _SelectPlayerState();
}

class _SelectPlayerState extends State<SelectPlayer> {
  @override
  Widget build(BuildContext context) {
    
    final _user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Player"),
        backgroundColor: Colors.grey[800],
      ),
      backgroundColor: Colors.white10,
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: <Widget>[
            
          ],
        ),
      ),
    );
  }
}