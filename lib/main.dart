import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'What is the capital of France?',
      'answers': [
        {'text': 'Berlin', 'score': 0},
        {'text': 'Madrid', 'score': 0},
        {'text': 'Paris', 'score': 1},
        {'text': 'Rome', 'score': 0},
      ],
    },
    {
      'questionText': 'Which planet is closest to the Sun?',
      'answers': [
        {'text': 'Earth', 'score': 0},
        {'text': 'Mercury', 'score': 1},
        {'text': 'Venus', 'score': 0},
        {'text': 'Mars', 'score': 0},
      ],
    },
    {
      'questionText': 'Who wrote "Hamlet"?',
      'answers': [
        {'text': 'Charles Dickens', 'score': 0},
        {'text': 'J.K. Rowling', 'score': 0},
        {'text': 'William Shakespeare', 'score': 1},
        {'text': 'Jane Austen', 'score': 0},
      ],
    },
  ];

  int _currentQuestionIndex = 0;
  int _totalScore = 0;

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      _currentQuestionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle:true,
        title: const Text('Quiz App',style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold),),
        backgroundColor: const Color.fromARGB(255, 224, 0, 253),
      ),
      body: _currentQuestionIndex < _questions.length
          ? Quiz(
              questions: _questions,
              currentQuestionIndex: _currentQuestionIndex,
              answerQuestion: _answerQuestion,
            )
          : Result(_totalScore, _resetQuiz),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int currentQuestionIndex;
  final Function(int) answerQuestion;

  const Quiz({
    required this.questions,
    required this.currentQuestionIndex,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            questions[currentQuestionIndex]['questionText'] as String,
            style: const TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          ...(questions[currentQuestionIndex]['answers'] as List<Map<String, Object>>)
              .map((answer) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => answerQuestion(answer['score'] as int),
                child: Text(answer['text'] as String),
                
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int totalScore;
  final VoidCallback resetQuiz;

  const Result(this.totalScore, this.resetQuiz);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Quiz Complete!',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          Text(
            'Your Score: $totalScore from 3',
            style: const TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: resetQuiz,
            child: const Text('Restart Quiz'),
          ),
        ],
      ),
    );
  }
}
