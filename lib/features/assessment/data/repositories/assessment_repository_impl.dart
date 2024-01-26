import 'package:synapsis_mobile_engineer_challenge/core/exceptions/failure.dart';
import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/data/data_sources/local/db_helper.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/data/data_sources/remote/assessment_data_source.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/data/models/assessment.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/entities/assessment.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/repositories/assessment_repository.dart';

class AssessmentRepositoryImpl implements AssessmentRepository {
  final AssessmentDataSource _assessmentDataSource;
  AssessmentRepositoryImpl(this._assessmentDataSource);

  @override
  Future<DataState<List<AssessmentModel>>> getAssessments(
      String pageKey) async {
    final dbHelper = DbHelper.instance;

    try {
      final result = await _assessmentDataSource.getAssessments(page: pageKey);
      List<AssessmentModel> value = result.data!['data']
          .map<AssessmentModel>((dynamic i) =>
              AssessmentModel.fromJson(i as Map<String, dynamic>))
          .toList();
      for (final assessment in value) {
        dbHelper.insert(assessment.toMap());
      }
      return DataSuccess(value);
    } on ServerFailure catch (e) {
      return DataFailed(e.errorMessage);
    }
  }

  @override
  Future<DataState<List<AssessmentEntity>>> getSavedAssessments() async {
    final dbHelper = DbHelper.instance;
    final savedAssessmentFromDB = await dbHelper.queryAllRows();
    List<AssessmentModel> savedAssessment = savedAssessmentFromDB!
        .map<AssessmentModel>(
            (dynamic i) => AssessmentModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return DataSuccess(savedAssessment.toList());
  }
}
