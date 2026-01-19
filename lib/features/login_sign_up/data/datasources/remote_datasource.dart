import 'dart:convert';

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
    final response = await _apiClient
        .post<dynamic>(
          '/login',
          data: {'email': email, 'password': password},
        )
        .then((value) {
          print('[RemoteDatasourceImpl.login] Response received for $email');
          return value;
        })
        .catchError((error) {
          print(
            '[RemoteDatasourceImpl.login] Request failed for $email: $error',
          );
          throw error;
        });

    final responseData = _normalizeResponseData(response.data);

    final token =
        responseData['accessToken']?.toString() ??
        responseData['token']?.toString();

    if (token == null || token.isEmpty) {
      print('[RemoteDatasourceImpl.login] Missing access token for $email');
      throw Exception('Login failed: Missing access token');
    }

    await _secureStorage.write(key: 'accessToken', value: token);
    print('[RemoteDatasourceImpl.login] Stored access token for $email');
    return token;
  }

  @override
  Future<void> signUp(User user, String password) async {
    print('[RemoteDatasourceImpl.signUp] Preparing payload for ${user.email}');
    final userModel = UserModel.fromEntity(user);
    final payload = <String, dynamic>{
      'fullName': userModel.name,
      'email': userModel.email,
      'password': password,
      if (userModel.phoneNumber != null && userModel.phoneNumber!.isNotEmpty)
        'phoneNumber': userModel.phoneNumber,
      if (userModel.dateOfBirth != null)
        'dateOfBirth': userModel.dateOfBirth!.toIso8601String(),
    };

    final response = await _apiClient
        .post<dynamic>('/register', data: payload)
        .then((value) {
          print(
            '[RemoteDatasourceImpl.signUp] Response received for ${user.email}',
          );
          return value;
        })
        .catchError((error) {
          print(
            '[RemoteDatasourceImpl.signUp] Request failed for ${user.email}: $error',
          );
          throw error;
        });

    final responseData = _normalizeResponseData(response.data);
    final statusCode = response.statusCode ?? 0;
    final successFlag = responseData['success'];

    if (statusCode < 200 || statusCode >= 300) {
      final message = responseData['message'] ?? 'Unknown error';
      print(
        '[RemoteDatasourceImpl.signUp] Non-success status $statusCode for ${user.email}: $message',
      );
      throw Exception('Sign up failed: $message');
    }

    if (successFlag is bool && !successFlag) {
      final message = responseData['message'] ?? 'Unknown error';
      print(
        '[RemoteDatasourceImpl.signUp] Sign up reported failure for ${user.email}: $message',
      );
      throw Exception('Sign up failed: $message');
    }

    final accessToken =
        responseData['accessToken']?.toString() ??
        responseData['token']?.toString();
    if (accessToken != null && accessToken.isNotEmpty) {
      await _secureStorage.write(key: 'accessToken', value: accessToken);
      print(
        '[RemoteDatasourceImpl.signUp] Stored access token for ${user.email}',
      );
    }

    print('[RemoteDatasourceImpl.signUp] Sign up completed for ${user.email}');
  }
}

Map<String, dynamic> _normalizeResponseData(dynamic data) {
  if (data is Map<String, dynamic>) {
    return data;
  }

  if (data is String && data.isNotEmpty) {
    try {
      final decoded = json.decode(data);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } catch (error) {
      print('[RemoteDatasourceImpl] Failed to decode string response: $error');
    }

    return <String, dynamic>{'token': data};
  }

  return <String, dynamic>{};
}
