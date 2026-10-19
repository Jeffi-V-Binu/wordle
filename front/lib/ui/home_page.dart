import 'package:flutter/material.dart';
import 'package:front/logic/game.dart';
import 'package:front/ui/entry.dart';

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
    myGameController.startGame();
  }

  @override
  void dispose() {
    _textController.dispose(); // Clean up memory when page closes
    super.dispose();
  }

  void _submitWord() {
    String currentInput = _textController.text.toLowerCase().trim();

    // Wordle validation constraints
    if (currentInput.length <= 5 && myGameController.getNumberOfGuesses < 5) {
      setState(() {
        myGameController.userInput(currentInput); // Add the word to our history
        _textController.clear(); // Clear text field reader for next row
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                });
              },
            ),
          ],
        ),

        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            width: 400,
            height: 400,
            child: Column(
              spacing: 10.0,
              children: [
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    child: Center(child: Entry(myGameController: myGameController)),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onSubmitted: (value) {
                      _submitWord();
                      setState(() {});
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
