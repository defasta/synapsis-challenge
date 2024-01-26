import 'package:synapsis_mobile_engineer_challenge/core/exceptions/failure.dart';
import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/data/data_sources/remote/login_data_source.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource _loginDataSource;
  LoginRepositoryImpl(this._loginDataSource);

  @override
  Future<DataState<dynamic>> login(
      String email, String password, bool isSaved) async {
    try {
      final result = await _loginDataSource.login(
          email: email, password: password, isSaved: isSaved);
      print('data try login repo tereksekusi');
      return DataSuccess(result);
    } on ServerFailure catch (e) {
      print('data catch login repo tereksekusi ${e.errorMessage}');
      return DataFailed(e.errorMessage);
    }
  }
}
