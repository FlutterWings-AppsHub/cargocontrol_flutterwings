import 'package:cargocontrol/core/enums/weight_unit_enum.dart';
import 'package:cargocontrol/models/vessel_models/vessel_cargo_model.dart';
import 'package:cargocontrol/models/vessel_models/vessel_product_model.dart';

class VesselModel {
  final String vesselId;
  final String vesselName;
  final String exitPort;
  final String entryPort;
  final String shipper;
  final String unlcode;
  final double totalCargoWeight;
  final int numberOfCargos;
  final List<VesselCargoModel> cargoModels;
  final List<VesselProductModel> vesselProductModels;
  final double cargoUnloadedWeight;
  final DateTime entryDate;
  final DateTime exitDate;
  final DateTime createdDate;
  final bool isFinishedUnloading;
  final WeightUnitEnum weightUnitEnum;
  final Map<String, dynamic> searchTags;

//<editor-fold desc="Data Methods">
  const VesselModel({
    required this.vesselId,
    required this.vesselName,
    required this.exitPort,
    required this.entryPort,
    required this.shipper,
    required this.unlcode,
    required this.totalCargoWeight,
    required this.numberOfCargos,
    required this.cargoModels,
    required this.vesselProductModels,
    required this.cargoUnloadedWeight,
    required this.entryDate,
    required this.exitDate,
    required this.createdDate,
    required this.isFinishedUnloading,
    required this.weightUnitEnum,
    required this.searchTags,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VesselModel &&
          runtimeType == other.runtimeType &&
          vesselId == other.vesselId &&
          vesselName == other.vesselName &&
          exitPort == other.exitPort &&
          entryPort == other.entryPort &&
          shipper == other.shipper &&
          unlcode == other.unlcode &&
          totalCargoWeight == other.totalCargoWeight &&
          numberOfCargos == other.numberOfCargos &&
          cargoModels == other.cargoModels &&
          vesselProductModels == other.vesselProductModels &&
          cargoUnloadedWeight == other.cargoUnloadedWeight &&
          entryDate == other.entryDate &&
          exitDate == other.exitDate &&
          createdDate == other.createdDate &&
          isFinishedUnloading == other.isFinishedUnloading &&
          weightUnitEnum == other.weightUnitEnum &&
          searchTags == other.searchTags);

  @override
  int get hashCode =>
      vesselId.hashCode ^
      vesselName.hashCode ^
      exitPort.hashCode ^
      entryPort.hashCode ^
      shipper.hashCode ^
      unlcode.hashCode ^
      totalCargoWeight.hashCode ^
      numberOfCargos.hashCode ^
      cargoModels.hashCode ^
      vesselProductModels.hashCode ^
      cargoUnloadedWeight.hashCode ^
      entryDate.hashCode ^
      exitDate.hashCode ^
      createdDate.hashCode ^
      isFinishedUnloading.hashCode ^
      weightUnitEnum.hashCode ^
      searchTags.hashCode;

  @override
  String toString() {
    return 'VesselModel{' +
        ' vesselId: $vesselId,' +
        ' vesselName: $vesselName,' +
        ' exitPort: $exitPort,' +
        ' entryPort: $entryPort,' +
        ' shipper: $shipper,' +
        ' unlcode: $unlcode,' +
        ' totalCargoWeight: $totalCargoWeight,' +
        ' numberOfCargos: $numberOfCargos,' +
        ' cargoModels: $cargoModels,' +
        ' vesselProductModels: $vesselProductModels,' +
        ' cargoUnloadedWeight: $cargoUnloadedWeight,' +
        ' entryDate: $entryDate,' +
        ' exitDate: $exitDate,' +
        ' createdDate: $createdDate,' +
        ' isFinishedUnloading: $isFinishedUnloading,' +
        ' weightUnitEnum: $weightUnitEnum,' +
        ' searchTags: $searchTags,' +
        '}';
  }

  VesselModel copyWith({
    String? vesselId,
    String? vesselName,
    String? exitPort,
    String? entryPort,
    String? shipper,
    String? unlcode,
    double? totalCargoWeight,
    int? numberOfCargos,
    List<VesselCargoModel>? cargoModels,
    List<VesselProductModel>? vesselProductModels,
    double? cargoUnloadedWeight,
    DateTime? entryDate,
    DateTime? exitDate,
    DateTime? createdDate,
    bool? isFinishedUnloading,
    WeightUnitEnum? weightUnitEnum,
    Map<String, dynamic>? searchTags,
  }) {
    return VesselModel(
      vesselId: vesselId ?? this.vesselId,
      vesselName: vesselName ?? this.vesselName,
      exitPort: exitPort ?? this.exitPort,
      entryPort: entryPort ?? this.entryPort,
      shipper: shipper ?? this.shipper,
      unlcode: unlcode ?? this.unlcode,
      totalCargoWeight: totalCargoWeight ?? this.totalCargoWeight,
      numberOfCargos: numberOfCargos ?? this.numberOfCargos,
      cargoModels: cargoModels ?? this.cargoModels,
      vesselProductModels: vesselProductModels ?? this.vesselProductModels,
      cargoUnloadedWeight: cargoUnloadedWeight ?? this.cargoUnloadedWeight,
      entryDate: entryDate ?? this.entryDate,
      exitDate: exitDate ?? this.exitDate,
      createdDate: createdDate ?? this.createdDate,
      isFinishedUnloading: isFinishedUnloading ?? this.isFinishedUnloading,
      weightUnitEnum: weightUnitEnum ?? this.weightUnitEnum,
      searchTags: searchTags ?? this.searchTags,
    );
  }




  Map<String, dynamic> toMap() {
    return {
      'vesselId': this.vesselId,
      'vesselName': this.vesselName,
      'exitPort': this.exitPort,
      'entryPort': this.entryPort,
      'shipper': this.shipper,
      'unlcode': this.unlcode,
      'totalCargoWeight': this.totalCargoWeight,
      'numberOfCargos': this.numberOfCargos,
      'isFinishedUnloading': this.isFinishedUnloading,
      'cargoModels': this.cargoModels.map((e) => e.toMap()).toList(),
      'vesselProductModels': this.vesselProductModels.map((e) => e.toMap()).toList(),
      'cargoUnloadedWeight': this.cargoUnloadedWeight,
      'entryDate': this.entryDate.millisecondsSinceEpoch,
      'exitDate': this.exitDate.millisecondsSinceEpoch,
      'createdDate': this.createdDate.millisecondsSinceEpoch,
      'searchTags': this.searchTags,
      'weightUnitEnum': this.weightUnitEnum.type,

    };
  }

  factory VesselModel.fromMap(Map<String, dynamic> map) {
    return VesselModel(
      vesselId: map['vesselId'] as String,
      vesselName: map['vesselName'] as String,
      exitPort: map['exitPort'] as String,
      entryPort: map['entryPort'] as String,
      shipper: map['shipper'] as String,
      unlcode: map['unlcode'] as String,
      isFinishedUnloading: map['isFinishedUnloading'] as bool,
      totalCargoWeight: (map['totalCargoWeight'] as num).toDouble(),
      numberOfCargos: map['numberOfCargos'] as int,
      cargoModels: (map['cargoModels'] as List<dynamic>).
      map((e) => VesselCargoModel.fromMap(e)).toList(),
      vesselProductModels:
      (map['vesselProductModels'] as List<dynamic>).
      map((e) => VesselProductModel.fromMap(e)).toList(),
      cargoUnloadedWeight: (map['cargoUnloadedWeight'] as num).toDouble(),
      entryDate: DateTime.fromMillisecondsSinceEpoch(map['entryDate'] ),
      exitDate: DateTime.fromMillisecondsSinceEpoch(map['exitDate'] ),
      searchTags: map['searchTags'] as Map<String, dynamic>,
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate'] ),
      weightUnitEnum: (map['weightUnitEnum'] as String).toWeightUnitEnum(),
    );
  }

//</editor-fold>
}