import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});
  static const routeName = '/quiz_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')),
      body: Center(
        child: Text("Quiz Screen"),
      ),
    );
  }
}
