import 'package:flutter/material.dart';
import 'package:front/logic/game.dart';
import 'package:front/ui/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => GameController(), child: const HomePage()));
}
