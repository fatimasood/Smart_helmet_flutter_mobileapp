import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});
  static const routeName = '/result_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result')),
      body: Center(
        child: Text("Result Screen"),
      ),
    );
  }
}
