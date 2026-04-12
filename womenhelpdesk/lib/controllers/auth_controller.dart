import 'package:flutter/material.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';

class AuthController extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loginGuardian(String assignedId, String password) async {
    _setLoading(true);
    try {
      final guardian = await _firestoreService.getGuardianByCredentials(assignedId, password);
      if (guardian != null) {
        // Mock a UserModel for Guardian so the rest of the app works unified
        _userModel = UserModel(
          uid: guardian.id,
          name: guardian.guardianName,
          phone: guardian.guardianPhone,
          role: 'guardian',
        );
      } else {
        debugPrint("Guardian Login Failed: Invalid credentials");
      }
    } catch (e) {
      debugPrint("Guardian Error: $e");
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> loginWithPolice(String email, String password) async {
    _setLoading(true);
    try {
      final userCredential = await _authService.signInWithEmailAndPassword(email, password);
      final user = userCredential.user;
      if (user != null) {
        UserModel? existingUser = await _firestoreService.getUser(user.uid);
        if (existingUser != null) {
          _userModel = existingUser;
        } else {
          _userModel = UserModel(
            uid: user.uid,
            name: 'Police Station',
            phone: '',
            role: 'police',
          );
          await _firestoreService.saveUser(_userModel!);
        }
      }
    } catch (e) {
      debugPrint("Police Login Failed: $e");
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> loginUser(String email, String password) async {
    _setLoading(true);
    try {
      final userCredential = await _authService.signInWithEmailAndPassword(email, password);
      final user = userCredential.user;
      if (user != null) {
        _userModel = await _firestoreService.getUser(user.uid);
      }
    } catch (e) {
      debugPrint("Login Failed: $e");
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> registerUser(String email, String password, String name, String phone, String role) async {
    _setLoading(true);
    try {
      final userCredential = await _authService.createUserWithEmailAndPassword(email, password);
      final user = userCredential.user;
      if (user != null) {
        _userModel = UserModel(
          uid: user.uid,
          name: name,
          phone: phone,
          role: role,
        );
        await _firestoreService.saveUser(_userModel!);
      }
    } catch (e) {
      debugPrint("Registration Failed: $e");
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> logout() async {
    await _authService.signOut();
    _userModel = null;
    notifyListeners();
  }

  Future<void> checkCurrentUser() async {
    final user = _authService.currentUser;
    if (user != null) {
      _userModel = await _firestoreService.getUser(user.uid);
      notifyListeners();
    }
  }
}
