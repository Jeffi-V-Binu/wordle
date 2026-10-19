import 'package:flutter/material.dart';
import 'package:front/data/all_words.dart';

class Tile extends StatefulWidget {
  const Tile({super.key, required this.letter, required this.hitType});
  final String letter;
  final HitType hitType;
  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  Color getColor() {
    switch (widget.hitType) {
      case HitType.correct:
        return Colors.green;
      case HitType.wrongSpot:
        return Colors.yellow;
      case HitType.miss:
        return Colors.grey;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Center(
        child: Text(
          widget.letter.toUpperCase(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
