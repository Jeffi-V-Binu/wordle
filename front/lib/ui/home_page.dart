import 'package:flutter/material.dart';
import 'package:front/logic/game.dart';
import 'package:front/ui/entry.dart';
import 'package:front/data/all_words.dart';
import 'package:provider/provider.dart';

import 'Tile.dart';

final myGameController = GameController();

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<GameController>().startGame();
  }

  @override
  void dispose() {
    _textController.dispose(); // Clean up memory when page closes
    super.dispose();
  }

  void _submitWord(BuildContext context) {
    String currentInput = _textController.text.toLowerCase().trim();
    GameController myGameController = context.read<GameController>();
    // Wordle validation constraints
    if (currentInput.length <= 5 && myGameController.getNumberOfGuesses < 5 && myGameController.gameEnd == false) {
      myGameController.userInput(currentInput); // Add the word to our history
      _textController.clear(); // Clear text field reader for next row
    }
  }

  @override
  Widget build(BuildContext context) {
    GameController myGameController = context.watch<GameController>();
    List<Widget> resultWordTiles = [];
    for (int i = 0; i < 5; ++i) {
      resultWordTiles.add(Tile(letter: myGameController.resultWord[i], hitType: HitType.correct));
    }
    debugPrint('${myGameController.gameEnd}');
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      title: 'Wordle',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Wordle'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.restart_alt_rounded),
              tooltip: 'restarts the game with a new word',
              onPressed: () {
                setState(() {
                  myGameController.startGame();
                  _textController.clear();
                });
              },
            ),
          ],
        ),

        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: 400,
            height: 450,
            child: Column(
              spacing: 10.0,
              children: [
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Center(child: Entry(myGameController: myGameController)),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: Row(
                      spacing: 10.0,
                      children: [
                        if (myGameController.gameEnd)
                          for (var eachTile in resultWordTiles) eachTile,
                        if (myGameController.gameEnd == false)
                          for (int i = 0; i < 5; ++i) Tile(letter: ' ', hitType: HitType.miss),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: _textController,
                    onSubmitted: (value) {
                      _submitWord(context);
                    },

                    decoration: const InputDecoration(hintText: 'Enter a 5-letter word', border: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
