import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/usecase/get_assessment.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/usecase/get_saved_assessment.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/presentation/bloc/remote/remote_assessment_event.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/presentation/bloc/remote/remote_assessment_state.dart';

class RemoteAssessmentsBloc
    extends Bloc<RemoteAsssessmentsEvent, RemoteAsssessmentsState> {
  final GetAssessmentUseCase _getAssessmentsUseCase;
  final GetSavedAssessmentUseCase _getSavedAssessmentUseCase;

  RemoteAssessmentsBloc(
      this._getAssessmentsUseCase, this._getSavedAssessmentUseCase)
      : super(const RemoteAssessmentsLoading()) {
    on<GetAsssessments>(onGetAssessments);
    on<GetSavedAsssessments>(onGetSavedAssessments);
  }

  void onGetAssessments(
      GetAsssessments event, Emitter<RemoteAsssessmentsState> emit) async {
    final dataState = await _getAssessmentsUseCase(params: event.pageKey);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteAssessmentsDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteAssessmentsError(dataState.error!));
    }
  }

  void onGetSavedAssessments(
      GetSavedAsssessments event, Emitter<RemoteAsssessmentsState> emit) async {
    final dataState = await _getSavedAssessmentUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(LocalAssessmentsDone(dataState.data!));
    }
  }
}
