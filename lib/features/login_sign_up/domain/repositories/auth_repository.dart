import 'package:dishdash/core/common/entities/user.dart';

abstract interface class AuthRepository {
  Future<String> login({required String email, required String password});

  Future<void> signUp({required User user, required String password});
}
