import 'package:equatable/equatable.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/entities/assessment.dart';

abstract class RemoteAsssessmentsState extends Equatable {
  final List<AssessmentEntity>? assessments;
  final String? error;

  const RemoteAsssessmentsState({this.assessments, this.error});

  @override
  List<Object> get props => [assessments ?? [], error ?? ''];
}

class RemoteAssessmentsLoading extends RemoteAsssessmentsState {
  const RemoteAssessmentsLoading();
}

class RemoteAssessmentsDone extends RemoteAsssessmentsState {
  const RemoteAssessmentsDone(List<AssessmentEntity> assessment)
      : super(assessments: assessment);
}

class RemoteAssessmentsError extends RemoteAsssessmentsState {
  const RemoteAssessmentsError(String error) : super(error: error);
}
