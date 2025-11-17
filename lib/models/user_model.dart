import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String name,
    required int age,
    required String gender,
    required String location,
    String? profilePic,
    @Default(false) bool isOnline,
    required String agoraUid,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? lastSeen,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // Generate random users for testing
  static List<UserModel> generateRandomUsers() {
    return [
      const UserModel(
        id: 'user_001',
        name: 'Saratchandra',
        age: 28,
        gender: 'male',
        location: 'Hyderabad',
        isOnline: false,
        agoraUid: 'agora_1001',
      ),
      const UserModel(
        id: 'user_002',
        name: 'Pavan',
        age: 26,
        gender: 'male',
        location: 'Vijayawada',
        isOnline: false,
        agoraUid: 'agora_1002',
      ),
      const UserModel(
        id: 'user_003',
        name: 'Hanish',
        age: 25,
        gender: 'male',
        location: 'Guntur',
        isOnline: false,
        agoraUid: 'agora_1003',
      ),
      const UserModel(
        id: 'user_004',
        name: 'Harika',
        age: 24,
        gender: 'female',
        location: 'Eluru',
        isOnline: false,
        agoraUid: 'agora_1004',
      ),
      const UserModel(
        id: 'user_005',
        name: 'Pavani',
        age: 23,
        gender: 'female',
        location: 'Ongole',
        isOnline: false,
        agoraUid: 'agora_1005',
      ),
      const UserModel(
        id: 'user_006',
        name: 'Santhi',
        age: 27,
        gender: 'female',
        location: 'Hyderabad',
        isOnline: false,
        agoraUid: 'agora_1006',
      ),
      const UserModel(
        id: 'user_007',
        name: 'Charan',
        age: 29,
        gender: 'male',
        location: 'Vijayawada',
        isOnline: false,
        agoraUid: 'agora_1007',
      ),
      const UserModel(
        id: 'user_008',
        name: 'Chandrika',
        age: 25,
        gender: 'female',
        location: 'Guntur',
        isOnline: false,
        agoraUid: 'agora_1008',
      ),
    ];
  }
}
