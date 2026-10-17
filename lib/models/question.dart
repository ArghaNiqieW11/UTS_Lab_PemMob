class Question {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });
}