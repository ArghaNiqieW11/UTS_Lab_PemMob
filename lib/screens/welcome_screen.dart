import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/primary_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND OLD TRAFFORD
          Positioned.fill(
            child: Image.asset(
              'assets/images/old_trafford.jpg',
              fit: BoxFit.cover,
              // Efek gelap agar teks di depannya tetap kontras dan terbaca
              color: Colors.black.withOpacity(0.65), 
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
                    child: IconButton(
                      icon: Icon(themeProvider.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
                      color: Colors.white,
                      iconSize: screenWidth * 0.08,
                      onPressed: () => themeProvider.toggleTheme(),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenWidth * 0.05),
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/logo.png', 
                            width: screenWidth * 0.45,
                            height: screenWidth * 0.45,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.08),
                        Text(
                          'QUIZ',
                          style: TextStyle(
                            fontSize: screenWidth * 0.15, 
                            fontWeight: FontWeight.w900, 
                            color: Colors.white,
                            letterSpacing: 3,
                          ),
                        ),
                        SizedBox(height: screenWidth * 0.02),
                        Text(
                          'Theatre of Dreams',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06, 
                            fontWeight: FontWeight.w400, 
                            color: const Color(0xFFFBE122), // Emas MU
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.06),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _nameController,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: screenWidth * 0.05),
                        decoration: InputDecoration(
                          hintText: 'Nama Fans',
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF0F0F0),
                          prefixIcon: const Icon(Icons.sports_soccer_rounded, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.06),
                      PrimaryButton(
                        text: 'KICK OFF',
                        color: isDark ? const Color(0xFF001489) : const Color(0xFFDA291C),
                        shadowColor: Colors.black,
                        onPressed: () {
                          if (_nameController.text.trim().isNotEmpty) {
                            context.read<QuizProvider>().setUserName(_nameController.text.trim());
                            context.go('/quiz');
                          }
                        },
                      ),
                      SizedBox(height: screenWidth * 0.02),
                    ],
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