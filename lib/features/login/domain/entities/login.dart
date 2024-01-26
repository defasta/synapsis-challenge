import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String? userId;
  final String? name;
  final String? email;

  const LoginEntity({this.userId, this.name, this.email});

  @override
  List<Object?> get props {
    return [userId, name, email];
  }
}
