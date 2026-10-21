import 'dart:math'; 
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

    // Palet warna khas Manchester United (Merah, Hitam, Emas, Biru Jersey Away)
    final List<Color> baseColors = [
      const Color(0xFFDA291C), // MU Red
      const Color(0xFF000000), // Black
      const Color(0xFFC7A000), // Dark Gold
      const Color(0xFF001489), // Deep Blue (Away/Third Kit)
    ];

    final random = Random(provider.currentQuestionIndex);
    final List<Color> shuffledColors = List.from(baseColors)..shuffle(random);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final bool shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Keluar Pertandingan?', style: TextStyle(fontWeight: FontWeight.w900)),
            content: const Text('Skormu akan hangus jika meninggalkan lapangan sekarang.'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Batal', style: TextStyle(fontWeight: FontWeight.bold))),
              TextButton(
                onPressed: () {
                  context.read<QuizProvider>().resetQuiz();
                  Navigator.of(context).pop(true);
                },
                child: const Text('Keluar', style: TextStyle(color: Color(0xFFDA291C), fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ) ?? false;
        if (shouldPop && context.mounted) context.go('/');
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: isDark ? const Color(0xFF333333) : const Color(0xFFE5E5E5),
              color: const Color(0xFFFBE122), // Progress bar warna Emas MU
              minHeight: 16,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(themeProvider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
              color: isDark ? const Color(0xFFFBE122) : const Color(0xFFDA291C),
              onPressed: () => themeProvider.toggleTheme(),
            ),
            SizedBox(width: screenWidth * 0.02),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenWidth * 0.02),
            child: Column(
              children: [
                SizedBox(height: screenWidth * 0.04),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
                  child: Container(
                    key: ValueKey<int>(provider.currentQuestionIndex),
                    width: double.infinity,
                    padding: EdgeInsets.all(screenWidth * 0.08),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: isDark ? const Color(0xFF333333) : const Color(0xFFE5E5E5), width: 3),
                    ),
                    child: Text(
                      currentQuestion.questionText,
                      style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w800, color: isDark ? Colors.white : const Color(0xFF111111)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.08),
                Expanded(
                  child: ListView.builder(
                    itemCount: currentQuestion.options.length,
                    itemBuilder: (context, index) {
                      final dynamicColor = shuffledColors[index % shuffledColors.length];

                      return Padding(
                        padding: EdgeInsets.only(bottom: screenWidth * 0.04),
                        child: InkWell(
                          onTap: () {
                            bool isCorrect = index == currentQuestion.correctOptionIndex;
                            provider.answerQuestion(isCorrect);
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(screenWidth * 0.05),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF111111) : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: dynamicColor, width: 3),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.1,
                                  height: screenWidth * 0.1,
                                  decoration: BoxDecoration(color: dynamicColor, borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Text(['A', 'B', 'C', 'D'][index], style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white, fontSize: 18)),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.04),
                                Expanded(
                                  child: Text(
                                    currentQuestion.options[index],
                                    style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.w700, color: isDark ? Colors.white : const Color(0xFF111111)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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