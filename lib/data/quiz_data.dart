import '../models/question.dart';

class QuizData {
  static const List<Question> questions = [
    Question(
      questionText: 'Apa bahasa pemrograman utama yang digunakan untuk mengembangkan aplikasi Flutter?',
      options: ['Java', 'Kotlin', 'Dart', 'Swift'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'Widget apa yang digunakan untuk menyusun elemen UI secara vertikal (dari atas ke bawah)?',
      options: ['Row', 'Column', 'Stack', 'Container'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Manakah yang BUKAN merupakan jenis widget dasar di Flutter?',
      options: ['StatelessWidget', 'StatefulWidget', 'InheritedWidget', 'DynamicWidget'],
      correctOptionIndex: 3,
    ),
    Question(
      questionText: 'Fitur Flutter yang memungkinkan kita melihat perubahan UI secara instan tanpa mengulang build aplikasi dari awal disebut?',
      options: ['Hot Restart', 'Hot Reload', 'Instant Build', 'Fast Compile'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Jika kamu ingin membuat aplikasi dengan state/data yang bisa berubah-ubah, widget apa yang harus dipakai?',
      options: ['StatelessWidget', 'StatefulWidget', 'MaterialApp', 'Scaffold'],
      correctOptionIndex: 1,
    ),
    Question(
      questionText: 'Widget apa yang menyediakan struktur dasar visual material (seperti AppBar, FloatingActionButton, dan Drawer)?',
      options: ['Scaffold', 'Container', 'Column', 'MaterialApp'],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'Fungsi utama yang menjadi titik awal eksekusi seluruh aplikasi Dart/Flutter adalah?',
      options: ['build()', 'runApp()', 'main()', 'start()'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'File konfigurasi utama tempat kita mendaftarkan package, assets, dan font pada proyek Flutter adalah?',
      options: ['main.dart', 'build.gradle', 'pubspec.yaml', 'AndroidManifest.xml'],
      correctOptionIndex: 2,
    ),
    Question(
      questionText: 'Untuk membuat sebuah teks menjadi tebal (bold), properti apa yang diubah pada class TextStyle?',
      options: ['fontWeight', 'fontStyle', 'fontSize', 'fontColor'],
      correctOptionIndex: 0,
    ),
    Question(
      questionText: 'Apa kegunaan utama dari MediaQuery di Flutter?',
      options: ['Memutar video/audio', 'Mendapatkan ukuran dan orientasi layar', 'Melakukan query ke database', 'Mengatur tema warna aplikasi'],
      correctOptionIndex: 1,
    ),
  ];
}