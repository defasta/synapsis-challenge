import 'package:synapsis_mobile_engineer_challenge/core/usecases/usecase.dart';
import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/entities/question.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/repositories/quiz_repository.dart';

class GetQuestionUseCase
    implements UseCase<DataState<List<QuestionEntity>>, String> {
  final QuizRepository _quizRepository;

  GetQuestionUseCase(this._quizRepository);

  @override
  Future<DataState<List<QuestionEntity>>> call({required String params}) {
    return _quizRepository.getQuestions(params);
  }
}
