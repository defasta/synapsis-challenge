import 'package:equatable/equatable.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/entities/question.dart';

abstract class RemoteQuizState extends Equatable {
  final List<QuestionEntity>? questions;
  final String? error;

  const RemoteQuizState({this.questions, this.error});

  @override
  List<Object> get props => [questions ?? [], error ?? ''];
}

class QuestionsLoading extends RemoteQuizState {
  const QuestionsLoading();
}

class QuestionsLoadDone extends RemoteQuizState {
  const QuestionsLoadDone(List<QuestionEntity> questions)
      : super(questions: questions);
}

class QuestionsLoadError extends RemoteQuizState {
  const QuestionsLoadError(String error) : super(error: error);
}

class FinishQuizDone extends RemoteQuizState {
  const FinishQuizDone();
}

class FinishQuizError extends RemoteQuizState {
  const FinishQuizError(String error) : super(error: error);
}
