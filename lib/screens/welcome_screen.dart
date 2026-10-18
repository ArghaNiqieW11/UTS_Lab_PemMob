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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenWidth * 0.05),
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.04), 
                        decoration: BoxDecoration(
                          color: const Color(0xFF1CB0F6).withOpacity(0.1),
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
                      'BrainBlitz',
                      style: TextStyle(
                        fontSize: screenWidth * 0.12, 
                        fontWeight: FontWeight.w900, 
                        color: isDark ? Colors.white : const Color(0xFF333333),
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    Text(
                      'Tantangan Kuis Flutter',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05, 
                        fontWeight: FontWeight.w700, 
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(screenWidth * 0.06),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF202F36) : Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32), 
                  topRight: Radius.circular(32)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.05), 
                    blurRadius: 20, 
                    offset: const Offset(0, -5)
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: screenWidth * 0.05),
                    decoration: InputDecoration(
                      hintText: 'Nama Pemain',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: isDark ? const Color(0xFF131F24) : const Color(0xFFF7F9FC),
                      prefixIcon: const Icon(Icons.person_outline_rounded, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: isDark ? const Color(0xFF37464F) : const Color(0xFFE5E5E5), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: isDark ? const Color(0xFF37464F) : const Color(0xFFE5E5E5), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color(0xFF1CB0F6), width: 2),
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.06),
                  PrimaryButton(
                    text: 'MULAI KUIS',
                    color: const Color(0xFF58CC02), 
                    shadowColor: const Color(0xFF58A700),
                    onPressed: () {
                      if (_nameController.text.trim().isNotEmpty) {
                        context.read<QuizProvider>().setUserName(_nameController.text.trim());
                        context.go('/quiz');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Isi namamu dulu ya!', style: TextStyle(fontWeight: FontWeight.bold)),
                            backgroundColor: const Color(0xFFFF4B4B),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          )
                        );
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
    );
  }
}