import 'package:dishdash/core/common/entities/user.dart';
import 'package:dishdash/core/network/api_client.dart';
import 'package:dishdash/features/login_sign_up/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class RemoteDatasource {
  Future<String> login(String email, String password);
  Future<void> signUp(User user, String password);
}

class RemoteDatasourceImpl implements RemoteDatasource {
  final ApiClient _apiClient;
  final _secureStorage = const FlutterSecureStorage();

  RemoteDatasourceImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<String> login(String email, String password) async {
    // Implement your remote login logic here
    // For example, make an HTTP request to your backend
    // and return the authentication token
    final loginResponse = await _apiClient
        .post<Map<String, dynamic>>(
          '/login',
          data: {'email': email, 'password': password},
        )
        .then((response) => response.data!);

    await _secureStorage.write(
      key: 'accessToken',
      value: loginResponse['accessToken'],
    );
    return loginResponse['accessToken'];
  }

  @override
  Future<void> signUp(User user, String password) async {
    final userModel = UserModel.fromEntity(user);
    final payload = <String, dynamic>{
      'name': userModel.name,
      'email': userModel.email,
      'password': password,
      if (userModel.phoneNumber != null && userModel.phoneNumber!.isNotEmpty)
        'phoneNumber': userModel.phoneNumber,
      if (userModel.dateOfBirth != null)
        'dateOfBirth': userModel.dateOfBirth!.toIso8601String(),
    };

    final response = await _apiClient
        .post<Map<String, dynamic>>('/signup', data: payload)
        .then((value) => value.data ?? <String, dynamic>{});
    if (response['success'] != true) {
      throw Exception(
        'Sign up failed: ${response['message'] ?? 'Unknown error'}',
      );
    }
  }
}
