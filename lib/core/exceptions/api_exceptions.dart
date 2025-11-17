/// Base API Exception class
class ApiException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;
  final dynamic data;

  ApiException({required this.message, this.code, this.statusCode, this.data});

  @override
  String toString() => message;
}

/// Network Exception - connection errors, timeouts, etc.
class NetworkException extends ApiException {
  NetworkException({required super.message, super.code = 'NETWORK_ERROR'});
}

/// Unauthorized Exception - 401 errors
class UnauthorizedException extends ApiException {
  UnauthorizedException({
    String message = 'Unauthorized access',
    super.code = 'UNAUTHORIZED',
  }) : super(message: message, statusCode: 401);
}

/// Forbidden Exception - 403 errors
class ForbiddenException extends ApiException {
  ForbiddenException({
    String message = 'Access forbidden',
    super.code = 'FORBIDDEN',
  }) : super(message: message, statusCode: 403);
}

/// Not Found Exception - 404 errors
class NotFoundException extends ApiException {
  NotFoundException({
    String message = 'Resource not found',
    super.code = 'NOT_FOUND',
  }) : super(message: message, statusCode: 404);
}

/// Server Exception - 500+ errors
class ServerException extends ApiException {
  ServerException({
    String message = 'Server error occurred',
    super.code = 'SERVER_ERROR',
    super.statusCode = 500,
  }) : super(message: message);
}

/// Validation Exception - 422 errors
class ValidationException extends ApiException {
  ValidationException({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    super.data,
  }) : super(statusCode: 422);
}

/// Timeout Exception
class TimeoutException extends ApiException {
  TimeoutException({String message = 'Request timeout', super.code = 'TIMEOUT'})
    : super(message: message);
}

/// Insufficient Credits Exception
class InsufficientCreditsException extends ApiException {
  InsufficientCreditsException({
    String message = 'Insufficient credits',
    super.code = 'INSUFFICIENT_CREDITS',
  }) : super(message: message);
}

/// Session Expired Exception
class SessionExpiredException extends ApiException {
  SessionExpiredException({
    String message = 'Session expired, please login again',
    super.code = 'SESSION_EXPIRED',
  }) : super(message: message, statusCode: 401);
}

/// Parse Exception - JSON parsing errors
class ParseException extends ApiException {
  ParseException({
    String message = 'Failed to parse response',
    super.code = 'PARSE_ERROR',
  }) : super(message: message);
}

/// Cache Exception
class CacheException implements Exception {
  final String message;

  CacheException(this.message);

  @override
  String toString() => message;
}
