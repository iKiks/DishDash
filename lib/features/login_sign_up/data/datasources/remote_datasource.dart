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
    print('[RemoteDatasourceImpl.login] Initiating login for $email');
    final loginResponse = await _apiClient
        .post<Map<String, dynamic>>(
          '/login',
          data: {'email': email, 'password': password},
        )
        .then((response) {
      print('[RemoteDatasourceImpl.login] Response received for $email');
      return response.data!;
    }).catchError((error) {
      print('[RemoteDatasourceImpl.login] Request failed for $email: $error');
      throw error;
    });

    await _secureStorage.write(
      key: 'accessToken',
      value: loginResponse['accessToken'],
    );
    print('[RemoteDatasourceImpl.login] Stored access token for $email');
    return loginResponse['accessToken'];
  }

  @override
  Future<void> signUp(User user, String password) async {
    print('[RemoteDatasourceImpl.signUp] Preparing payload for ${user.email}');
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
        .then((value) {
      print('[RemoteDatasourceImpl.signUp] Response received for ${user.email}');
      return value.data ?? <String, dynamic>{};
    }).catchError((error) {
      print('[RemoteDatasourceImpl.signUp] Request failed for ${user.email}: $error');
      throw error;
    });
    if (response['success'] != true) {
      print('[RemoteDatasourceImpl.signUp] Sign up reported failure for ${user.email}: ${response['message']}');
      throw Exception(
        'Sign up failed: ${response['message'] ?? 'Unknown error'}',
      );
    }
    print('[RemoteDatasourceImpl.signUp] Sign up completed for ${user.email}');
  }
}
