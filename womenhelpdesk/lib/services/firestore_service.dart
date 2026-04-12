import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/alert_model.dart';
import '../models/guardian_model.dart';
import '../constants/api_constants.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // User Operations
  Future<void> saveUser(UserModel user) async {
    await _db.collection(ApiConstants.userCollection).doc(user.uid).set(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection(ApiConstants.userCollection).doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data()!);
    }
    return null;
  }

  // Guardian Operations
  Future<void> addGuardian(GuardianModel guardian) async {
    await _db.collection(ApiConstants.guardianCollection).add(guardian.toMap());
  }

  Future<GuardianModel?> getGuardianByCredentials(String assignedId, String password) async {
    final snapshot = await _db
        .collection(ApiConstants.guardianCollection)
        .where('assignedId', isEqualTo: assignedId)
        .where('assignedPassword', isEqualTo: password)
        .limit(1)
        .get();
        
    if (snapshot.docs.isNotEmpty) {
      return GuardianModel.fromMap(snapshot.docs.first.data());
    }
    return null;
  }

  Stream<List<GuardianModel>> getGuardians(String userId) {
    return _db
        .collection(ApiConstants.guardianCollection)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => GuardianModel.fromMap(doc.data())).toList());
  }

  Future<void> deleteGuardian(String guardianId) async {
    final snapshot = await _db.collection(ApiConstants.guardianCollection)
        .where('id', isEqualTo: guardianId)
        .get();
    
    for (var doc in snapshot.docs) {
      doc.reference.delete(); // UI updates instantly through stream
    }
  }

  // Alert Operations
  Future<void> createAlert(AlertModel alert) async {
    await _db.collection(ApiConstants.alertCollection).doc(alert.id).set(alert.toMap());
  }

  Stream<List<AlertModel>> getActiveAlerts() {
    return _db
        .collection(ApiConstants.alertCollection)
        .where('status', isEqualTo: 'active')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => AlertModel.fromMap(doc.data())).toList());
  }

  Future<void> resolveAlert(String alertId) async {
    await _db.collection(ApiConstants.alertCollection).doc(alertId).update({'status': 'resolved'});
  }
}
