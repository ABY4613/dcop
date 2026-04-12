import 'package:cloud_firestore/cloud_firestore.dart';

class AlertModel {
  final String id;
  final String userId;
  final String userName;
  final String userPhone;
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final String status; // 'active', 'resolved'

  AlertModel({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userPhone,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'userPhone': userPhone,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp,
      'status': status,
    };
  }

  factory AlertModel.fromMap(Map<String, dynamic> map) {
    return AlertModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      userPhone: map['userPhone'] ?? '',
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      status: map['status'] ?? 'active',
    );
  }
}
