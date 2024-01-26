import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/entities/question.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/presentation/bloc/remote/remote_quiz_state.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/presentation/widgets/checkbox_options.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/presentation/widgets/radio_options.dart';

class QuestionsWidget extends StatelessWidget {
  final QuestionEntity questions;
  final bool isMultipleChoice;
  final RemoteQuizState state;
  final void Function(String optionId) onSelectedOption;

  const QuestionsWidget(
      {Key? key,
      required this.questions,
      required this.isMultipleChoice,
      required this.state,
      required this.onSelectedOption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMultipleChoice == true
        ? Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Answer',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: Colors.black26,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: RadioList(questions.options!, (value) {
                        onSelectedOption(questions.options![value].optionId!);
                      }))
                ],
              ),
            ),
          )
        : Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Answer',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    color: Colors.black26,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      child: Column(children: [
                        Expanded(
                            child: CheckboxList(questions.options!, (optionId) {
                          onSelectedOption(optionId);
                        }))
                      ]))
                ],
              ),
            ),
          );
  }
}
