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
    String feedbackTitle;
    Color feedbackColor;
    String assetIcon;

    if (provider.score == maxScore) {
      feedbackTitle = "SEMPURNA!";
      feedbackColor = const Color(0xFFFFC800);
      assetIcon = '🏆';
    } else if (provider.score >= maxScore * 0.7) {
      feedbackTitle = "LUAR BIASA!";
      feedbackColor = const Color(0xFF58CC02);
      assetIcon = '🔥';
    } else {
      feedbackTitle = "AYO COBA LAGI!";
      feedbackColor = const Color(0xFFFF4B4B);
      assetIcon = '💪';
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: IconButton(
                  icon: Icon(themeProvider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
                  color: isDark ? Colors.amber : const Color(0xFF1CB0F6),
                  onPressed: () => themeProvider.toggleTheme(),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(assetIcon, style: TextStyle(fontSize: screenWidth * 0.25)),
                      SizedBox(height: screenWidth * 0.04),
                      Text(
                        feedbackTitle,
                        style: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.w900, color: feedbackColor, letterSpacing: 2),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Text(
                        'Kerja bagus, ${provider.userName}!',
                        style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w700, color: isDark ? Colors.white : const Color(0xFF4B4B4B)),
                      ),
                      SizedBox(height: screenWidth * 0.08),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.1),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF202F36) : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: isDark ? const Color(0xFF37464F) : const Color(0xFFE5E5E5), width: 4),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'TOTAL SKOR',
                              style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w900, color: Colors.grey, letterSpacing: 2),
                            ),
                            SizedBox(height: screenWidth * 0.02),
                            TweenAnimationBuilder<int>(
                              tween: IntTween(begin: 0, end: provider.score),
                              duration: const Duration(seconds: 2),
                              curve: Curves.elasticOut,
                              builder: (context, value, child) {
                                return Text(
                                  '$value',
                                  style: TextStyle(fontSize: screenWidth * 0.22, fontWeight: FontWeight.w900, color: feedbackColor, height: 1.0),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.1),
                      PrimaryButton(
                        text: 'MAIN LAGI',
                        color: const Color(0xFF58CC02),
                        shadowColor: const Color(0xFF58A700),
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
          ],
        ),
      ),
    );
  }
}