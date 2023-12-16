import 'package:flutter/material.dart';

class GamingScreen extends StatefulWidget {
  const GamingScreen({super.key});

  @override
  State<GamingScreen> createState() => _GamingScreenState();
}

class _GamingScreenState extends State<GamingScreen> {
  int userScore = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Add your interactive elements here
          InteractiveQuiz(
            question: 'What is the correct hand signal for a right turn?',
            options: ['A', 'B', 'C', 'D'],
            correctAnswer: 'B',
            onAnswerSelected: (selectedAnswer) {
              // Check if the answer is correct and update user score
              if (selectedAnswer == 'B') {
                setState(() {
                  userScore += 10;
                });
              }
            },
          ),
          // Display user score
          Text('Your Score: $userScore'),
        ],
      ),
    );
  }
}

class InteractiveQuiz extends StatelessWidget {
  final String question;
  final List<String> options;
  final String correctAnswer;
  final Function(String) onAnswerSelected;

  InteractiveQuiz({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question),
        // Display answer options using Radio buttons
        Column(
          children: options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: null,
              onChanged: (String? value) {
                onAnswerSelected(value ?? '');
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
