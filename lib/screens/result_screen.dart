import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/primary_button.dart';
import '../data/quiz_data.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    
    final maxScore = QuizData.questions.length * 10;
    String feedbackMessage;
    IconData feedbackIcon;
    Color feedbackColor;

    if (provider.score == maxScore) {
      feedbackMessage = "Sempurna! Kamu pantas jadi Master Flutter.";
      feedbackIcon = Icons.stars_rounded;
      feedbackColor = Colors.amber;
    } else if (provider.score >= maxScore * 0.7) {
      feedbackMessage = "Luar biasa! Pemahamanmu sangat tajam.";
      feedbackIcon = Icons.thumb_up_alt_rounded;
      feedbackColor = Colors.greenAccent.shade400;
    } else if (provider.score >= maxScore * 0.4) {
      feedbackMessage = "Lumayan! Ayo baca kembali modulnya.";
      feedbackIcon = Icons.menu_book_rounded;
      feedbackColor = Colors.orangeAccent;
    } else {
      feedbackMessage = "Jangan menyerah! Semua butuh proses.";
      feedbackIcon = Icons.sentiment_dissatisfied_rounded;
      feedbackColor = Colors.redAccent;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: IconButton(
                  icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode, color: isDark ? Colors.amber : Colors.deepPurple),
                  onPressed: () => themeProvider.toggleTheme(),
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(screenWidth * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.06),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: feedbackColor.withOpacity(0.1), boxShadow: [BoxShadow(color: feedbackColor.withOpacity(0.3), blurRadius: 30, spreadRadius: 5)]),
                      child: Icon(feedbackIcon, size: screenWidth * 0.25, color: feedbackColor),
                    ),
                    SizedBox(height: screenWidth * 0.06),
                    Text('Misi Selesai!', style: TextStyle(fontSize: screenWidth * 0.09, fontWeight: FontWeight.w900, letterSpacing: 1)),
                    SizedBox(height: screenWidth * 0.02),
                    Text(
                      'Hebat, ${provider.userName}!',
                      style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    Text(
                      feedbackMessage,
                      style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenWidth * 0.1),
                    // Animasi Penghitung Skor Berjalan (Counter Animation)
                    TweenAnimationBuilder<int>(
                      tween: IntTween(begin: 0, end: provider.score),
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeOutExpo,
                      builder: (context, value, child) {
                        return Container(
                          padding: EdgeInsets.all(screenWidth * 0.1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
                            border: Border.all(color: feedbackColor.withOpacity(0.5), width: 6),
                            boxShadow: [BoxShadow(color: feedbackColor.withOpacity(0.2), blurRadius: 20, spreadRadius: 5)],
                          ),
                          child: Column(
                            children: [
                              Text('$value', style: TextStyle(fontSize: screenWidth * 0.16, fontWeight: FontWeight.w900, color: feedbackColor, height: 1.0)),
                              Text('DARI $maxScore', style: TextStyle(fontSize: screenWidth * 0.035, fontWeight: FontWeight.w800, color: Colors.grey, letterSpacing: 1.5)),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: screenWidth * 0.12),
                    PrimaryButton(
                      text: 'Ulangi Kuis',
                      onPressed: () {
                        provider.resetQuiz();
                        context.go('/');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}