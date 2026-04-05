import 'package:get/get.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final _service = AuthService();

  final token       = ''.obs;
  final currentUser = Rxn<User>();
  final isLoading   = false.obs;
  final error       = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSession();
  }

  // ── Auto login if token exists ─────────────────────────────
  void _loadSession() {
    final saved = _service.getToken();
    if (saved != null && saved.isNotEmpty) {
      token.value       = saved;
      currentUser.value = _service.getCurrentUser();
    }
  }

  Future<void> login(String email, String password) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      error.value = 'Please fill all fields';
      return;
    }
    isLoading.value = true;
    error.value     = '';
    try {
      await _service.login(email.trim(), password.trim());
      token.value       = _service.getToken()!;
      currentUser.value = _service.getCurrentUser();
      Get.offAllNamed('/homePage');
    } catch (e) {
      error.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String name, String email, String password) async {
    if (name.trim().isEmpty || email.trim().isEmpty || password.trim().isEmpty) {
      error.value = 'Please fill all fields';
      return;
    }
    isLoading.value = true;
    error.value     = '';
    try {
      await _service.register(name.trim(), email.trim(), password.trim());
      token.value       = _service.getToken()!;
      currentUser.value = _service.getCurrentUser();
      Get.offAllNamed('/homePage');
    } catch (e) {
      error.value = e.toString().replaceAll('Exception: ', '');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _service.logout();
    token.value       = '';
    currentUser.value = null;
    Get.offAllNamed('/login');
  }
}