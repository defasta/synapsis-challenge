import 'package:synapsis_mobile_engineer_challenge/core/dto/params.dart';
import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/entities/question.dart';

abstract class QuizRepository {
  Future<DataState<List<QuestionEntity>>> getQuestions(String assessmentId);
  Future<DataState<dynamic>> finishQuiz(SubmitQuiz quizParams);
}
