import '../../core/network/api_client.dart';
import '../../models/user_model.dart';

/// User Repository
class UserRepository {
  final ApiClient _apiClient;

  UserRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  /// Get current user profile
  Future<UserModel> getProfile() async {
    try {
      final response = await _apiClient.get('/users/me');
      return UserModel.fromJson(response.data['user'] as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Get online users
  Future<List<UserModel>> getOnlineUsers({
    String? gender,
    int? minAge,
    int? maxAge,
    String? location,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (gender != null) queryParams['gender'] = gender;
      if (minAge != null) queryParams['minAge'] = minAge;
      if (maxAge != null) queryParams['maxAge'] = maxAge;
      if (location != null) queryParams['location'] = location;

      final response = await _apiClient.get(
        '/users/online',
        queryParameters: queryParams,
      );

      final List<dynamic> users = response.data['users'];
      return users
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Update user presence (online/offline)
  Future<void> updatePresence(bool isOnline) async {
    try {
      await _apiClient.put('/users/presence', data: {'isOnline': isOnline});
    } catch (e) {
      rethrow;
    }
  }

  /// Update user profile
  Future<UserModel> updateProfile({
    String? name,
    int? age,
    String? location,
    String? profilePic,
  }) async {
    try {
      final data = <String, dynamic>{};
      if (name != null) data['name'] = name;
      if (age != null) data['age'] = age;
      if (location != null) data['location'] = location;
      if (profilePic != null) data['profilePic'] = profilePic;

      final response = await _apiClient.put('/users/me', data: data);
      return UserModel.fromJson(response.data['user'] as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
