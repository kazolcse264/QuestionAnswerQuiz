import 'package:flutter/material.dart';
import 'package:question_answer_quiz/const/text_style.dart';

import '../models/question_generator.dart';

class QuizItem extends StatefulWidget {
  final int serial;
  final Quiz quiz;
  final Function(String) onAnswer;

  const QuizItem(
      {Key? key,
      required this.serial,
      required this.quiz,
      required this.onAnswer})
      : super(key: key);

  @override
  State<QuizItem> createState() => _QuizItemState();
}

class _QuizItemState extends State<QuizItem> {
  String? groupValue;
  @override
  void initState() {
    groupValue = widget.quiz.givenAnswer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.serial}. ',
              style: questionStyle,
            ),
            Flexible(child: Text(widget.quiz.question,style: questionStyle,)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
             children: widget.quiz.answers
                    .map(
                      (e) => Row(
                        children: [
                          Radio<String>(
                            value: e,
                            groupValue: groupValue,
                            onChanged: (value){
                              setState(() {
                                groupValue = value;
                              });
                              widget.onAnswer(groupValue!);
                            },
                          ),
                          Text(e),
                        ],
                      ),
                    )
                    .toList(),
          ),
        )
      ],
    );
  }
}
