import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/environment_config.dart';
import '../exceptions/api_exceptions.dart';

/// Core API Client using Dio
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  late final Dio _dio;
  late final Logger _logger;

  String? _accessToken;
  String? _refreshToken;

  /// Initialize the API client
  Future<void> init() async {
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 5,
        lineLength: 50,
        colors: true,
        printEmojis: true,
      ),
    );

    _dio = Dio(
      BaseOptions(
        baseUrl: EnvironmentConfig.apiUrl,
        connectTimeout: Duration(seconds: EnvironmentConfig.apiTimeout),
        receiveTimeout: Duration(seconds: EnvironmentConfig.apiTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    _dio.interceptors.add(_AuthInterceptor(this));

    if (EnvironmentConfig.isDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
    }

    _dio.interceptors.add(_ErrorInterceptor(_logger));

    // Load tokens from storage
    await loadTokens();
  }

  /// Get Dio instance
  Dio get dio => _dio;

  /// Set authentication tokens
  Future<void> setTokens(String accessToken, String refreshToken) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);

    _logger.d('Tokens saved successfully');
  }

  /// Load tokens from storage
  Future<void> loadTokens() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token');
    _refreshToken = prefs.getString('refresh_token');

    if (_accessToken != null) {
      _logger.d('Tokens loaded from storage');
    }
  }

  /// Clear authentication tokens
  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');

    _logger.d('Tokens cleared');
  }

  /// Get current access token
  String? get accessToken => _accessToken;

  /// Get current refresh token
  String? get refreshToken => _refreshToken;

  /// Check if user is authenticated
  bool get isAuthenticated => _accessToken != null;

  /// Refresh access token
  Future<void> refreshAccessToken() async {
    if (_refreshToken == null) {
      throw SessionExpiredException();
    }

    try {
      final response = await _dio.post(
        '/auth/refresh-token',
        data: {'refreshToken': _refreshToken},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        await setTokens(
          response.data['token'] as String,
          response.data['refreshToken'] as String,
        );
      } else {
        throw SessionExpiredException();
      }
    } catch (e) {
      await clearTokens();
      throw SessionExpiredException();
    }
  }

  /// GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// POST request
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// PUT request
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// PATCH request
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE request
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      rethrow;
    }
  }
}

/// Authentication Interceptor
class _AuthInterceptor extends Interceptor {
  final ApiClient _apiClient;

  _AuthInterceptor(this._apiClient);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Add auth token to requests if available
    if (_apiClient._accessToken != null) {
      options.headers['Authorization'] = 'Bearer ${_apiClient._accessToken}';
    }
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401 Unauthorized - try to refresh token
    if (err.response?.statusCode == 401) {
      try {
        await _apiClient.refreshAccessToken();

        // Retry the original request
        final opts = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );
        final response = await _apiClient.dio.request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(response);
      } catch (e) {
        return handler.reject(err);
      }
    }

    super.onError(err, handler);
  }
}

/// Error Handling Interceptor
class _ErrorInterceptor extends Interceptor {
  final Logger _logger;

  _ErrorInterceptor(this._logger);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _handleDioError(err);
    _logger.e('API Error: ${exception.message}', error: err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        response: err.response,
      ),
    );
  }

  ApiException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          message: 'Connection timeout. Please check your internet connection.',
        );

      case DioExceptionType.badResponse:
        return _handleHttpError(error.response);

      case DioExceptionType.cancel:
        return ApiException(
          message: 'Request cancelled',
          code: 'REQUEST_CANCELLED',
        );

      case DioExceptionType.connectionError:
        return NetworkException(
          message: 'No internet connection. Please check your network.',
        );

      case DioExceptionType.badCertificate:
        return ApiException(
          message: 'Certificate verification failed',
          code: 'CERTIFICATE_ERROR',
        );

      case DioExceptionType.unknown:
        return NetworkException(
          message: 'An unexpected error occurred: ${error.message}',
        );
    }
  }

  ApiException _handleHttpError(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;

    String message = 'An error occurred';
    String? code;

    if (data is Map<String, dynamic>) {
      message = data['message'] ?? message;
      code = data['error'] ?? data['code'];
    }

    switch (statusCode) {
      case 400:
        return ApiException(
          message: message,
          code: code ?? 'BAD_REQUEST',
          statusCode: 400,
          data: data,
        );

      case 401:
        return UnauthorizedException(message: message);

      case 403:
        return ForbiddenException(message: message);

      case 404:
        return NotFoundException(message: message);

      case 422:
        return ValidationException(message: message, code: code, data: data);

      case 402:
        // Payment required - insufficient credits
        return InsufficientCreditsException(message: message);

      case 500:
      case 501:
      case 502:
      case 503:
        return ServerException(message: message, statusCode: statusCode);

      default:
        return ApiException(
          message: message,
          code: code ?? 'UNKNOWN_ERROR',
          statusCode: statusCode,
          data: data,
        );
    }
  }
}
