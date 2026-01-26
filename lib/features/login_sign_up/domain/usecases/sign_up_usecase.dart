import 'package:dishdash/core/common/entities/user.dart';
import 'package:dishdash/core/common/usecases/usecase.dart';
import 'package:dishdash/core/utils/app_logger.dart';
import 'package:dishdash/features/login_sign_up/domain/repositories/auth_repository.dart';

class SignUpParams {
  const SignUpParams({required this.user, required this.password});

  final User user;
  final String password;
}

class SignUpUseCase extends UseCase<void, SignUpParams> {
  SignUpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<void> call(SignUpParams params) {
    final user = params.user;
    AppLogger.d('[SignUpUseCase] Executing for ${user.email}');
    return _repository.signUp(user: user, password: params.password);
  }
}
