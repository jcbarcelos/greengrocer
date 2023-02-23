import 'package:greengrocer/src/config/api/apiHttp.dart';
import 'package:greengrocer/src/config/list_names_system/http_methods.dart';
import 'package:greengrocer/src/const/endpoint.dart';
import 'package:greengrocer/src/const/messages/auth_error_messages.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';

class AuthRepository {
  final HttpManager _apiHttp = HttpManager();

  Future<void> resetPassword(String email) async {
    await _apiHttp.restRequest(
      url: Endpoints.forgetPassword,
      method: HttpMethods.post,
      body: {
        'email': email,
      },
    );
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _apiHttp.restRequest(
        url: Endpoints.validateToken,
        method: HttpMethods.post,
        headers: {
          "X-Parse-Session-Token": token,
        });

    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrorMessagesString(result['error']));
    }
  }

  Future signIn({
    required String email,
    required String password,
  }) async {
    final result = await _apiHttp.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        "email": email,
        "password": password,
      },
    );
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrorMessagesString(result['error']));
    }
  }

  Future signUp({
    required String email,
    required String password,
    required String fullname,
    required String phone,
    required String cpf,
  }) async {
    final result = await _apiHttp.restRequest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: {
        "email": email,
        "password": password,
        "fullname": fullname,
        "phone": phone,
        "cpf": cpf,
      },
    );
    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrorMessagesString(result['error']));
    }
  }
}
