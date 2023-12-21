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
        backgroundColor: Color(0xff9d6bff),
      ),
      backgroundColor: Colors.white,
      body: Align(
        alignment: AlignmentDirectional.bottomEnd,
        child: Container(
          height: 580,
          width: 400,
          decoration: BoxDecoration(
            color: Color(0xffc780ff),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(80),
              topRight: Radius.circular(80),
            ),
          ),
          // child: Text("gdhgfshj"),
        ),
      ),
    );
  }
}
