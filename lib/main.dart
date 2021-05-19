import 'package:flutter/material.dart';
import 'package:webapp/pages/questionAnswer.dart';

void main() {
  runApp(IKnowEverythingApp());
}

class IKnowEverythingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.deepOrange, backgroundColor: Colors.black38),
      title: 'I Know Everything',
      home: QuestionAnswerPage(),
    );
  }
}
