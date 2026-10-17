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
      WidgetsBinding.instance.addPostFrameCallback((_) => context.go('/result'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion = questions[provider.currentQuestionIndex];
    final progress = (provider.currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('BrainBlitz', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade300,
                color: const Color(0xFF6C63FF),
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),
              SizedBox(height: screenWidth * 0.04),
              Text(
                'Pertanyaan ${provider.currentQuestionIndex + 1} dari ${questions.length}',
                style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenWidth * 0.05),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(screenWidth * 0.06),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.3), width: 2),
                        ),
                        child: Text(
                          currentQuestion.questionText,
                          style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w600, height: 1.4),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.08),
                      ...List.generate(currentQuestion.options.length, (index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: screenWidth * 0.04),
                          child: InkWell(
                            onTap: () {
                              bool isCorrect = index == currentQuestion.correctOptionIndex;
                              provider.answerQuestion(isCorrect);
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(screenWidth * 0.05),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: screenWidth * 0.035,
                                    backgroundColor: const Color(0xFF6C63FF).withOpacity(0.1),
                                    child: Text(['A', 'B', 'C', 'D'][index], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6C63FF))),
                                  ),
                                  SizedBox(width: screenWidth * 0.04),
                                  Expanded(
                                    child: Text(
                                      currentQuestion.options[index],
                                      style: TextStyle(fontSize: screenWidth * 0.04),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}