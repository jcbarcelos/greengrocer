// ignore: body_might_complete_normally_nullable
String? maisculaValidator(String? campo, String inputName) {
  if (!inputName.contains(RegExp(r'[A-Z]'), 0)) {
    return 'Digite $inputName com pelo menos uma letra maiuscula';
  }
}
