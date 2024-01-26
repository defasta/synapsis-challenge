import 'package:synapsis_mobile_engineer_challenge/core/dto/params.dart';
import 'package:synapsis_mobile_engineer_challenge/core/resources/data_state.dart';
import 'package:synapsis_mobile_engineer_challenge/core/usecases/usecase.dart';
import 'package:synapsis_mobile_engineer_challenge/features/login/domain/repositories/login_repository.dart';

class LoginUseCase implements UseCase<DataState<dynamic>, LoginParams> {
  final LoginRepository _loginRepository;

  LoginUseCase(this._loginRepository);

  @override
  Future<DataState<dynamic>> call({required LoginParams params}) {
    return _loginRepository.login(
        params.email, params.password, params.isSaved);
  }
}
