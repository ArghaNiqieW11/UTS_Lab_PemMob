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
          title: 'GGMU Quiz',
          themeMode: themeProvider.themeMode, 
          theme: ThemeData(
            // Light Mode: Background Merah MU
            scaffoldBackgroundColor: const Color(0xFFDA291C),
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFDA291C), brightness: Brightness.light),
            fontFamily: GoogleFonts.oswald().fontFamily,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            // Dark Mode: Background Biru Away/Third Kit
            scaffoldBackgroundColor: const Color(0xFF001489),
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF001489), brightness: Brightness.dark),
            fontFamily: GoogleFonts.oswald().fontFamily,
            useMaterial3: true,
          ),
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}