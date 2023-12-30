import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tictactoe_game/pages/game.dart';
import 'package:tictactoe_game/pages/home.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/game': (context) => Game(),
    },
    debugShowCheckedModeBanner: false,
  ));
}

