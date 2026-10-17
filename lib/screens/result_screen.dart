import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_events, size: screenWidth * 0.3, color: Colors.amber),
                SizedBox(height: screenWidth * 0.05),
                Text('Kuis Selesai!', style: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold)),
                SizedBox(height: screenWidth * 0.02),
                Text(
                  'Kerja bagus, ${provider.userName}!',
                  style: TextStyle(fontSize: screenWidth * 0.05),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenWidth * 0.05),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.08),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Text(
                    '${provider.score}',
                    style: TextStyle(fontSize: screenWidth * 0.12, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                SizedBox(height: screenWidth * 0.1),
                PrimaryButton(
                  text: 'Main Lagi',
                  onPressed: () {
                    provider.resetQuiz();
                    context.go('/');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}