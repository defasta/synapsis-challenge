import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';

abstract class LoginRepository {
  Future<DataState<dynamic>> login(String email, String password, bool isSaved);
}
