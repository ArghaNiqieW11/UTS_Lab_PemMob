import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../data/quiz_data.dart';
import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final questions = QuizData.questions;
    final screenWidth = MediaQuery.of(context).size.width;

    if (provider.currentQuestionIndex >= questions.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) => context.go('/result'));
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion = questions[provider.currentQuestionIndex];
    final progress = (provider.currentQuestionIndex + 1) / questions.length;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final bool shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Keluar dari Kuis?', style: TextStyle(fontWeight: FontWeight.bold)),
            content: const Text('Skormu saat ini akan hangus dan tidak tersimpan.'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Lanjut Main', style: TextStyle(color: Colors.grey))),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () {
                  context.read<QuizProvider>().resetQuiz();
                  Navigator.of(context).pop(true);
                },
                child: const Text('Keluar'),
              ),
            ],
          ),
        ) ?? false;
        
        if (shouldPop && context.mounted) context.go('/');
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Soal ${provider.currentQuestionIndex + 1}', style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
          centerTitle: true,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode, color: isDark ? Colors.amber : Colors.deepPurple), onPressed: () => themeProvider.toggleTheme()),
            SizedBox(width: screenWidth * 0.02),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: screenWidth * 0.02),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
                    color: const Color(0xFF6C63FF),
                    minHeight: 10,
                  ),
                ),
                SizedBox(height: screenWidth * 0.08),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    switchInCurve: Curves.easeOutBack,
                    switchOutCurve: Curves.easeIn,
                    transitionBuilder: (child, animation) => FadeTransition(
                      opacity: animation,
                      child: SlideTransition(position: Tween<Offset>(begin: const Offset(0.2, 0), end: Offset.zero).animate(animation), child: child),
                    ),
                    child: SingleChildScrollView(
                      key: ValueKey<int>(provider.currentQuestionIndex),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(screenWidth * 0.08),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [BoxShadow(color: const Color(0xFF6C63FF).withOpacity(0.15), blurRadius: 20, spreadRadius: 2, offset: const Offset(0, 10))],
                            ),
                            child: Text(
                              currentQuestion.questionText,
                              style: TextStyle(fontSize: screenWidth * 0.048, fontWeight: FontWeight.bold, height: 1.5, color: isDark ? Colors.white : Colors.black87),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.1),
                          ...List.generate(currentQuestion.options.length, (index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: screenWidth * 0.04),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    bool isCorrect = index == currentQuestion.correctOptionIndex;
                                    provider.answerQuestion(isCorrect);
                                  },
                                  borderRadius: BorderRadius.circular(20),
                                  splashColor: const Color(0xFF6C63FF).withOpacity(0.2),
                                  highlightColor: const Color(0xFF6C63FF).withOpacity(0.1),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: double.infinity,
                                    padding: EdgeInsets.all(screenWidth * 0.05),
                                    decoration: BoxDecoration(
                                      color: isDark ? Colors.grey[900] : Colors.grey[50],
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: isDark ? Colors.grey[800]! : Colors.grey[300]!, width: 2),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(screenWidth * 0.03),
                                          decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF6C63FF).withOpacity(0.1)),
                                          child: Text(['A', 'B', 'C', 'D'][index], style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF6C63FF))),
                                        ),
                                        SizedBox(width: screenWidth * 0.04),
                                        Expanded(child: Text(currentQuestion.options[index], style: TextStyle(fontSize: screenWidth * 0.042, fontWeight: FontWeight.w600))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}