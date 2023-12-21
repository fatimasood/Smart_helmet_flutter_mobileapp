import 'package:flutter/material.dart';

class InteractiveQuiz extends StatefulWidget {
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
  State<InteractiveQuiz> createState() => _InteractiveQuizState();
}

class _InteractiveQuizState extends State<InteractiveQuiz> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.question),
        // Display answer options using Radio buttons
        Column(
          children: widget.options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: null,
              onChanged: (String? value) {
                widget.onAnswerSelected(value ?? '');
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
