import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_mobile_engineer_challenge/core/dto/params.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/presentation/bloc/remote/remote_quiz_bloc.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/presentation/bloc/remote/remote_quiz_event.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/presentation/bloc/remote/remote_quiz_state.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/presentation/widgets/questions.dart';
import 'package:synapsis_mobile_engineer_challenge/injection_container.dart';

class Quiz extends StatefulWidget {
  final String assessmentId;
  const Quiz({Key? key, required this.assessmentId}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var _questionIndex = 0;
  var _questionLength = 0;
  SubmitQuiz? submitQuiz;
  List<Answer> answers = [];

  void _answerQuestion() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  void _backToPreviousQuestion() {
    setState(() {
      _questionIndex = _questionIndex - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider<RemoteQuizBloc>(
        create: (context) => sl()..add(GetQuestions(widget.assessmentId)),
        child: Scaffold(
          body: BlocListener<RemoteQuizBloc, RemoteQuizState>(
              listener: (context, state) {
            if (state is FinishQuizError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red.shade300,
              ));
              Navigator.pop(context);
            }
          }, child: BlocBuilder<RemoteQuizBloc, RemoteQuizState>(
            builder: (_, state) {
              if (state is QuestionsLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (state is QuestionsLoadError) {
                return const Center(
                  child: Icon(Icons.refresh),
                );
              }
              if (state is QuestionsLoadDone) {
                _questionLength = state.questions!.length;
                return SafeArea(
                    child: Container(
                        width: size.width,
                        height: size.height,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Container(
                                color: Colors.grey.shade200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        color: Colors.white,
                                        child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8,
                                                              horizontal: 16),
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 0.5,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      31,
                                                                      160,
                                                                      201)),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          4))),
                                                      child: Text(
                                                        '45 Seconds Left',
                                                        style: const TextStyle(
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 14,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    31,
                                                                    160,
                                                                    201)),
                                                      ),
                                                    ),
                                                    Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 8,
                                                                horizontal: 16),
                                                        decoration: BoxDecoration(
                                                            color: Colors.black,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4))),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.list_alt,
                                                              size: 22,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                                '${_questionIndex + 1}/${state.questions!.length}',
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                )),
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  state
                                                      .questions![
                                                          _questionIndex]
                                                      .section!,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  '${state.questions![_questionIndex].number!}. ${state.questions![_questionIndex].questionName}',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 16,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ))),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    QuestionsWidget(
                                      questions:
                                          state.questions![_questionIndex],
                                      isMultipleChoice: state
                                                  .questions![_questionIndex]
                                                  .type ==
                                              'multiple_choice'
                                          ? true
                                          : false,
                                      state: state,
                                      onSelectedOption: (optionId) {
                                        if (state.questions![_questionIndex]
                                                .type ==
                                            'multiple_choice') {
                                          if (answers.isEmpty) {
                                            answers.add(Answer(
                                                questionId: state
                                                    .questions![_questionIndex]
                                                    .questionId!,
                                                answer: optionId));
                                          } else {
                                            answers[_questionIndex].answer =
                                                optionId;
                                          }
                                        } else {
                                          if (answers.isEmpty) {
                                            answers.add(Answer(
                                                questionId: state
                                                    .questions![_questionIndex]
                                                    .questionId!,
                                                answer: optionId));
                                          } else {
                                            answers.add(Answer(
                                                questionId: state
                                                    .questions![_questionIndex]
                                                    .questionId!,
                                                answer: optionId));
                                            answers[_questionIndex].answer =
                                                optionId;
                                          }
                                        }
                                      },
                                    ),
                                    Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                              child: OutlinedButton(
                                            onPressed: () {
                                              if (_questionIndex == 0) {
                                                Navigator.pop(context);
                                              } else {
                                                _backToPreviousQuestion();
                                                BlocProvider.of<RemoteQuizBloc>(
                                                        _)
                                                    .add(GetQuestions(
                                                        widget.assessmentId));
                                              }
                                            },
                                            style: OutlinedButton.styleFrom(
                                                minimumSize:
                                                    const Size.fromHeight(50),
                                                foregroundColor: Color.fromARGB(
                                                    255, 31, 160, 201),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40,
                                                        vertical: 15),
                                                side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 31, 160, 201),
                                                    width: 1)),
                                            child: const Text(
                                              "Back",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 14,
                                                color: Color.fromARGB(
                                                    255, 31, 160, 201),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    if (_questionIndex <
                                                        _questionLength - 1) {
                                                      _answerQuestion();
                                                      BlocProvider.of<
                                                              RemoteQuizBloc>(_)
                                                          .add(GetQuestions(widget
                                                              .assessmentId));
                                                    } else {
                                                      for (int i = 1;
                                                          i < answers.length;
                                                          i++) {
                                                        if (answers[i]
                                                                .questionId ==
                                                            answers[i - 1]
                                                                .questionId) {
                                                          answers.removeAt(i);
                                                        }
                                                      }
                                                      submitQuiz = SubmitQuiz(
                                                          assessmentId: widget
                                                              .assessmentId,
                                                          answers: answers);
                                                      BlocProvider.of<
                                                              RemoteQuizBloc>(_)
                                                          .add(FinishQuiz(
                                                              submitQuiz!));
                                                    }
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      minimumSize:
                                                          const Size.fromHeight(
                                                              50),
                                                      backgroundColor:
                                                          Color.fromARGB(255,
                                                              31, 160, 201),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 40,
                                                          vertical: 15)),
                                                  child: const Text(
                                                    "Next",
                                                    style: TextStyle(
                                                      fontFamily: 'Inter',
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ))),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ))
                            ])));
              }
              return SizedBox();
            },
          )),
        ));
  }
}
