import 'dart:convert';

import 'package:dishdash/core/common/entities/user.dart';
import 'package:dishdash/core/network/api_client.dart';
import 'package:dishdash/core/utils/app_logger.dart';
import 'package:dishdash/features/login_sign_up/data/models/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _accessTokenStorageKey = 'accessToken';
const _logName = 'DishDash.RemoteDatasource';

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
    AppLogger.d(
      '[RemoteDatasourceImpl.login] Initiating login for $email',
      name: _logName,
    );

    final response = await () async {
      try {
        final result = await _apiClient.post<dynamic>(
          '/login',
          data: {'email': email, 'password': password},
        );
        AppLogger.d(
          '[RemoteDatasourceImpl.login] Response received for $email',
          name: _logName,
        );
        return result;
      } on Object catch (error, stackTrace) {
        AppLogger.e(
          '[RemoteDatasourceImpl.login] Request failed for $email',
          name: _logName,
          error: error,
          stackTrace: stackTrace,
        );
        rethrow;
      }
    }();

    final responseData = _normalizeResponseData(response.data);

    final token =
        responseData['accessToken']?.toString() ??
        responseData['token']?.toString();

    if (token == null || token.isEmpty) {
      AppLogger.w(
        '[RemoteDatasourceImpl.login] Missing access token for $email',
        name: _logName,
      );
      throw Exception('Login failed: Missing access token');
    }

    await _secureStorage.write(key: _accessTokenStorageKey, value: token);
    AppLogger.d(
      '[RemoteDatasourceImpl.login] Stored access token for $email',
      name: _logName,
    );
    return token;
  }

  @override
  Future<void> signUp(User user, String password) async {
    AppLogger.d(
      '[RemoteDatasourceImpl.signUp] Preparing payload for ${user.email}',
      name: _logName,
    );
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

    final response = await () async {
      try {
        final result = await _apiClient.post<dynamic>('/register', data: payload);
        AppLogger.d(
          '[RemoteDatasourceImpl.signUp] Response received for ${user.email}',
          name: _logName,
        );
        return result;
      } on Object catch (error, stackTrace) {
        AppLogger.e(
          '[RemoteDatasourceImpl.signUp] Request failed for ${user.email}',
          name: _logName,
          error: error,
          stackTrace: stackTrace,
        );
        rethrow;
      }
    }();

    final responseData = _normalizeResponseData(response.data);
    final statusCode = response.statusCode ?? 0;
    final successFlag = responseData['success'];

    if (statusCode < 200 || statusCode >= 300) {
      final message = responseData['message'] ?? 'Unknown error';
      AppLogger.w(
        '[RemoteDatasourceImpl.signUp] Non-success status $statusCode for ${user.email}: $message',
        name: _logName,
      );
      throw Exception('Sign up failed: $message');
    }

    if (successFlag is bool && !successFlag) {
      final message = responseData['message'] ?? 'Unknown error';
      AppLogger.w(
        '[RemoteDatasourceImpl.signUp] Sign up reported failure for ${user.email}: $message',
        name: _logName,
      );
      throw Exception('Sign up failed: $message');
    }

    final accessToken =
        responseData['accessToken']?.toString() ??
        responseData['token']?.toString();
    if (accessToken != null && accessToken.isNotEmpty) {
      await _secureStorage.write(key: _accessTokenStorageKey, value: accessToken);
      AppLogger.d(
        '[RemoteDatasourceImpl.signUp] Stored access token for ${user.email}',
        name: _logName,
      );
    }

    AppLogger.d(
      '[RemoteDatasourceImpl.signUp] Sign up completed for ${user.email}',
      name: _logName,
    );
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
    } catch (error, stackTrace) {
      AppLogger.w(
        '[RemoteDatasourceImpl] Failed to decode string response',
        name: _logName,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return <String, dynamic>{'token': data};
  }

  return <String, dynamic>{};
}
