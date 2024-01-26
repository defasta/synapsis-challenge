import 'package:synapsis_mobile_engineer_challenge/core/dto/params.dart';
import 'package:synapsis_mobile_engineer_challenge/core/exceptions/failure.dart';
import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/data/data_sources/remote/quiz_data_source.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/data/models/question.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/entities/question.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizDataSource _quizDataSource;
  QuizRepositoryImpl(this._quizDataSource);

  @override
  Future<DataState<List<QuestionEntity>>> getQuestions(
      String assessmentId) async {
    try {
      final result =
          await _quizDataSource.getQuestions(assessmentId: assessmentId);
      List<QuestionModel> value = result.data!['data']['question']
          .map<QuestionModel>(
              (dynamic i) => QuestionModel.fromJson(i as Map<String, dynamic>))
          .toList();
      return DataSuccess(value);
    } on ServerFailure catch (e) {
      return DataFailed(e.errorMessage);
    }
  }

  @override
  Future<DataState> finishQuiz(SubmitQuiz quizParams) async {
    try {
      final result = await _quizDataSource.finishQuiz(quizParams: quizParams);
      return DataSuccess(result);
    } on ServerFailure catch (e) {
      return DataFailed(e.errorMessage);
    }
  }
}
