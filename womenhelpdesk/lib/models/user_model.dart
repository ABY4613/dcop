class UserModel {
  final String uid;
  final String name;
  final String phone;
  final String role; // 'woman', 'guardian', 'police'
  final String? fcmToken;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.role,
    this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'role': role,
      'fcmToken': fcmToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? 'woman',
      fcmToken: map['fcmToken'],
    );
  }
}
