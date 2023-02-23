String? nameLastNameValidator(String? inputName) {
  if (inputName == null || inputName.isEmpty) {
    return 'Digite seu(sua) $inputName!';
  }
  final nameAndLastName = inputName.split(' ');
  if (nameAndLastName == 1) {
    return 'Digite seu(sua) nome completo!';
  }
  return null;
}
