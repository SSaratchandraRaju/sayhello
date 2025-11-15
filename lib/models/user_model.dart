class UserModel {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String location;
  final String? profilePic;
  final bool isOnline;
  final String agoraUid;

  UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.location,
    this.profilePic,
    required this.isOnline,
    required this.agoraUid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      location: json['location'] as String,
      profilePic: json['profilePic'] as String?,
      isOnline: json['isOnline'] as bool? ?? false,
      agoraUid: json['agoraUid'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'gender': gender,
      'location': location,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'agoraUid': agoraUid,
    };
  }

  // Generate random users for testing
  static List<UserModel> generateRandomUsers() {
    return [
      UserModel(
        id: 'user_001',
        name: 'Saratchandra',
        age: 28,
        gender: 'male',
        location: 'Hyderabad',
        isOnline: false, // Will be set dynamically based on who selected this user
        agoraUid: 'agora_1001',
      ),
      UserModel(
        id: 'user_002',
        name: 'Pavan',
        age: 26,
        gender: 'male',
        location: 'Vijayawada',
        isOnline: false,
        agoraUid: 'agora_1002',
      ),
      UserModel(
        id: 'user_003',
        name: 'Hanish',
        age: 25,
        gender: 'male',
        location: 'Guntur',
        isOnline: false,
        agoraUid: 'agora_1003',
      ),
      UserModel(
        id: 'user_004',
        name: 'Harika',
        age: 24,
        gender: 'female',
        location: 'Eluru',
        isOnline: false,
        agoraUid: 'agora_1004',
      ),
      UserModel(
        id: 'user_005',
        name: 'Pavani',
        age: 23,
        gender: 'female',
        location: 'Ongole',
        isOnline: false,
        agoraUid: 'agora_1005',
      ),
      UserModel(
        id: 'user_006',
        name: 'Santhi',
        age: 27,
        gender: 'female',
        location: 'Hyderabad',
        isOnline: false,
        agoraUid: 'agora_1006',
      ),
      UserModel(
        id: 'user_007',
        name: 'Charan',
        age: 29,
        gender: 'male',
        location: 'Vijayawada',
        isOnline: false,
        agoraUid: 'agora_1007',
      ),
      UserModel(
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

  // Create a copy with updated fields
  UserModel copyWith({
    String? id,
    String? name,
    int? age,
    String? gender,
    String? location,
    String? profilePic,
    bool? isOnline,
    String? agoraUid,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      profilePic: profilePic ?? this.profilePic,
      isOnline: isOnline ?? this.isOnline,
      agoraUid: agoraUid ?? this.agoraUid,
    );
  }
}
