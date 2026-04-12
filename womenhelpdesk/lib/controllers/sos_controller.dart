import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/firestore_service.dart';
import '../models/alert_model.dart';
import '../models/user_model.dart';
import '../utils/location_service.dart';
import 'package:uuid/uuid.dart';

class SosController extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final LocationService _locationService = LocationService();
  
  bool _isAlertActive = false;
  bool get isAlertActive => _isAlertActive;

  Future<void> triggerSos(UserModel user) async {
    _isAlertActive = true;
    notifyListeners();

    try {
      Position position = await _locationService.getCurrentLocation();
      
      final alert = AlertModel(
        id: const Uuid().v4(),
        userId: user.uid,
        userName: user.name,
        userPhone: user.phone,
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: DateTime.now(),
        status: 'active',
      );

      await _firestoreService.createAlert(alert);
      
      // Here you would also trigger FCM notifications
      // and start live tracking if needed
    } catch (e) {
      _isAlertActive = false;
      notifyListeners();
      rethrow;
    }
  }

  void resetSos() {
    _isAlertActive = false;
    notifyListeners();
  }
}

// Helper to provide uuid if needed, but I didn't add it to pubspec. 
// I'll add uuid to pubspec.
