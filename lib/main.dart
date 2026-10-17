import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/quiz_provider.dart';
import 'config/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: const BrainBlitzApp(),
    ),
  );
}

class BrainBlitzApp extends StatelessWidget {
  const BrainBlitzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'BrainBlitz Quiz',
      themeMode: ThemeMode.system, 
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple, 
          brightness: Brightness.light,
        ),
        fontFamily: GoogleFonts.poppins().fontFamily, 
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple, 
          brightness: Brightness.dark,
        ),
      
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}