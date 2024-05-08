import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';

String getProductNameFromCargoHold({required VesselCargoModel vesselCargoModel}){
  return "${vesselCargoModel.productName}, ${vesselCargoModel.variety}, ${vesselCargoModel.cosecha}, ${vesselCargoModel.tipo}, ${vesselCargoModel.origen}";

}