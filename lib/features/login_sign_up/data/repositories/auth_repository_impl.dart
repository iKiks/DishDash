import 'package:dishdash/core/common/entities/user.dart';
import 'package:dishdash/core/utils/app_logger.dart';
import 'package:dishdash/features/login_sign_up/data/datasources/remote_datasource.dart';
import 'package:dishdash/features/login_sign_up/domain/repositories/auth_repository.dart';

const _logName = 'DishDash.AuthRepository';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required RemoteDatasource remoteDatasource})
    : _remoteDatasource = remoteDatasource;

  final RemoteDatasource _remoteDatasource;

  @override
  Future<String> login({required String email, required String password}) {
    final userEmail = email;
    AppLogger.d(
      '[AuthRepositoryImpl.login] Forwarding login for $userEmail',
      name: _logName,
    );
    return _remoteDatasource.login(email, password);
  }

  @override
  Future<void> signUp({required User user, required String password}) {
    final userEmail = user.email;
    AppLogger.d(
      '[AuthRepositoryImpl.signUp] Forwarding sign up for $userEmail',
      name: _logName,
    );
    return _remoteDatasource.signUp(user, password);
  }
}
