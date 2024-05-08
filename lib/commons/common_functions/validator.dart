var regEx = RegExp(
    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
RegExp numReg = RegExp(r".*[0-9].*");
RegExp phoneNumReg =
    RegExp(r"^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$");
RegExp letterReg = RegExp(r".*[A-Za-z].*");

String? emailValidator(String? value) {
  if (!regEx.hasMatch(value!)) {
    return 'Enter a valid email address';
  }
  return null;
}


String? isValidInstagramHandle(String? handle) {
  RegExp regex = RegExp(r'^[a-zA-Z0-9._]{1,30}$');
  if (!regex.hasMatch(handle!)) {
    return 'Enter a valid email address';
  }
  return null;
}


String? uNameValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter your user name';
  }
  if (value.length > 15) {
    return 'Exceeded 15 characters';
  }
  return null;
}

String? countryValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter your country';
  }
  return null;
}

String? sectionValidator(String? value) {
  if (value!.isEmpty) {
    return 'Can\'t be empty';
  }
  return null;
}
String? pesoTaraValidator(String? value) {
  if (value!.isEmpty) {
    return 'Can\'t be empty';
  }
  double pesoTara = 0.0;
  try{
    pesoTara= double.parse(value.trim());
  }catch(e){
    return "Peso Tara should be number";
  }
  if(pesoTara<10000 || pesoTara > 20000){
    return "Peso Tara should be between 10,000 to 20,000";
  }
  return null;
}

String? pesoBrutoValidator(String? value) {
  if (value!.isEmpty) {
    return 'Can\'t be empty';
  }
  double pesoTara = 0.0;
  try{
    pesoTara= double.parse(value.trim());
  }catch(e){
    return "Peso burto should be number";
  }
  if(pesoTara<30000 || pesoTara > 60000){
    return "Peso bruto should be between 30,000 to 50,000";
  }
  return null;
}

String? cityValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter your City';
  }
  return null;
}

String? addressValidator(String? value) {
  if (value!.isEmpty) {
    return 'Enter a Valid Address';
  }
  return null;
}

String? passValidator(String? value) {
  if (value!.length < 6) {
    return 'can not have less than 6 characters';
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value!.length > 12 || value.length < 8) {
    return 'Enter at least 8 numbers!';
  }
  return null;
}
