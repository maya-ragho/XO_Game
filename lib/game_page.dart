import 'dart:core';
import 'package:flutter/material.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  static const String PLAYER_X = "X";
  static const String PLAYER_Y = "O";
   bool isplaying = false;

  late String currentplayer;
  late bool gameEnd;
  late List<String> occupied;

  @override
  void initState() {
    initializeGameApp();
    super.initState();
  }

  void initializeGameApp() {
    currentplayer = PLAYER_X;
    gameEnd = false;
    occupied = ["", "", "", "", "", "", "", "", ""]; //9 empty places
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('XO Game',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
       centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _headerText(),
            _gameContainer(),
            _restartButton(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return Column(
      children: [
        Text(
          "Tic Tac Toe",
          style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "$currentplayer turn",
          style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _gameContainer() {
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      width: MediaQuery.of(context).size.width / 1.4,
      margin: const EdgeInsets.all(8),
      child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: 9,
          itemBuilder: (context, int index) {
            return _box(index);
          }),
    );
  }

  Widget _box(int index) {
    return InkWell(
      onTap: () {
        if (gameEnd || occupied[index].isNotEmpty) {
          //return if game already ended or box already clicked
          return;
        }
        setState(() {
          occupied[index] = currentplayer;
          changeTurn();
          checkForWinner();
          checkForDraw();
        });
      },
      child: Container(
        color: occupied[index].isEmpty
            ? Colors.black26
            : occupied[index] == PLAYER_X
                ? Colors.blue
                : Colors.orange,
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Text(
            occupied[index],
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }

  _restartButton(){
    return ElevatedButton(onPressed: (){
     setState(() {
       initializeGameApp();

     });
    }, child: const Text('Restart Game'),
    );
  }

  changeTurn() {
    if (currentplayer == PLAYER_X) {
      currentplayer = PLAYER_Y;
    } else {currentplayer = PLAYER_X;
    }
  }

  checkForWinner() {
    //Define winning positions
    List<List<int>> winningList = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var winningPos in winningList) {
      String playerPosition0 = occupied[winningPos[0]];
      String playerPosition1 = occupied[winningPos[1]];
      String playerPosition2 = occupied[winningPos[2]];


      if (playerPosition0.isNotEmpty) {
        if (playerPosition0 == playerPosition1 &&
            playerPosition0 == playerPosition2) {
          //all equal means player won
          showGameOverMessager("Player $playerPosition0 Won");
          gameEnd = true;
          return;
        }
      }
    }
  }

   checkForDraw(){
     if(gameEnd){
       return;
     }
     bool draw = true;
     for(var occupiedPlayer in occupied){
       if(occupiedPlayer.isEmpty){
         // at least one is empty not all are filled
         draw = false;
       }
     }

     if(draw){
       showGameOverMessager("Draw");
       gameEnd = true;
     }


  }
  showGameOverMessager(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Game Over \n $message", textAlign:  TextAlign.center,style: const TextStyle(
        fontSize: 20,
      ),)),
    );
  }

}
