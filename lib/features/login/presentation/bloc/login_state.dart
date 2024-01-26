import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  final String? error;
  const LoginState({this.error});
  @override
  List<Object> get props => [error!];
}

class LoginInitialState extends LoginState {
  const LoginInitialState();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  const LoginSuccess();
}

class LoginError extends LoginState {
  const LoginError(String error) : super(error: error);
}
