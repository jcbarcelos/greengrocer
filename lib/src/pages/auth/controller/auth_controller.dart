import 'package:get/get.dart';
import 'package:greengrocer/src/const/pages_routes/pages_routes.dart';
import 'package:greengrocer/src/const/storage_keys.dart';
import 'package:greengrocer/src/models/user_model.dart';

import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_repository.dart';
import 'package:greengrocer/src/services/secure_storage.dart';
import 'package:greengrocer/src/services/util_services.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final AuthRepository authRepository = AuthRepository();
  final UtilServices utilServices = UtilServices();
  final SecureStorage secureStorage = SecureStorage();
  UserModel userModel = UserModel();

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }

  Future<void> saveTokenAndProceedToBase() async {
    if (userModel.token != null) {
      await secureStorage.saveLocalData(
        key: StorageKeys.token,
        value: userModel.token!,
      );
      Get.offAllNamed(PagesRoutes.baseRoutes);
    } else {
      Get.offAllNamed(PagesRoutes.signInRoutes);
    }
  }

  Future<void> signOut() async {
    userModel = UserModel();
    await secureStorage.deleteLocalData(key: StorageKeys.token);
    userModel.token = null;
    Get.offAllNamed(PagesRoutes.signInRoutes);
  }

  Future<void> validateToken() async {
    String? token = await secureStorage.readLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoutes);
      return;
    }
    AuthResult authResult = await authRepository.validateToken(token);

    authResult.when(
      success: (user) async {
        userModel.token = user.token;
        saveTokenAndProceedToBase();
      },
      error: (messageError) {
        signOut();
      },
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    AuthResult authResult = await authRepository.signIn(
      email: email,
      password: password,
    );
    isLoading.value = false;
    authResult.when(
      success: (user) async {
        userModel = user;
        await validateToken();
        await saveTokenAndProceedToBase();
      },
      error: (messageError) {
        utilServices.showToast(
          message: messageError,
          isError: true,
        );
      },
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullname,
    required String phone,
    required String cpf,
  }) async {
    isLoading.value = true;
    AuthResult authResult = await authRepository.signUp(
      email: email,
      password: password,
      fullname: fullname,
      phone: phone,
      cpf: cpf,
    );
    isLoading.value = false;
    authResult.when(
      success: (user) async {
        await signIn(
          email: user.email!,
          password: password,
        );
      },
      error: (messageError) {
        utilServices.showToast(
          message: messageError,
          isError: true,
        );
      },
    );
  }
}
