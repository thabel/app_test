import 'dart:math';
import 'package:flutter/material.dart';

class RandomPage extends StatelessWidget {
  const RandomPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text("Random Page"),
      ),
      body: Center(child: Text("${Random().nextInt(20)}")));
  }
}
