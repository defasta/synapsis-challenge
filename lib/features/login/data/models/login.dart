import 'package:synapsis_mobile_engineer_challenge/features/login/domain/entities/login.dart';

class LoginModel extends LoginEntity {
  const LoginModel({String? userId, String? name, String? email})
      : super(userId: userId, name: name, email: email);

  factory LoginModel.fromJson(Map<String, dynamic> map) {
    return LoginModel(
      userId: map['user_id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
    );
  }
}
