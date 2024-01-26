import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/data/data_sources/remote/assessment_data_source.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/data/repositories/assessment_repository_impl.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/repositories/assessment_repository.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/usecase/get_assessment.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/domain/usecase/get_saved_assessment.dart';
import 'package:synapsis_mobile_engineer_challenge/features/assessment/presentation/bloc/remote/remote_assessment_bloc.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/data/data_sources/remote/login_data_source.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/data/repositories/login_repository_impl.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/domain/repositories/login_repository.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/domain/usecase/login.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/presentation/bloc/login_bloc.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/data/data_sources/remote/quiz_data_source.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/usecase/finish_quiz.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/domain/usecase/get_queston.dart';
import 'package:synapsis_mobile_engineer_challenge/features/quiz/presentation/bloc/remote/remote_quiz_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<LoginDataSource>(LoginDataSource(sl()));
  sl.registerSingleton<AssessmentDataSource>(AssessmentDataSource(sl()));
  sl.registerSingleton<QuizDataSource>(QuizDataSource(sl()));

  sl.registerSingleton<LoginRepository>(LoginRepositoryImpl(sl()));
  sl.registerSingleton<AssessmentRepository>(AssessmentRepositoryImpl(sl()));
  sl.registerSingleton<QuizRepository>(QuizRepositoryImpl(sl()));

  // Usecases
  sl.registerSingleton<LoginUseCase>(LoginUseCase(sl()));
  sl.registerSingleton<GetAssessmentUseCase>(GetAssessmentUseCase(sl()));
  sl.registerSingleton<GetQuestionUseCase>(GetQuestionUseCase(sl()));
  sl.registerSingleton<FinishQuizUseCase>(FinishQuizUseCase(sl()));
  sl.registerSingleton<GetSavedAssessmentUseCase>(
      GetSavedAssessmentUseCase(sl()));

  // Blocs
  sl.registerFactory<LoginBloc>(() => LoginBloc(sl()));
  sl.registerFactory<RemoteAssessmentsBloc>(
      () => RemoteAssessmentsBloc(sl(), sl()));
  sl.registerFactory<RemoteQuizBloc>(() => RemoteQuizBloc(sl(), sl()));
}
