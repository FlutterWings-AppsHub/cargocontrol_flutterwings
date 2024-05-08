
class Messages {
  static const String deleteChoferesError = 'You cannot delete the choferes because the chorefes is currently on viajes';
  static const String fillAllTheFieldError = "Please Fill All Fields!";
  static const String vesselFinishLoadingSuccess = "Buque terminado de descargar!";
  static const String viajesUpdatedSuccess ='Viajes Updated!';
  static const String invalidWeightError ="Invalid Weight";
  static const String accountCreatedSuccess ='Account Created Successfully!';
  static const String viajesRegisteredSuccess ='Viajes Registered Successfully!';
  static const String noIndustryFoundError ='No Industry Found!';
  static const String arrivalBeforeAll =
      "La hora de llegada al puerto debe ser anterior a todos los horarios.";
  static const String departureBeforeArrival =
      "La hora de salida del puerto debe ser anterior a la hora de llegada y descarga de la industria.";
  static const String arrivalAfterDeparture =
      "La hora de llegada de la industria debe ser posterior a la hora de salida del puerto y antes de la hora de descarga.";
  static const String unloadingTimeInvalid =
      "El tiempo de descarga debe ser posterior a la hora de salida del puerto y a la hora de llegada a la industria.";

  static const String choferesDeleteSuccess = 'Choferes Deleted!';
  static const String choferesAlreadyRegisteredError = 'Choferes Already Registered!';
  static const String choferesRegisteredSuccess= 'Choferes Registered Successfully!';

  static const String industryCreatedSuccess = 'Industry Created Successfully!';
  static const String industryGuidesError = "Industry guides cannot be the same, and the first guide should start after the second guide!";
  static const String sameProductError = "Both products are same for industry #";
  static const String sameIndustryError = "Cannot select the same industry multiple times!";
  static const String totalLoadExceedError = "Total load exceeds Assigned Cargo weight! Limit is";

  static const String vesselCreatedSuccess = 'Vessel Created Successfully!';
  static const String bothProductForBodegaError ="Both Products are same for Bodega" ;
  static const String reportGenerateError = 'Unable to genearte report now!';
  static const String brutoMorethanTaraError = 'Peso bruto cannot be less than peso tara!';
  static const String enterPesoBrutoError = 'Enter Peso bruto!';
  static const String pesoExceeedError = "Peso bruto is more then total carga! Max is can be";

  static const String enterPlateNumberError =   'Enter Plate Number!';
  static const String viajesUnlaodedSuccess  = 'Viajes Unlaoded Succesfully!';
  static const String industryCreateError =   'Created the vessel first!';
  static const String vesselHasNotFinishError =   "Vessel has not finish unloading yet!";

  static const String selectTheProductError=   'Select the product!';
  static const String selectTheBodegaError =   'Select the Bodega!';
  static const String pesoNetLessThanBodegaError = "Peso neto is less than available product in bodega";
  static const String pesoNetLessThanProductError = "Peso neto is less than available product in vessel";


}