import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/entities/assessment.dart';

abstract class AssessmentRepository {
  Future<DataState<List<AssessmentEntity>>> getAssessments(String pageKey);
  Future<DataState<List<AssessmentEntity>>> getSavedAssessments();
}
