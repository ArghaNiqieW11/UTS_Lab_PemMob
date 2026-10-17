import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../data/quiz_data.dart';
import '../providers/quiz_provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    final questions = QuizData.questions;
    final screenWidth = MediaQuery.of(context).size.width;

    if (provider.currentQuestionIndex >= questions.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/result');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion = questions[provider.currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('BrainBlitz'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pertanyaan ${provider.currentQuestionIndex + 1}/${questions.length}',
                style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey),
              ),
              SizedBox(height: screenWidth * 0.05),
              Container(
                padding: EdgeInsets.all(screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  currentQuestion.questionText,
                  style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: screenWidth * 0.08),
              ...List.generate(currentQuestion.options.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: screenWidth * 0.03),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {
                      bool isCorrect = index == currentQuestion.correctOptionIndex;
                      provider.answerQuestion(isCorrect);
                    },
                    child: Text(
                      currentQuestion.options[index],
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}