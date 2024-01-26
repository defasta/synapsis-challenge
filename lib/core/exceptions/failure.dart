import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/entities/assessment.dart';

abstract class Failure {
  final String errorMessage;
  final List<AssessmentEntity>? assessment;
  const Failure({required this.errorMessage, this.assessment});
}

class ServerFailure extends Failure {
  ServerFailure({required String errorMessage})
      : super(errorMessage: errorMessage);
}

class NoInternetFailure extends Failure {
  NoInternetFailure(
      {required String errorMessage,
      required List<AssessmentEntity>? assesments})
      : super(errorMessage: errorMessage, assessment: assesments);
}
