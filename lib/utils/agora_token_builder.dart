import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

/// Agora RTC Token Builder (AccessToken2)
/// Generates tokens for Agora Real-Time Communication
/// Based on Agora's AccessToken2 algorithm for new projects
class AgoraTokenBuilder {
  static const String version = '007'; // Will be updated to support both formats
  
  // Privilege types
  static const int kJoinChannel = 1;
  static const int kPublishAudioStream = 2;
  static const int kPublishVideoStream = 3;
  static const int kPublishDataStream = 4;
  
  // Role types
  static const int rolePublisher = 1;
  static const int roleSubscriber = 2;

  /// Generate RTC Token
  /// 
  /// [appId] - Your Agora App ID
  /// [appCertificate] - Your Agora App Certificate
  /// [channelName] - Channel name (can be any string)
  /// [uid] - User ID (use 0 for dynamic assignment, or specific int for fixed UID)
  /// [role] - User role: rolePublisher (1) or roleSubscriber (2)
  /// [privilegeExpiredTs] - Token expiration timestamp (Unix timestamp in seconds)
  static String buildTokenWithUid({
    required String appId,
    required String appCertificate,
    required String channelName,
    required int uid,
    int role = rolePublisher,
    int? privilegeExpiredTs,
  }) {
    return _buildTokenWithAccount(
      appId: appId,
      appCertificate: appCertificate,
      channelName: channelName,
      uid: uid.toString(),
      role: role,
      privilegeExpiredTs: privilegeExpiredTs,
    );
  }

  static String _buildTokenWithAccount({
    required String appId,
    required String appCertificate,
    required String channelName,
    required String uid,
    int role = rolePublisher,
    int? privilegeExpiredTs,
  }) {
    final expireTimestamp = privilegeExpiredTs ?? 
        (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 86400; // Default 24 hours

    final message = _AccessToken(
      appId: appId,
      appCertificate: appCertificate,
      channelName: channelName,
      uid: uid,
    );

    message.addPrivilege(kJoinChannel, expireTimestamp);
    
    if (role == rolePublisher) {
      message.addPrivilege(kPublishAudioStream, expireTimestamp);
      message.addPrivilege(kPublishVideoStream, expireTimestamp);
      message.addPrivilege(kPublishDataStream, expireTimestamp);
    }

    return message.build();
  }
}

class _AccessToken {
  String appId;
  String appCertificate;
  String channelName;
  String uid;
  late Uint8List signature;
  late int crcChannelName;
  late int crcUid;
  late String messageRawContent;
  late int salt;
  late int ts;
  Map<int, int> privileges = {};

  _AccessToken({
    required this.appId,
    required this.appCertificate,
    required this.channelName,
    required this.uid,
  }) {
    salt = Random.secure().nextInt(99999999) + 1;
    ts = DateTime.now().millisecondsSinceEpoch ~/ 1000 + 24 * 3600;
  }

  void addPrivilege(int privilege, int expireTimestamp) {
    privileges[privilege] = expireTimestamp;
  }

  String build() {
    messageRawContent = _packContent();
    signature = _generateSignature(
      appCertificate,
      appId,
      channelName,
      uid,
      messageRawContent,
    );

    crcChannelName = _crc32(utf8.encode(channelName));
    crcUid = _crc32(utf8.encode(uid));

    final content = _packMessage();
    return '${AgoraTokenBuilder.version}$content';
  }

  String _packContent() {
    final buffer = BytesBuilder();
    
    // Pack salt
    buffer.add(_packUint32(salt));
    
    // Pack ts
    buffer.add(_packUint32(ts));
    
    // Pack privileges
    buffer.add(_packMapUint32(privileges));

    return base64.encode(buffer.toBytes());
  }

  String _packMessage() {
    final buffer = BytesBuilder();
    
    // Pack signature
    buffer.add(_packString(base64.encode(signature)));
    
    // Pack crc channel name
    buffer.add(_packUint32(crcChannelName));
    
    // Pack crc uid
    buffer.add(_packUint32(crcUid));
    
    // Pack message raw content
    buffer.add(_packString(messageRawContent));

    return base64.encode(buffer.toBytes()).replaceAll('=', '');
  }

  Uint8List _generateSignature(
    String appCertificate,
    String appId,
    String channelName,
    String uid,
    String message,
  ) {
    final key = utf8.encode(appCertificate);
    final content = utf8.encode('$appId$channelName$uid$message');
    
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(content);
    
    return Uint8List.fromList(digest.bytes);
  }

  Uint8List _packUint16(int value) {
    return Uint8List(2)
      ..buffer.asByteData().setUint16(0, value, Endian.little);
  }

  Uint8List _packUint32(int value) {
    return Uint8List(4)
      ..buffer.asByteData().setUint32(0, value, Endian.little);
  }

  Uint8List _packString(String value) {
    final bytes = utf8.encode(value);
    final buffer = BytesBuilder();
    buffer.add(_packUint16(bytes.length));
    buffer.add(bytes);
    return buffer.toBytes();
  }

  Uint8List _packMapUint32(Map<int, int> map) {
    final buffer = BytesBuilder();
    buffer.add(_packUint16(map.length));
    
    map.forEach((key, value) {
      buffer.add(_packUint16(key));
      buffer.add(_packUint32(value));
    });
    
    return buffer.toBytes();
  }

  int _crc32(List<int> data) {
    const polynomial = 0xEDB88320;
    int crc = 0xFFFFFFFF;

    for (final byte in data) {
      crc ^= byte;
      for (int i = 0; i < 8; i++) {
        if ((crc & 1) != 0) {
          crc = (crc >> 1) ^ polynomial;
        } else {
          crc = crc >> 1;
        }
      }
    }

    return crc ^ 0xFFFFFFFF;
  }
}
