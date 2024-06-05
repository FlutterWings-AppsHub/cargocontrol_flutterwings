
class Messages {
  static const String deleteChoferesError = 'No puede eliminar al Chofer mientras está realizando un viaje';
  static const String fillAllTheFieldError = "Porfavor llene todos los campos";
  static const String vesselFinishLoadingSuccess = "Buque terminado de descargar!";
  static const String viajesUpdatedSuccess ='Viajes han sido actualizados!';
  static const String invalidWeightError ="Peso invalido";
  static const String accountCreatedSuccess ='Cuenta creada exitosamente';
  static const String viajesRegisteredSuccess ='Registro de viaje creado exitosamente';
  static const String noIndustryFoundError ='No se ha encontrado la Industria';
  static const String arrivalBeforeAll =
      "La hora de llegada al puerto debe ser anterior a todos los demás horarios.";
  static const String departureBeforeArrival =
      "La hora de salida del puerto debe ser anterior a la hora de llegada y descarga de la industria.";
  static const String arrivalAfterDeparture =
      "La hora de llegada de la industria debe ser posterior a la hora de salida del puerto y antes de la hora de descarga.";
  static const String unloadingTimeInvalid =
      "El tiempo de descarga debe ser posterior a la hora de salida del puerto y a la hora de llegada a la industria.";

  static const String choferesDeleteSuccess = 'Chofer eliminado exitosamente!';
  static const String choferesAlreadyRegisteredError = 'El chofer ya se encuentra registrado';
  static const String choferesRegisteredSuccess= 'Chofer registrado exitosamente';

  static const String industryCreatedSuccess = 'Industria registrada exitosamente';
  static const String industryGuidesError = "Los números de guías no pueden ser iguales, y deben ser consecutivas";
  static const String sameProductError = "Los productos están duplicados para la Industria #";
  static const String sameIndustryError = "No se puede seleccionar a la misma Industria";
  static const String totalLoadExceedError = "El peso total excede el permitido. El Límite es:";

  static const String vesselCreatedSuccess = 'Buque creado exitosamente';
  static const String bothProductForBodegaError ="Los productos están duplicados para la Bodega" ;
  static const String reportGenerateError = 'No se puede generar el reporte, intente más tarde';
  static const String brutoMorethanTaraError = 'El peso bruto no puede ser menor al peso tara';
  static const String enterPesoBrutoError = 'Ingrese el peso bruto';
  static const String pesoExceeedError = "El peso bruto es mayor a la carga total. El máximo es";

  static const String enterPlateNumberError =   'Ingrese la placa';
  static const String numberplateRegisterSuccess =   'Number Plate Registered!';
  static const String numberplateDeleteSuccess =   'Number Plate Deleted Successfully!';
  static const String viajesUnlaodedSuccess  = 'Camion descargado exitosamente';
  static const String industryCreateError =   'Porfavor cree el registro del Buque primero';
  static const String vesselHasNotFinishError =   "El buque no se ha descargado en su totalidad";

  static const String selectTheProductError = 'Sélectionnez le produit!';
  static const String selectTheBodegaError = 'Sélectionnez la Bodega!';
  static const String pesoNetLessThanBodegaError = "Le poids net est inférieur au produit disponible en bodega";

  static const String pesoNetLessThanProductError = "Le poids net est inférieur au produit disponible dans le conteneur";
  static const String pesoBrutoLessThanPesoTaraError = "El peso bruto no puede ser menor que el peso de la tara!";
  static const String pesoBrutoLessThanPesoUnloadingError = "El peso bruto no puede ser menor que el peso de descarga!";
  static const String cargoExceedsIndustryLimitError = "La carga excede el límite asignado de la industria";

  static String maxIndustriesError(int industryCount) {
    return '¡Puede registrar un máximo de $industryCount industrias!';
  }




}


