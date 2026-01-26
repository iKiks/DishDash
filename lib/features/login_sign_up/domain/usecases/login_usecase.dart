import 'package:dishdash/core/common/usecases/usecase.dart';
import 'package:dishdash/core/utils/app_logger.dart';
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
    final email = params.email;
    AppLogger.d('[LoginUseCase] Executing with email $email');
    return _repository.login(email: email, password: params.password);
  }
}
