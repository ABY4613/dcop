class GuardianModel {
  final String id;
  final String userId; // Woman's UID
  final String guardianName;
  final String guardianPhone;
  final String relation;
  final String assignedId;
  final String assignedPassword;

  GuardianModel({
    required this.id,
    required this.userId,
    required this.guardianName,
    required this.guardianPhone,
    required this.relation,
    required this.assignedId,
    required this.assignedPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'guardianName': guardianName,
      'guardianPhone': guardianPhone,
      'relation': relation,
      'assignedId': assignedId,
      'assignedPassword': assignedPassword,
    };
  }

  factory GuardianModel.fromMap(Map<String, dynamic> map) {
    return GuardianModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      guardianName: map['guardianName'] ?? '',
      guardianPhone: map['guardianPhone'] ?? '',
      relation: map['relation'] ?? 'Friend',
      assignedId: map['assignedId'] ?? '',
      assignedPassword: map['assignedPassword'] ?? '',
    );
  }
}

