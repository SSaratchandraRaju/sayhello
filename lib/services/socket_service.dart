// Deprecated: SocketService removed in favor of AgoraService.
// This file no longer contains any runtime logic. If any part of the
// codebase still imports SocketService, please update it to use
// `lib/services/agora_service.dart` instead.

// Keep a minimal exported symbol to avoid breaking imports during migration.
class SocketService {
  SocketService._();
  static SocketService get instance => SocketService._();
  @override
  String toString() => 'SocketService(deprecated)';
}
