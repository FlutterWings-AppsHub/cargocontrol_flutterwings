var regEx = RegExp(
    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
RegExp numReg = RegExp(r".*[0-9].*");
RegExp phoneNumReg =
    RegExp(r"^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$");
RegExp letterReg = RegExp(r".*[A-Za-z].*");

String? emailValidator(String? value) {
  if (!regEx.hasMatch(value!)) {
    return 'Ingresa una dirección de correo electrónico válida';
  }
  return null;
}


String? uNameValidator(String? value) {
  if (value!.isEmpty) {
    return 'Ingresa tu nombre de usuario';
  }
  if (value.length > 15) {
    return 'Excedió los 15 caracteres';
  }
  return null;
}

String? countryValidator(String? value) {
  if (value!.isEmpty) {
    return 'Ingresa tu país';
  }
  return null;
}

String? sectionValidator(String? value) {
  if (value!.isEmpty) {
    return 'No puede estar vacío';
  }
  return null;
}

String? pesoTaraValidator(String? value) {
  if (value!.isEmpty) {
    return 'No puede estar vacío';
  }
  double pesoTara = 0.0;
  try {
    pesoTara = double.parse(value.trim());
  } catch (e) {
    return "El peso tara debe ser un número";
  }
  if (pesoTara < 10000 || pesoTara > 20000) {
    return "El peso tara debe estar entre 10,000 y 20,000";
  }
  return null;
}

String? pesoBrutoValidator(String? value) {
  if (value!.isEmpty) {
    return 'No puede estar vacío';
  }
  double pesoTara = 0.0;
  try {
    pesoTara = double.parse(value.trim());
  } catch (e) {
    return "El peso bruto debe ser un número";
  }
  if (pesoTara < 30000 || pesoTara > 60000) {
    return "El peso bruto debe estar entre 30,000 y 60,000";
  }
  return null;
}

String? cityValidator(String? value) {
  if (value!.isEmpty) {
    return 'Ingresa tu ciudad';
  }
  return null;
}

String? addressValidator(String? value) {
  if (value!.isEmpty) {
    return 'Ingresa una dirección válida';
  }
  return null;
}

String? passValidator(String? value) {
  if (value!.length < 6) {
    return 'No puede tener menos de 6 caracteres';
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value!.length > 12 || value.length < 8) {
    return '¡Ingresa al menos 8 números!';
  }
  return null;
}