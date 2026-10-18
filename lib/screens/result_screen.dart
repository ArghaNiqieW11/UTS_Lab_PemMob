import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/primary_button.dart';
import '../data/quiz_data.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late AnimationController _spinController;

  @override
  void initState() {
    super.initState();
    // Animasi putaran cahaya
    _spinController = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuizProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    
    final maxScore = QuizData.questions.length * 10;
    String feedbackTitle;
    Color feedbackColor;
    IconData assetIcon;

    if (provider.score == maxScore) {
      feedbackTitle = "SEMPURNA!";
      feedbackColor = const Color(0xFFFFC800);
      assetIcon = Icons.workspace_premium_rounded;
    } else if (provider.score >= maxScore * 0.7) {
      feedbackTitle = "LUAR BIASA!";
      feedbackColor = const Color(0xFF58CC02);
      assetIcon = Icons.local_fire_department_rounded;
    } else {
      feedbackTitle = "AYO COBA LAGI!";
      feedbackColor = const Color(0xFFFF4B4B);
      assetIcon = Icons.fitness_center_rounded;
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
                      // Efek Sunburst / Cahaya berputar
                      SizedBox(
                        height: screenWidth * 0.4,
                        width: screenWidth * 0.4,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            RotationTransition(
                              turns: _spinController,
                              child: Icon(Icons.sunny, size: screenWidth * 0.4, color: feedbackColor.withOpacity(0.2)),
                            ),
                            Icon(assetIcon, size: screenWidth * 0.25, color: feedbackColor),
                          ],
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.02),
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
                          borderRadius: BorderRadius.circular(35),
                          border: Border.all(color: isDark ? const Color(0xFF37464F) : const Color(0xFFE5E5E5), width: 4),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 10))
                          ]
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