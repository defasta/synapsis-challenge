import 'package:synapsis_mobile_engineer_challenge/core/dto/params.dart';
import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/core/usecases/usecase.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/repositories/quiz_repository.dart';

class FinishQuizUseCase implements UseCase<DataState<dynamic>, SubmitQuiz> {
  final QuizRepository _quizRepository;
  FinishQuizUseCase(this._quizRepository);

  @override
  Future<DataState> call({required SubmitQuiz params}) {
    return _quizRepository.finishQuiz(params);
  }
}
