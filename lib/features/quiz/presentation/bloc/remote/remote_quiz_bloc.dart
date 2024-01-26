import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/usecase/finish_quiz.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/usecase/get_queston.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/presentation/bloc/remote/remote_quiz_event.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/presentation/bloc/remote/remote_quiz_state.dart';

class RemoteQuizBloc extends Bloc<RemoteQuizEvent, RemoteQuizState> {
  final GetQuestionUseCase _getQuestionUseCase;
  final FinishQuizUseCase _finishQuizUseCase;

  RemoteQuizBloc(this._getQuestionUseCase, this._finishQuizUseCase)
      : super(const QuestionsLoading()) {
    on<GetQuestions>(onGetQuestions);
    on<FinishQuiz>(onFinishQuiz);
  }

  void onGetQuestions(GetQuestions event, Emitter<RemoteQuizState> emit) async {
    final dataState = await _getQuestionUseCase(params: event.assessmentId);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(QuestionsLoadDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(QuestionsLoadError(dataState.error!));
    }
  }

  void onFinishQuiz(FinishQuiz event, Emitter<RemoteQuizState> emit) async {
    final dataState = await _finishQuizUseCase(params: event.submitQuiz);

    if (dataState is DataSuccess) {
      emit(FinishQuizDone());
    }

    if (dataState is DataFailed) {
      emit(FinishQuizError(dataState.error!));
    }
  }
}
