import 'package:synapsis_mobile_engineer_challenge/core/exceptions/failure.dart';
import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/data/data_sources/remote/assessment_data_source.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/data/models/assessment.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/repositories/assessment_repository.dart';

class AssessmentRepositoryImpl implements AssessmentRepository {
  final AssessmentDataSource _assessmentDataSource;
  AssessmentRepositoryImpl(this._assessmentDataSource);

  @override
  Future<DataState<List<AssessmentModel>>> getAssessments(
      String pageKey) async {
    try {
      final result = await _assessmentDataSource.getAssessments(page: pageKey);
      List<AssessmentModel> value = result.data!['data']
          .map<AssessmentModel>((dynamic i) =>
              AssessmentModel.fromJson(i as Map<String, dynamic>))
          .toList();
      return DataSuccess(value);
    } on ServerFailure catch (e) {
      return DataFailed(e.errorMessage);
    }
  }
}
