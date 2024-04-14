import '../../core/enums/bogeda_count_product_enum.dart';
import '../../models/vessel_models/vessel_cargo_model.dart';

Map<int, List<VesselCargoModel>> groupCargoByCountNumber(List<VesselCargoModel> cargoList) {
  Map<int, List<VesselCargoModel>> groupedCargo = {};

  for (var cargo in cargoList) {
    if (!groupedCargo.containsKey(cargo.cargoCountNumber)) {
      groupedCargo[cargo.cargoCountNumber] = [];
    }
    groupedCargo[cargo.cargoCountNumber]!.add(cargo);
  }

  return groupedCargo;
}
List<VesselCargoModel> calculateSumPeso(Map<int, List<VesselCargoModel>> groupedCargo) {
  List<VesselCargoModel> summedCargo = [];

  groupedCargo.forEach((countNumber, cargoList) {
    // Calculate total peso for the product
    num sumTotal = cargoList.fold<num>(0, (prev, cargo) => prev + (cargo.pesoTotal?.toInt() ?? 0));
    num sumUnloaded= cargoList.fold<num>(0, (prev, cargo) => prev + (cargo.pesoUnloaded?.toInt() ?? 0));
    // Assign the cargoId for all items in the group
    String cargoId = cargoList.first.cargoId;

    summedCargo.add(
      VesselCargoModel(
        cargoId: cargoId,
        productName: '',
        tipo: '',
        origen: '',
        variety: '',
        cosecha: '',
        pesoTotal: sumTotal.toDouble(),
        pesoUnloaded: sumUnloaded.toDouble(),
        multipleProductInBodega: false,
        cargoCountNumber: countNumber,
        bogedaCountProductEnum: BogedaCountProductEnum.A,
      ),
    );
  });

  return summedCargo;
}