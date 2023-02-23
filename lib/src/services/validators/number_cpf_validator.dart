String? numberCpfValidator(String? inputName) {
  if (!inputName!.contains(RegExp(r'[0-9]'), 0)) {
    return 'Digite o $inputName somente de números.';
  }
  return null;
}
