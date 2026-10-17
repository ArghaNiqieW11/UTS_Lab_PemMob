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
                ? [const Color(0xFF1F1C2C), const Color(0xFF928DAB)] 
                : [const Color(0xFF6C63FF).withOpacity(0.2), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
                    icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                    onPressed: () => themeProvider.toggleTheme(),
                    tooltip: 'Ganti Tema',
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(screenWidth * 0.08),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.08),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.psychology_outlined, size: screenWidth * 0.25, color: const Color(0xFF6C63FF)),
                            SizedBox(height: screenWidth * 0.04),
                            Text('BrainBlitz', style: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.w900)),
                            SizedBox(height: screenWidth * 0.02),
                            Text('Uji Pengetahuan Flutter-mu!', style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey)),
                            SizedBox(height: screenWidth * 0.08),
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Nama Panggilan',
                                hintText: 'Ketik nama kamu di sini...',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                                prefixIcon: const Icon(Icons.person),
                              ),
                            ),
                            SizedBox(height: screenWidth * 0.08),
                            PrimaryButton(
                              text: 'Mulai Kuis',
                              onPressed: () {
                                if (_nameController.text.trim().isNotEmpty) {
                                  context.read<QuizProvider>().setUserName(_nameController.text.trim());
                                  context.go('/quiz');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nama tidak boleh kosong!')));
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