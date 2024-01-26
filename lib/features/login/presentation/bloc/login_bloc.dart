import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:synapsis_mobile_engineer_challenge/core/dto/params.dart';
import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/domain/usecase/login.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/presentation/bloc/login_event.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(const LoginInitialState()) {
    on<LoginEvent>((event, emit) {});
    on<LoginInitialize>((event, emit) {});
    on<SubmitLogin>(onSubmitLogin);
  }

  void onSubmitLogin(SubmitLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    final loginParams = LoginParams(
        email: event.email, password: event.password, isSaved: event.isSaved);
    final dataState = await _loginUseCase(params: loginParams);

    if (dataState is DataSuccess) {
      emit(LoginSuccess());
    }

    if (dataState is DataFailed) {
      emit(LoginError(dataState.error!));
    }
  }
}
