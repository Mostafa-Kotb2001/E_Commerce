import 'dart:convert';
import 'package:get/get.dart';
import '../models/user.dart';
import 'initService.dart';

class AuthService {

  final _storage = Get.find<InitServices>().sharedPreferences!;

  static const String _usersKey       = 'users';
  static const String _tokenKey       = 'token';
  static const String _currentUserKey = 'current_user';


  Future<void> register(String name, String email, String password) async {
    final List users = jsonDecode(_storage.getString(_usersKey) ?? '[]');

    final exists = users.any((u) => u['email'] == email);
    if (exists) throw Exception('Email already registered');

    final user = User(name: name, email: email, password: password);
    users.add(user.toJson());
    await _storage.setString(_usersKey, jsonEncode(users));

    await _saveSession(user);
  }

  Future<void> login(String email, String password) async {
    final List users = jsonDecode(_storage.getString(_usersKey) ?? '[]');

    final match = users.firstWhere(
          (u) => u['email'] == email && u['password'] == password,
      orElse: () => null,
    );

    if (match == null) throw Exception('Invalid email or password');

    await _saveSession(User.fromJson(match));
  }

  Future<void> _saveSession(User user) async {

    final token = base64Encode(
      utf8.encode('${user.email}:${DateTime.now().millisecondsSinceEpoch}'),
    );
    await _storage.setString(_tokenKey, token);
    await _storage.setString(_currentUserKey, jsonEncode(user.toJson()));
  }

  // ── Getters ────────────────────────────────────────────────
  String? getToken() => _storage.getString(_tokenKey);

  User? getCurrentUser() {
    final raw = _storage.getString(_currentUserKey);
    if (raw == null) return null;
    return User.fromJson(jsonDecode(raw));
  }

  // ── Logout ─────────────────────────────────────────────────
  Future<void> logout() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_currentUserKey);
  }
}