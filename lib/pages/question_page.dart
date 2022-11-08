import 'dart:async';

import 'package:flutter/material.dart';
import 'package:question_answer_quiz/custom_widgets/quiz_item.dart';
import 'package:question_answer_quiz/models/question_generator.dart';
import 'package:question_answer_quiz/pages/result_page.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  bool hasQuizStarted = false;
  Timer? timer;
  int count = 120;

  @override
  void initState() {
    quizList = generateQuizList;
    super.initState();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count > 0) {
        setState(() {
          count--;
        });
      } else {
        stopTimer();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const ResultPage()));
      }
    });
  }

  stopTimer() {
    if (timer != null) {
      timer!.cancel();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ResultPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Remaining : $count sec'),
        actions: [
          if (!hasQuizStarted)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    hasQuizStarted = true;
                  });
                  startTimer();
                },
                child: const Text(
                  'Start',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),
                ),
              ),
            ),
          if (hasQuizStarted)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  stopTimer();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const ResultPage()));
                },
                child: const Text(
                  'Finish',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),
                ),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: quizList.length,
              itemBuilder: (context, index) {
                final quiz = quizList[index];

                return QuizItem(
                  serial: index + 1,
                  quiz: quiz,
                  onAnswer: (answer) {
                    quizList[index].givenAnswer = answer;
                  },
                );
              }),
          if (!hasQuizStarted)
            Container(
              color: Colors.grey.shade500,
              alignment: Alignment.center,
              child: const Text(
                'Click the start button to Start the Quiz',
                style: TextStyle(
                  fontSize: 45,
                  color: Colors.red,
                ),
              ),
            )
        ],
      ),
    );
  }
}
