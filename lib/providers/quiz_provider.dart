import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  int _score = 0;
  int _currentQuestionIndex = 0;

  String get userName => _userName;
  int get score => _score;
  int get currentQuestionIndex => _currentQuestionIndex;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void answerQuestion(bool isCorrect) {
    if (isCorrect) _score += 10;
    _currentQuestionIndex++;
    notifyListeners();
  }

  void resetQuiz() {
    _score = 0;
    _currentQuestionIndex = 0;
    _userName = '';
    notifyListeners();
  }
}