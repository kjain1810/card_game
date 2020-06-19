import 'package:cards/classes/authentication.dart';
import 'package:cards/classes/user.dart';
import 'package:cards/screens/select_game.dart';
import 'package:cards/screens/game.dart';
import 'package:cards/screens/select_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(StreamProvider<User>.value(
    value: Authentication().user,
    child: MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat'
      ),
      routes: {
        '/': (context) => SelectGame(),
        '/select': (context) => SelectPlayer(),
        '/game': (context) => Game(),
      },
    ),
  )
  );
}
