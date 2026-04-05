import 'dart:convert';
import 'package:get/get.dart';
import '../models/confirmation.dart';
import 'initService.dart';

class ConfirmationService {
  final _storage = Get.find<InitServices>().sharedPreferences!;

  static const String _confirmationKey = 'confirmations';

  /// Save a new confirmation
  Future<void> addConfirmation(Confirmation confirmation) async {
    final List confirmations =
    jsonDecode(_storage.getString(_confirmationKey) ?? '[]');

    confirmations.add(confirmation.toJson());
    await _storage.setString(
        _confirmationKey, jsonEncode(confirmations));
  }

  /// Get all confirmations
  List<Confirmation> getConfirmations() {
    final List confirmations =
    jsonDecode(_storage.getString(_confirmationKey) ?? '[]');
    return confirmations
        .map((c) => Confirmation.fromJson(c))
        .toList();
  }
  
}
