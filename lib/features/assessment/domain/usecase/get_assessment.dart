import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/core/usecases/usecase.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/entities/assessment.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/repositories/assessment_repository.dart';

class GetAssessmentUseCase
    implements UseCase<DataState<List<AssessmentEntity>>, String> {
  final AssessmentRepository _assessmentRepository;

  GetAssessmentUseCase(this._assessmentRepository);
  @override
  Future<DataState<List<AssessmentEntity>>> call({required String params}) {
    return _assessmentRepository.getAssessments(params);
  }
}
