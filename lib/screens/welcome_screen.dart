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
  late Animation<Offset> _floatingAnimation;

  @override
  void initState() {
    super.initState();
    // Animasi melayang (floating)
    _animController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    _floatingAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.1)).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
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
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark 
                ? [const Color(0xFF0F2027), const Color(0xFF203A43), const Color(0xFF2C5364)] // Deep modern dark
                : [const Color(0xFFE2E2E2), const Color(0xFFC9D6FF)], // Soft premium light
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: IconButton(
                    icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode, color: isDark ? Colors.amber : Colors.deepPurple),
                    onPressed: () => themeProvider.toggleTheme(),
                    tooltip: 'Ganti Tema',
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(screenWidth * 0.08),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(isDark ? 0.7 : 0.9),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(0, 15)),
                          BoxShadow(color: const Color(0xFF6C63FF).withOpacity(0.2), blurRadius: 20, offset: const Offset(0, -5)),
                        ],
                        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.08),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SlideTransition(
                              position: _floatingAnimation,
                              child: Container(
                                padding: EdgeInsets.all(screenWidth * 0.05),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF6C63FF).withOpacity(0.1),
                                  boxShadow: [BoxShadow(color: const Color(0xFF6C63FF).withOpacity(0.3), blurRadius: 20, spreadRadius: 5)],
                                ),
                                child: Icon(Icons.psychology_rounded, size: screenWidth * 0.25, color: const Color(0xFF6C63FF)),
                              ),
                            ),
                            SizedBox(height: screenWidth * 0.06),
                            Text('BrainBlitz', style: TextStyle(fontSize: screenWidth * 0.09, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
                            SizedBox(height: screenWidth * 0.02),
                            Text('Uji Pengetahuan Flutter-mu!', style: TextStyle(fontSize: screenWidth * 0.04, color: isDark ? Colors.grey[400] : Colors.grey[700])),
                            SizedBox(height: screenWidth * 0.08),
                            TextField(
                              controller: _nameController,
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: screenWidth * 0.045),
                              decoration: InputDecoration(
                                labelText: 'Nama Panggilan',
                                hintText: 'Ketik namamu di sini...',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                                filled: true,
                                fillColor: isDark ? Colors.grey[900]?.withOpacity(0.5) : Colors.grey[200],
                                prefixIcon: const Icon(Icons.person, color: Color(0xFF6C63FF)),
                                contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.05),
                              ),
                            ),
                            SizedBox(height: screenWidth * 0.08),
                            PrimaryButton(
                              text: 'Mulai Tantangan',
                              onPressed: () {
                                if (_nameController.text.trim().isNotEmpty) {
                                  context.read<QuizProvider>().setUserName(_nameController.text.trim());
                                  context.go('/quiz');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: const Text('Ops! Nama tidak boleh kosong ya.', style: TextStyle(fontWeight: FontWeight.bold)),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    backgroundColor: Colors.redAccent,
                                  ));
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}