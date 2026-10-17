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
    final screenWidth = MediaQuery.of(context).size.width;
    
    final maxScore = QuizData.questions.length * 10;
    String feedbackMessage;
    IconData feedbackIcon;
    Color feedbackColor;

    if (provider.score == maxScore) {
      feedbackMessage = "Sempurna! Kamu master Flutter!";
      feedbackIcon = Icons.workspace_premium;
      feedbackColor = Colors.amber;
    } else if (provider.score >= maxScore * 0.7) {
      feedbackMessage = "Luar biasa! Pemahamanmu sangat baik.";
      feedbackIcon = Icons.thumb_up_alt;
      feedbackColor = Colors.green;
    } else if (provider.score >= maxScore * 0.4) {
      feedbackMessage = "Lumayan! Ayo pelajari modulnya lagi.";
      feedbackIcon = Icons.menu_book;
      feedbackColor = Colors.orange;
    } else {
      feedbackMessage = "Jangan menyerah! Coba lagi ya.";
      feedbackIcon = Icons.sentiment_dissatisfied;
      feedbackColor = Colors.redAccent;
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Tombol Tema di pojok kanan atas
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: IconButton(
                  icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                  onPressed: () => themeProvider.toggleTheme(),
                  tooltip: 'Ganti Tema',
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(screenWidth * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(feedbackIcon, size: screenWidth * 0.3, color: feedbackColor),
                    SizedBox(height: screenWidth * 0.05),
                    Text('Kuis Selesai!', style: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.w900)),
                    SizedBox(height: screenWidth * 0.02),
                    Text(
                      'Kerja bagus, ${provider.userName}!',
                      style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    Text(
                      feedbackMessage,
                      style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenWidth * 0.08),
                    Container(
                      padding: EdgeInsets.all(screenWidth * 0.1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: feedbackColor.withOpacity(0.1),
                        border: Border.all(color: feedbackColor, width: 4),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${provider.score}',
                            style: TextStyle(fontSize: screenWidth * 0.15, fontWeight: FontWeight.w900, color: feedbackColor, height: 1.0),
                          ),
                          Text(
                            '/ $maxScore',
                            style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.12),
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
          ],
        ),
      ),
    );
  }
}