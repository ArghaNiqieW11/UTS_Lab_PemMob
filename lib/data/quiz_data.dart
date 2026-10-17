import '../models/question.dart';

class QuizData {
  static const List<Question> questions = [
    Question(
      questionText: 'Apa bahasa pemrograman utama yang digunakan oleh Flutter?',
      options: ['Java', 'Kotlin', 'Dart', 'Swift'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'Widget apa yang digunakan untuk menyusun elemen secara vertikal?',
      options: ['Row', 'Column', 'Stack', 'Container'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Manakah yang BUKAN merupakan jenis widget di Flutter?',
      options: ['StatelessWidget', 'StatefulWidget', 'InheritedWidget', 'DynamicWidget'],
      correctOptionIndex: 3,
    ),
  ];
}