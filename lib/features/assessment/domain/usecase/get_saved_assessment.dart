import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/core/usecases/usecase.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/entities/assessment.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/repositories/assessment_repository.dart';

class GetSavedAssessmentUseCase
    implements UseCase<DataState<List<AssessmentEntity>>, void> {
  final AssessmentRepository _assessmentRepository;

  GetSavedAssessmentUseCase(this._assessmentRepository);
  @override
  Future<DataState<List<AssessmentEntity>>> call({params}) {
    return _assessmentRepository.getSavedAssessments();
  }
}
