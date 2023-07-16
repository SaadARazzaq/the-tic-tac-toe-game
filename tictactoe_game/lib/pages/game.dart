import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<String> display_token = ['','','','','','','','',''];
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
      backgroundColor: Color(0xFFBEE5D3), // Mint Lavender color
      body: Padding(
        padding: const EdgeInsets.all(19),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Player O', style: customFontWhite),
                        Text(oScore.toString(), style: customFontWhite)
                      ],
                    ),
                    SizedBox(width: 50),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Player X', style: customFontWhite),
                        Text(xScore.toString(), style: customFontWhite)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
                itemBuilder: (BuildContext context, int index){
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
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$result',
                      style: customFontWhite,
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                      onPressed: () {
                        _clearBoard();
                      },
                      child: Text(
                        'Play Again',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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
