String? minusculalidator(String? campo, String inputName) {
  if (!campo!.contains(RegExp(r'[a-z]'), 0)) {
    return 'Digite $inputName com pelo menos uma letra minuscula';
  }
  return null;
}
