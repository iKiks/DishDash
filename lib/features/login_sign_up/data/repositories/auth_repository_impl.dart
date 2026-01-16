import 'package:dishdash/core/common/entities/user.dart';
import 'package:dishdash/features/login_sign_up/data/datasources/remote_datasource.dart';
import 'package:dishdash/features/login_sign_up/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required RemoteDatasource remoteDatasource})
    : _remoteDatasource = remoteDatasource;

  final RemoteDatasource _remoteDatasource;

  @override
  Future<String> login({required String email, required String password}) {
    return _remoteDatasource.login(email, password);
  }

  @override
  Future<void> signUp({required User user, required String password}) {
    return _remoteDatasource.signUp(user, password);
  }
}
