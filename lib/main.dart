import 'package:flutter/material.dart';
import 'package:flutter_pokedex_sprout_test/home.dart';

void main() {
  runApp(Pokedex());
}

class Pokedex extends StatelessWidget {
  const Pokedex({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}