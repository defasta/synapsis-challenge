abstract class LoginEvent {
  const LoginEvent();

  List<Object> get props => [];
}

class LoginInitialize extends LoginEvent {}

class SubmitLogin extends LoginEvent {
  final String email;
  final String password;
  final bool isSaved;

  const SubmitLogin(this.email, this.password, this.isSaved);

  List<Object> get props => [email, password, isSaved];
}
