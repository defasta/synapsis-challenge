import 'package:synapsis_mobile_engineer_challenge/core/dto/params.dart';

abstract class RemoteQuizEvent {
  const RemoteQuizEvent();
}

class GetQuestions extends RemoteQuizEvent {
  final String assessmentId;
  const GetQuestions(this.assessmentId);

  List<Object> get props => [assessmentId];
}

class FinishQuiz extends RemoteQuizEvent {
  final SubmitQuiz submitQuiz;
  const FinishQuiz(this.submitQuiz);

  List<Object> get props => [submitQuiz];
}
