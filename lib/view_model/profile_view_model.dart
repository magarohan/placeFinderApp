import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../service/auth_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setEditing(bool value) {
    _isEditing = value;
    _errorMessage = null;
    notifyListeners();
  }

  Stream<DocumentSnapshot> get userStream {
    final user = _authService.currentUser;
    if (user == null) return const Stream.empty();
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots();
  }

  Future<bool> updateProfile(String name) async {
    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.updateProfile(displayName: name);
      _isEditing = false;
      _isSaving = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isSaving = false;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
  }

  String getInitials(String? name) {
    if (name == null || name.isEmpty) return 'U';
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }
}
