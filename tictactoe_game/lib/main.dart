import 'package:flutter/material.dart';
import 'package:tictactoe_game/pages/game.dart';
import 'package:tictactoe_game/pages/home.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/game': (context) => Game(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

