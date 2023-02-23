// ignore: body_might_complete_normally_nullable
String? passwordValidatorRegCaracters(String? campo, String? password) {
  if (!password!.contains(RegExp(r'[@$!%*#?&]'), 0)) {
    return 'Digite $campo com pelo menos uma @\$!%*#?&';
  }
}
