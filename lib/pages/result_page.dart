import 'package:flutter/material.dart';
import 'package:question_answer_quiz/pages/question_page.dart';

import '../const/text_style.dart';
import '../models/question_generator.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final passMark = 8;
  @override
  Widget build(BuildContext context) {
    final result = getResult;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(result.correct>= passMark)const Text(
              'You won the Game ',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            if(result.correct< passMark)const Text(
              'You loss the Game ',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20,),
            Text(
              'Correct: ${result.correct}',
              style: resultStyle,
            ),
            const SizedBox(height: 20,),
            Text(
              'Incorrect: ${result.incorrect}',
              style: resultStyle,
            ),
            const SizedBox(height: 20,),
            TextButton(
              onPressed: () {
                quizList = [];
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QuestionPage()));
              },
              child: const Text(
                'Start Over',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
