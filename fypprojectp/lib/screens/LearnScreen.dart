import 'package:flutter/material.dart';
import 'package:fypprojectp/screens/QuizScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});
  static const routeName = '/result_screen';

  @override
  State<LearnScreen> createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Quiz Time! Gear Up Your Mind for a Ride of Wisdom and Adventure",
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff9d6bff),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                LearningModuleCard(
                  title: 'Basic Riding Techniques',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                LearningModuleCard(
                  title: 'Traffic Rules',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                LearningModuleCard(
                  title: 'Vehicle Maintenance',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                LearningModuleCard(
                  title: 'Minor Slip & Fall',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                LearningModuleCard(
                  title: 'Traffic Rules',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LearningModuleCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  LearningModuleCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        textColor: Colors.black,
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
