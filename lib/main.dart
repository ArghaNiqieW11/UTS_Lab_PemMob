import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/quiz_provider.dart';
import 'providers/theme_provider.dart';
import 'config/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const BrainBlitzApp(),
    ),
  );
}

class BrainBlitzApp extends StatelessWidget {
  const BrainBlitzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          title: 'BrainBlitz Quiz',
          themeMode: themeProvider.themeMode, 
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFF7F9FC),
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF58CC02), brightness: Brightness.light),
            // Menggunakan font Fredoka yang sangat cocok untuk tema gamified
            fontFamily: GoogleFonts.fredoka().fontFamily,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF131F24),
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF58CC02), brightness: Brightness.dark),
            // Menggunakan font Fredoka
            fontFamily: GoogleFonts.fredoka().fontFamily,
            useMaterial3: true,
          ),
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}