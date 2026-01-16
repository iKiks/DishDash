import 'package:dishdash/core/common/usecases/usecase.dart';
import 'package:dishdash/features/login_sign_up/domain/repositories/auth_repository.dart';

class LoginParams {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;
}

class LoginUseCase extends UseCase<String, LoginParams> {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<String> call(LoginParams params) {
    print('[LoginUseCase] Executing with email ${params.email}');
    return _repository.login(email: params.email, password: params.password);
  }
}
