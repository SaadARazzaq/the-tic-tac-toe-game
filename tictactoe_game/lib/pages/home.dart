import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const Duration fadeInDuration = Duration(seconds: 2);
  static const Duration fadeOutDuration = Duration(seconds: 4);
  static const Duration delayDuration = Duration(seconds: 6);

  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        _isVisible = true;
      });
    });
    Future.delayed(delayDuration, () {
      setState(() {
        _isVisible = false;
        Navigator.pushNamed(context, '/game');
      });
    });
  }

  static var customFontWhite = GoogleFonts.bangers(
    textStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 5,
      fontSize: 36,
    ),
  );
  static var customFontPurple = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      letterSpacing: 3,
      fontSize: 18,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1BE6AF),
      body: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: _isVisible ? fadeInDuration : fadeOutDuration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "TIC-TAC-TOE",
                    style: customFontWhite,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 100),
              alignment: Alignment.bottomCenter,
              child: Text(
                "By FastDev",
                style: customFontPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
