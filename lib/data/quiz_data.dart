class QuizQuestion {
  final String questionText;
  final List<String> options;
  final int correctOptionIndex;

  QuizQuestion({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });
}

class QuizData {
  static List<QuizQuestion> questions = [
    QuizQuestion(
      questionText: 'Siapa manajer legendaris yang membawa Manchester United meraih Treble Winners pada tahun 1999?',
      options: [
        'Jose Mourinho',
        'Sir Alex Ferguson',
        'Matt Busby',
        'Louis van Gaal'
      ],
      correctOptionIndex: 1
    ),
    QuizQuestion(
      questionText: 'Apa julukan ikonik untuk stadion kandang Manchester United (Old Trafford)?',
      options: [
        'The Theatre of Dreams',
        'The Red Fortress',
        'Devil\'s Den',
        'Stretford End'
      ],
      correctOptionIndex: 0
    ),
    QuizQuestion(
      questionText: 'Siapakah pencetak gol terbanyak sepanjang masa (Top Scorer) Manchester United?',
      options: [
        'Cristiano Ronaldo',
        'Bobby Charlton',
        'Wayne Rooney',
        'Eric Cantona'
      ],
      correctOptionIndex: 2
    ),
    QuizQuestion(
      questionText: 'Pada tahun berapakah Manchester United pertama kali memenangkan gelar Liga Champions (European Cup)?',
      options: [
        '1999',
        '1958',
        '1968',
        '2008'
      ],
      correctOptionIndex: 2
    ),
    QuizQuestion(
      questionText: 'Siapa pemain yang terkenal dengan tendangan saltonya ke gawang Manchester City pada tahun 2011?',
      options: [
        'Robin van Persie',
        'Dimitar Berbatov',
        'Paul Scholes',
        'Wayne Rooney'
      ],
      correctOptionIndex: 3
    ),
    QuizQuestion(
      questionText: 'Siapa pemegang rekor penampilan terbanyak sepanjang masa untuk Manchester United?',
      options: [
        'Ryan Giggs',
        'Paul Scholes',
        'Gary Neville',
        'Bobby Charlton'
      ],
      correctOptionIndex: 0
    ),
    QuizQuestion(
      questionText: 'Tragedi udara Munich yang merenggut nyawa banyak pemain "Busby Babes" terjadi pada tahun?',
      options: [
        '1956',
        '1958',
        '1960',
        '1968'
      ],
      correctOptionIndex: 1
    ),
    QuizQuestion(
      questionText: 'Siapa penjaga gawang legendaris asal Denmark yang mengawal gawang MU saat Treble 1999?',
      options: [
        'Edwin van der Sar',
        'David de Gea',
        'Peter Schmeichel',
        'Fabien Barthez'
      ],
      correctOptionIndex: 2
    ),
    QuizQuestion(
      questionText: 'Pemain berjuluk "King Eric" yang sangat ikonik dengan kerah bajunya yang ditegakkan adalah?',
      options: [
        'Eric Bailly',
        'Eric Djemba-Djemba',
        'Eric Cantona',
        'Christian Eriksen'
      ],
      correctOptionIndex: 2
    ),
    QuizQuestion(
      questionText: 'Melawan klub manakah Manchester United memenangkan final Liga Champions 2008 di Moskow?',
      options: [
        'Bayern Munich',
        'Barcelona',
        'Chelsea',
        'Juventus'
      ],
      correctOptionIndex: 2
    ),
  ];
}