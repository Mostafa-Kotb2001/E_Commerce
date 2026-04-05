import 'package:get/get.dart';
import '../models/confirmation.dart';
import '../services/confirm_service.dart';

class ConfirmationController extends GetxController {
  final _service = ConfirmationService();

  final confirmations = <Confirmation>[].obs;
  final isLoading = false.obs;
  final error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadConfirmations();
  }

  /// Load all saved confirmations
  void loadConfirmations() {
    confirmations.value = _service.getConfirmations();
  }

  /// Add a new confirmation
  Future<void> addConfirmation(Confirmation confirmation) async {
    isLoading.value = true;
    error.value = '';
    try {
      await _service.addConfirmation(confirmation);
      loadConfirmations();
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
  
}
