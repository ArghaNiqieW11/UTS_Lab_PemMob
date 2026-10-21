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
    String feedbackSubtitle; // Pesan yang berubah-ubah
    Color feedbackColor;
    IconData assetIcon;

    // LOGIKA SKOR DINAMIS & PERBAIKAN KONTRAS
    if (provider.score == maxScore) {
      feedbackTitle = "LEGEND STATUS!";
      feedbackSubtitle = "Performa kelas dunia, ${provider.userName}!";
      feedbackColor = const Color(0xFFFBE122); 
      assetIcon = Icons.emoji_events_rounded;
    } else if (provider.score >= maxScore * 0.7) {
      feedbackTitle = "PEMAIN INTI!";
      feedbackSubtitle = "Kerja bagus, ${provider.userName}! Pertahankan posisimu.";
      // FIX KONTRAS: Di Light Mode, Merah menyaru dengan background. Kita ganti ke Putih.
      feedbackColor = isDark ? const Color(0xFFFBE122) : Colors.white; 
      assetIcon = Icons.local_fire_department_rounded;
    } else {
      feedbackTitle = "BALIK KE AKADEMI!";
      feedbackSubtitle = "Latihan lagi, ${provider.userName}! Jangan menyerah.";
      feedbackColor = isDark ? Colors.grey : Colors.white70;
      assetIcon = Icons.sports_soccer_rounded;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/old_trafford.jpg',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(isDark ? 0.85 : 0.65),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    // FIX VISIBILITAS IKON TEMA: Diberi alas lingkaran hitam transparan
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
                      child: IconButton(
                        icon: Icon(themeProvider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
                        color: Colors.white,
                        onPressed: () => themeProvider.toggleTheme(),
                      ),
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
                          SizedBox(
                            height: screenWidth * 0.4,
                            width: screenWidth * 0.4,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                RotationTransition(
                                  turns: _spinController,
                                  child: Icon(Icons.sunny, size: screenWidth * 0.4, color: feedbackColor.withOpacity(0.3)),
                                ),
                                Icon(assetIcon, size: screenWidth * 0.25, color: feedbackColor),
                              ],
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.04),
                          Text(
                            feedbackTitle,
                            style: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          // TEKS SUBTITLE SEKARANG DINAMIS
                          Text(
                            feedbackSubtitle,
                            style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.w700, color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: screenWidth * 0.08),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: screenWidth * 0.1),
                            decoration: BoxDecoration(
                              color: isDark ? Colors.black.withOpacity(0.6) : Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: isDark ? const Color(0xFF333333) : Colors.white, width: 2),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'TOTAL SKOR',
                                  style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w900, color: isDark ? Colors.grey : const Color(0xFF4B4B4B), letterSpacing: 2),
                                ),
                                SizedBox(height: screenWidth * 0.02),
                                TweenAnimationBuilder<int>(
                                  tween: IntTween(begin: 0, end: provider.score),
                                  duration: const Duration(seconds: 2),
                                  curve: Curves.elasticOut,
                                  builder: (context, value, child) {
                                    // Warna skor tetap Emas atau MU Red agar kontras di kotak putih/hitam
                                    return Text(
                                      '$value',
                                      style: TextStyle(fontSize: screenWidth * 0.25, fontWeight: FontWeight.w900, color: isDark ? const Color(0xFFFBE122) : const Color(0xFFB51914), height: 1.0),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.1),
                          PrimaryButton(
                            text: 'MAIN LAGI',
                            color: isDark ? const Color(0xFF001489) : const Color(0xFFB51914),
                            shadowColor: Colors.black,
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
        ],
      ),
    );
  }
}