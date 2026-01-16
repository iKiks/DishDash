import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  ApiClient({
    required String baseUrl,
    Map<String, Object?>? defaultHeaders,
    Duration connectTimeout = const Duration(seconds: 10),
    Duration receiveTimeout = const Duration(seconds: 30),
    bool enableLogging = false,
  }) : _dio = Dio(
         BaseOptions(
           baseUrl: baseUrl,
           connectTimeout: connectTimeout,
           receiveTimeout: receiveTimeout,
           headers: defaultHeaders,
           responseType: ResponseType.json,
           contentType: Headers.jsonContentType,
         ),
       ) {
    // Add interceptor for adding access token
    _dio.interceptors.add(_AuthInterceptor());
    if (enableLogging) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  final Dio _dio;
  final _secureStorage = const FlutterSecureStorage();

  Dio get dio => _dio;

  /// Save access token to secure storage
  Future<void> setAuthToken(String token) async {
    await _secureStorage.write(key: 'accessToken', value: token);
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Clear access token
  Future<void> clearAuthToken() async {
    await _secureStorage.delete(key: 'accessToken');
    _dio.options.headers.remove('Authorization');
  }

  void setHeader(String key, Object? value) {
    if (value == null) {
      _dio.options.headers.remove(key);
    } else {
      _dio.options.headers[key] = value;
    }
  }

  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  // Generic request helpers
  Future<Response<T>> get<T>(
    String path, {
    Map<String, Object?>? queryParameters,
    Options? options,
  }) => _dio.get(path, queryParameters: queryParameters, options: options);

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, Object?>? queryParameters,
    Options? options,
  }) => _dio.post(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<Response<T>> put<T>(
    String path, {
    Object? data,
    Map<String, Object?>? queryParameters,
    Options? options,
  }) => _dio.put(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, Object?>? queryParameters,
    Options? options,
  }) => _dio.patch(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, Object?>? queryParameters,
    Options? options,
  }) => _dio.delete(
    path,
    data: data,
    queryParameters: queryParameters,
    options: options,
  );
}

// Simple Auth Interceptor: just adds access token
class _AuthInterceptor extends Interceptor {
  final _secureStorage = const FlutterSecureStorage();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.read(key: 'accessToken');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  // No refresh logic needed
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }
}
