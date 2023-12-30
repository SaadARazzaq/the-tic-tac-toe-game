import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

class Game extends StatefulWidget {
  const Game({Key? key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {

  bool _isVisible = false;

  late BannerAd _bannerAd;
  bool _isAdLoaded = false;  

  static const Duration fadeInDuration = Duration(milliseconds: 700);
  @override
  void initState() {
    super.initState();
    _initBannerAd();

    Timer(Duration.zero, () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner, 
      adUnitId: "ca-app-pub-3940256099942544/6300978111", 
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {},
      ), 
      request: AdRequest(),
    );

    _bannerAd.load();
  }

  List<String> display_token = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];
  List<int> MatchedIndexes = [];
  List<int> UnMatchedIndexes = [];
  bool turn = true, winnerFound = false;
  String result = '';
  int oScore = 0, xScore = 0, filledBoxes = 0;

  static var customFontWhite = GoogleFonts.bangers(
    textStyle: TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xFF1BE6AF),
        body: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: fadeInDuration,
          child: Padding(
            padding: const EdgeInsets.all(19),
            child: Column(
            children: [
              
              // Expanded(
              //   flex: 4,
              //   child: Container(
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           children: [
              //             Text('Player O', style: customFontWhite),
              //             Text(oScore.toString(), style: customFontWhite),
              //           ],
              //         ),
              //         SizedBox(width: 40),
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           children: [
              //             Text('Player X', style: customFontWhite),
              //             Text(xScore.toString(), style: customFontWhite),
              //           ],
              //         ),
              //       ],
              //     ),
              //     padding: EdgeInsets.only(bottom: 60),
              //   ),
              // ),
            Expanded(
  flex: 4,
  child: Padding(
    padding: EdgeInsets.only(top: 70),
  child: Column(
    children: [
      Container(
        color: Colors.red, // Red line color
        height: 3, // Red line height
        width: double.infinity,
      ),
      Container(
        color: Color(0xFFFFD700), // Yellow background color
        padding: EdgeInsets.symmetric(vertical: 6), // Adjust padding as needed
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Player O', style: customFontWhite),
                Text(oScore.toString(), style: customFontWhite),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Player X', style: customFontWhite),
                Text(xScore.toString(), style: customFontWhite),
              ],
            ),
          ],
        ),
      ),
      Container(
        color: Colors.red, // Red line color
        height: 3, // Red line height
        width: double.infinity,
      ),
    ],
  ),
  ),
),
    
                Expanded(
                flex: 8,
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 5,
                            color: Colors.red,
                          ),
                          color: MatchedIndexes.contains(index)
                              ? Color(0xFFE3E0F3) // Lavender color
                              : (UnMatchedIndexes.contains(index)
                              ? Colors.white
                              : Colors.yellow),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Center(
                            child: Text(
                              display_token[index],
                              style: GoogleFonts.coiny(
                                fontSize: 64,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
  padding: const EdgeInsets.only(bottom: 100),
  child: Container(
    width: double.infinity,
    height: 60,
    decoration: BoxDecoration(
      color: MatchedIndexes.isNotEmpty
          ? Color(0xFFE3E0F3) // Lavender color
          : (UnMatchedIndexes.isNotEmpty ? Colors.white : Colors.yellow),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        width: 5,
        color: Colors.red, // Red border color
      ),
    ),
    child: TextButton(
      onPressed: () {
        _clearBoard();
      },
      child: Text(
        "Start Over",
        style: TextStyle(
          color: Colors.red,
          fontFamily: GoogleFonts.bangers().fontFamily,
          fontSize: 26,
        ),
      ),
    ),
  ),
),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _isAdLoaded ? Container(
        height: _bannerAd.size.height.toDouble(),
        width: _bannerAd.size.width.toDouble(),
        child: AdWidget(ad: _bannerAd),
      )
      : SizedBox(),
    );
  }
  void _tapped(int index){
    if (winnerFound || display_token[index] != '') {
      return; // Ignore further tapping
    }
    setState(() {
      if(turn && display_token[index]==''){
        display_token[index] = 'O';
        filledBoxes++;
      }
      else if(!turn && display_token[index]==''){
        display_token[index] = 'X';
        filledBoxes++;
      }
      if(display_token[index]=='X'){
        turn = false;
        filledBoxes = filledBoxes + 0;
      }
      else if(display_token[index]=='O'){
        turn = true;
        filledBoxes = filledBoxes + 0;
      }
      turn = !turn;
      _checkWinner();
    });
  }

  void _checkWinner(){
    // For the 1st Row
    if(display_token[0] == display_token[1] && display_token[0] == display_token[2] && display_token[0] != ''){
      setState((){
        result = 'Player ' + display_token[0] + ' Wins!';
        MatchedIndexes.addAll([0, 1, 2]);
        winnerFound = true;
        _updateScore(display_token[0]);
      });
    }
    // For the 2nd Row
    if(display_token[3] == display_token[4] && display_token[3] == display_token[5] && display_token[3] != ''){
      setState((){
        result = 'Player ' + display_token[3] + ' Wins!';
        MatchedIndexes.addAll([3, 4, 5]);
        winnerFound = true;
        _updateScore(display_token[3]);
      });
    }
    // For the 3rd Row
    if(display_token[6] == display_token[7] && display_token[6] == display_token[8] && display_token[6] != ''){
      setState((){
        result = 'Player ' + display_token[6] + ' Wins!';
        MatchedIndexes.addAll([6, 7, 8]);
        winnerFound = true;
        _updateScore(display_token[6]);
      });
    }
    // For the 1st Column
    if(display_token[0] == display_token[3] && display_token[0] == display_token[6] && display_token[0] != ''){
      setState((){
        result = 'Player ' + display_token[0] + ' Wins!';
        MatchedIndexes.addAll([0, 3, 6]);
        winnerFound = true;
        _updateScore(display_token[0]);
      });
    }
    // For the 2nd Column
    if(display_token[1] == display_token[4] && display_token[1] == display_token[7] && display_token[1] != ''){
      setState((){
        result = 'Player ' + display_token[1] + ' Wins!';
        MatchedIndexes.addAll([1, 4, 7]);
        winnerFound = true;
        _updateScore(display_token[1]);
      });
    }
    // For the 3rd Column
    if(display_token[2] == display_token[5] && display_token[2] == display_token[8] && display_token[2] != ''){
      setState((){
        result = 'Player ' + display_token[2] + ' Wins!';
        MatchedIndexes.addAll([2, 5, 8]);
        winnerFound = true;
        _updateScore(display_token[2]);
      });
    }
    // For the 1st Diagonal
    if(display_token[0] == display_token[4] && display_token[0] == display_token[8] && display_token[0] != ''){
      setState((){
        result = 'Player ' + display_token[0] + ' Wins!';
        MatchedIndexes.addAll([0, 4, 8]);
        winnerFound = true;
        _updateScore(display_token[0]);
      });
    }
    // For the 2nd Diagonal
    if(display_token[2] == display_token[4] && display_token[2] == display_token[6] && display_token[2] != ''){
      setState((){
        result = 'Player ' + display_token[2] + ' Wins!';
        MatchedIndexes.addAll([2, 4, 6]);
        winnerFound = true;
        _updateScore(display_token[2]);
      });
    }
    else if(winnerFound == false && filledBoxes == 9){
      result = 'It\'s a Draw';
      UnMatchedIndexes.addAll([0, 1, 2, 3, 4, 5, 6, 7, 8]);
    }

    if (winnerFound) {
      // Show an AwesomeDialog when a winner is found
      Future.delayed(Duration(milliseconds: 200), () {
        String title;
        if (result.contains('Wins')) {
          title = "Congratulations!";
          AwesomeDialog(
            context: context,
            dialogType: result.contains('O')
                ? DialogType.SUCCES
                : DialogType.ERROR,
            animType: AnimType.SCALE,
            title: title,
            desc: result,
            btnOkOnPress: () {
              _clearBoard();
            },
            btnOkText: "Play Again",
          )..show();
        } else {
          title = "It's a Draw";
          AwesomeDialog(
            context: context,
            dialogType: DialogType.INFO,
            animType: AnimType.SCALE,
            title: title,
            desc: result,
            btnOkOnPress: () {
              _clearBoard();
            },
            btnOkText: "Play Again",
          )..show();
        }
      });
    } else if (filledBoxes == 9) {
      // Show an AwesomeDialog when it's a draw
      Future.delayed(Duration(milliseconds: 500), () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.SCALE,
          title: "It's a Draw",
          desc: result,
          btnOkOnPress: () {
            _clearBoard();
          },
          btnOkText: "Play Again",
        )..show();
      });
    }
  }

  void _updateScore(String winner){
    if(winner == 'O'){
      oScore = oScore + 1;
    }
    else if(winner == 'X'){
      xScore = xScore + 1;
    }
  }

  void _clearBoard(){
    setState(() {
      for(int i = 0; i < 9; i++){
        display_token[i] = '';
      }
      result = '';
      winnerFound = false;
      filledBoxes = 0;
      MatchedIndexes.clear();
      UnMatchedIndexes.clear();
    });
  }
}