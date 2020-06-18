import 'package:cards/screens/create_game.dart';
import 'package:cards/screens/game.dart';
import 'package:cards/screens/select_player.dart';
import 'package:flutter/material.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat'
      ),
      routes: {
        '/': (context) => CreateGame(),
        '/select': (context) => SelectPlayer(),
        '/game': (context) => Game(),
      },
    )
  );
}
