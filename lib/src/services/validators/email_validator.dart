import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) return 'Digite seu email';
  if (!email.isEmail) return 'Digite um email válido';
  return null;
}
