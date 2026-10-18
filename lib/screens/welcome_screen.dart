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

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _nameController = TextEditingController();
  late AnimationController _animController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true);
    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                  iconSize: screenWidth * 0.08,
                  onPressed: () => themeProvider.toggleTheme(),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _bounceAnimation,
                        child: Container(
                          padding: EdgeInsets.all(screenWidth * 0.06),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC800), // Vibrant Yellow
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0xFFE5B500), width: 4),
                          ),
                          child: Icon(Icons.rocket_launch_rounded, size: screenWidth * 0.25, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.08),
                      Text(
                        'BRAINBLITZ',
                        style: TextStyle(
                          fontSize: screenWidth * 0.1, 
                          fontWeight: FontWeight.w900, 
                          color: isDark ? Colors.white : const Color(0xFF4B4B4B),
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Text(
                        'Siap menguji ilmu Flutter-mu?',
                        style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      SizedBox(height: screenWidth * 0.1),
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.06),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF202F36) : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: isDark ? const Color(0xFF37464F) : const Color(0xFFE5E5E5), width: 3),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              controller: _nameController,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w800, fontSize: screenWidth * 0.05),
                              decoration: InputDecoration(
                                hintText: 'Masukkan Namamu',
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: isDark ? const Color(0xFF131F24) : const Color(0xFFF7F9FC),
                                contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: isDark ? const Color(0xFF37464F) : const Color(0xFFE5E5E5), width: 2),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: isDark ? const Color(0xFF37464F) : const Color(0xFFE5E5E5), width: 2),
                                ),
                              ),
                            ),
                            SizedBox(height: screenWidth * 0.06),
                            PrimaryButton(
                              text: 'Mulai Main',
                              color: const Color(0xFF1CB0F6), // Vibrant Blue
                              shadowColor: const Color(0xFF1899D6),
                              onPressed: () {
                                if (_nameController.text.trim().isNotEmpty) {
                                  context.read<QuizProvider>().setUserName(_nameController.text.trim());
                                  context.go('/quiz');
                                }
                              },
                            ),
                          ],
                        ),
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