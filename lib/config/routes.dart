import 'package:go_router/go_router.dart';
import '../screens/welcome_screen.dart';
import '../screens/quiz_screen.dart';
import '../screens/result_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
    GoRoute(path: '/quiz', builder: (context, state) => const QuizScreen()),
    GoRoute(path: '/result', builder: (context, state) => const ResultScreen()),
  ],
);