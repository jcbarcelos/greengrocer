// ignore: body_might_complete_normally_nullable
String? inputValidatorNull(String? campo, String? inputName) {
  if (inputName == null || inputName.isEmpty) {
    return 'Digite $campo!';
  }
}
