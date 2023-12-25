import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});
  static const routeName = '/quiz_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color(0xffd7c3ff),
        title: Text(
          'Quiz',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
            color: Color(0xffffffff),
          ),
        ),
        backgroundColor: Color(0xff8048ec),
      ),
      backgroundColor: Colors.white,
      body: Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Container(
          height: 580,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(80),
              topRight: Radius.circular(80),
            ),
            gradient: const LinearGradient(
              begin: Alignment(-0.951, -1),
              end: Alignment(1.508, 1.437),
              colors: <Color>[
                Color(0xff9d6bff),
                Color(0xff6617ff),
                Color(0xff8048ec),
                Color(0xffffffff)
              ],
              stops: <double>[0, 0.5, 1, 2],
            ),
          ),
        ),
        // child: Text("gdhgfshj"),
      ),
    );
  }
}
