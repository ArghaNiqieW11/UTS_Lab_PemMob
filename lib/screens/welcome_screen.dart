import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/quiz_provider.dart';
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
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(screenWidth * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.psychology, size: screenWidth * 0.3, color: Theme.of(context).colorScheme.primary),
                SizedBox(height: screenWidth * 0.05),
                Text('BrainBlitz', style: TextStyle(fontSize: screenWidth * 0.08, fontWeight: FontWeight.bold)),
                Text('Uji Pengetahuan Flutter-mu!', style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey)),
                SizedBox(height: screenWidth * 0.1),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Masukkan Nama Kamu',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: screenWidth * 0.08),
                PrimaryButton(
                  text: 'Mulai Kuis',
                  onPressed: () {
                    if (_nameController.text.isNotEmpty) {
                      context.read<QuizProvider>().setUserName(_nameController.text);
                      context.go('/quiz');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}