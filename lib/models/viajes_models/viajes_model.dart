import 'package:cargocontrol/core/enums/viajes_status_enum.dart';
import 'package:cargocontrol/core/enums/viajes_type.dart';

import '../../core/enums/bogeda_count_product_enum.dart';
import '../../core/enums/weight_unit_enum.dart';

class ViajesModel {
  final String viajesId;
  final DateTime entryTimeToPort;
  final double entryTimeTruckWeightToPort;
  final DateTime exitTimeToPort;
  final double exitTimeTruckWeightToPort;
  final DateTime uploadingTime;
  final double pureCargoWeight;
  final double cargoUnloadWeight;
  final double cargoDeficitWeight;
  final DateTime timeToIndustry;
  final DateTime unloadingTimeInIndustry;
  final double guideNumber; //search
  final String industryId;
  final String industryName;
  final String realIndustryId;
  final String vesselId;
  final String vesselName;
  final String chofereId; //search
  final int cargoHoldCount;
  final BogedaCountProductEnum bogedaCountProductEnum;
  final String chofereName; //search
  final String licensePlate;
  final String marchamo1;
  final String marchamo2;
  final String cargoId;
  final String productId;
  final String productName;
  final ViajesTypeEnum viajesTypeEnum;
  final ViajesStatusEnum viajesStatusEnum;
  final WeightUnitEnum weightUnitEnum;
  final String truckInPortRegisteredBy;
  final String truckInPortLoadedBy;
  final String truckInIndustryRegisteredBy;
  final String truckInIndustryUnLoadedBy;
  final Map<String, dynamic> searchTags;


  Duration get tripTime {
    if (exitTimeToPort != null && timeToIndustry != null) {
      return timeToIndustry.difference(exitTimeToPort);
    }
    return Duration.zero;
  }

//<editor-fold desc="Data Methods">
  const ViajesModel({
    required this.viajesId,
    required this.entryTimeToPort,
    required this.entryTimeTruckWeightToPort,
    required this.exitTimeToPort,
    required this.exitTimeTruckWeightToPort,
    required this.uploadingTime,
    required this.pureCargoWeight,
    required this.cargoUnloadWeight,
    required this.cargoDeficitWeight,
    required this.timeToIndustry,
    required this.unloadingTimeInIndustry,
    required this.guideNumber,
    required this.industryId,
    required this.industryName,
    required this.realIndustryId,
    required this.vesselId,
    required this.vesselName,
    required this.chofereId,
    required this.cargoHoldCount,
    required this.bogedaCountProductEnum,
    required this.chofereName,
    required this.licensePlate,
    required this.marchamo1,
    required this.marchamo2,
    required this.cargoId,
    required this.productId,
    required this.productName,
    required this.viajesTypeEnum,
    required this.viajesStatusEnum,
    required this.weightUnitEnum,
    required this.truckInPortRegisteredBy,
    required this.truckInPortLoadedBy,
    required this.truckInIndustryRegisteredBy,
    required this.truckInIndustryUnLoadedBy,
    required this.searchTags,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ViajesModel &&
          runtimeType == other.runtimeType &&
          viajesId == other.viajesId &&
          entryTimeToPort == other.entryTimeToPort &&
          entryTimeTruckWeightToPort == other.entryTimeTruckWeightToPort &&
          exitTimeToPort == other.exitTimeToPort &&
          exitTimeTruckWeightToPort == other.exitTimeTruckWeightToPort &&
          uploadingTime == other.uploadingTime &&
          pureCargoWeight == other.pureCargoWeight &&
          cargoUnloadWeight == other.cargoUnloadWeight &&
          cargoDeficitWeight == other.cargoDeficitWeight &&
          timeToIndustry == other.timeToIndustry &&
          unloadingTimeInIndustry == other.unloadingTimeInIndustry &&
          guideNumber == other.guideNumber &&
          industryId == other.industryId &&
          industryName == other.industryName &&
          realIndustryId == other.realIndustryId &&
          vesselId == other.vesselId &&
          vesselName == other.vesselName &&
          chofereId == other.chofereId &&
          cargoHoldCount == other.cargoHoldCount &&
          bogedaCountProductEnum == other.bogedaCountProductEnum &&
          chofereName == other.chofereName &&
          licensePlate == other.licensePlate &&
          marchamo1 == other.marchamo1 &&
          marchamo2 == other.marchamo2 &&
          cargoId == other.cargoId &&
          productId == other.productId &&
          productName == other.productName &&
          viajesTypeEnum == other.viajesTypeEnum &&
          viajesStatusEnum == other.viajesStatusEnum &&
          weightUnitEnum == other.weightUnitEnum &&
          truckInPortRegisteredBy == other.truckInPortRegisteredBy &&
          truckInPortLoadedBy == other.truckInPortLoadedBy &&
          truckInIndustryRegisteredBy == other.truckInIndustryRegisteredBy &&
          truckInIndustryUnLoadedBy == other.truckInIndustryUnLoadedBy &&
          searchTags == other.searchTags);

  @override
  int get hashCode =>
      viajesId.hashCode ^
      entryTimeToPort.hashCode ^
      entryTimeTruckWeightToPort.hashCode ^
      exitTimeToPort.hashCode ^
      exitTimeTruckWeightToPort.hashCode ^
      uploadingTime.hashCode ^
      pureCargoWeight.hashCode ^
      cargoUnloadWeight.hashCode ^
      cargoDeficitWeight.hashCode ^
      timeToIndustry.hashCode ^
      unloadingTimeInIndustry.hashCode ^
      guideNumber.hashCode ^
      industryId.hashCode ^
      industryName.hashCode ^
      realIndustryId.hashCode ^
      vesselId.hashCode ^
      vesselName.hashCode ^
      chofereId.hashCode ^
      cargoHoldCount.hashCode ^
      bogedaCountProductEnum.hashCode ^
      chofereName.hashCode ^
      licensePlate.hashCode ^
      marchamo1.hashCode ^
      marchamo2.hashCode ^
      cargoId.hashCode ^
      productId.hashCode ^
      productName.hashCode ^
      viajesTypeEnum.hashCode ^
      viajesStatusEnum.hashCode ^
      weightUnitEnum.hashCode ^
      truckInPortRegisteredBy.hashCode ^
      truckInPortLoadedBy.hashCode ^
      truckInIndustryRegisteredBy.hashCode ^
      truckInIndustryUnLoadedBy.hashCode ^
      searchTags.hashCode;

  @override
  String toString() {
    return 'ViajesModel{' +
        ' viajesId: $viajesId,' +
        ' entryTimeToPort: $entryTimeToPort,' +
        ' entryTimeTruckWeightToPort: $entryTimeTruckWeightToPort,' +
        ' exitTimeToPort: $exitTimeToPort,' +
        ' exitTimeTruckWeightToPort: $exitTimeTruckWeightToPort,' +
        ' uploadingTime: $uploadingTime,' +
        ' pureCargoWeight: $pureCargoWeight,' +
        ' cargoUnloadWeight: $cargoUnloadWeight,' +
        ' cargoDeficitWeight: $cargoDeficitWeight,' +
        ' timeToIndustry: $timeToIndustry,' +
        ' unloadingTimeInIndustry: $unloadingTimeInIndustry,' +
        ' guideNumber: $guideNumber,' +
        ' industryId: $industryId,' +
        ' industryName: $industryName,' +
        ' realIndustryId: $realIndustryId,' +
        ' vesselId: $vesselId,' +
        ' vesselName: $vesselName,' +
        ' chofereId: $chofereId,' +
        ' cargoHoldCount: $cargoHoldCount,' +
        ' bogedaCountProductEnum: $bogedaCountProductEnum,' +
        ' chofereName: $chofereName,' +
        ' licensePlate: $licensePlate,' +
        ' marchamo1: $marchamo1,' +
        ' marchamo2: $marchamo2,' +
        ' cargoId: $cargoId,' +
        ' productId: $productId,' +
        ' productName: $productName,' +
        ' viajesTypeEnum: $viajesTypeEnum,' +
        ' viajesStatusEnum: $viajesStatusEnum,' +
        ' weightUnitEnum: $weightUnitEnum,' +
        ' truckInPortRegisteredBy: $truckInPortRegisteredBy,' +
        ' truckInPortLoadedBy: $truckInPortLoadedBy,' +
        ' truckInIndustryRegisteredBy: $truckInIndustryRegisteredBy,' +
        ' truckInIndustryUnLoadedBy: $truckInIndustryUnLoadedBy,' +
        ' searchTags: $searchTags,' +
        '}';
  }

  ViajesModel copyWith({
    String? viajesId,
    DateTime? entryTimeToPort,
    double? entryTimeTruckWeightToPort,
    DateTime? exitTimeToPort,
    double? exitTimeTruckWeightToPort,
    DateTime? uploadingTime,
    double? pureCargoWeight,
    double? cargoUnloadWeight,
    double? cargoDeficitWeight,
    DateTime? timeToIndustry,
    DateTime? unloadingTimeInIndustry,
    double? guideNumber,
    String? industryId,
    String? industryName,
    String? realIndustryId,
    String? vesselId,
    String? vesselName,
    String? chofereId,
    int? cargoHoldCount,
    BogedaCountProductEnum? bogedaCountProductEnum,
    String? chofereName,
    String? licensePlate,
    String? marchamo1,
    String? marchamo2,
    String? cargoId,
    String? productId,
    String? productName,
    ViajesTypeEnum? viajesTypeEnum,
    ViajesStatusEnum? viajesStatusEnum,
    WeightUnitEnum? weightUnitEnum,
    String? truckInPortRegisteredBy,
    String? truckInPortLoadedBy,
    String? truckInIndustryRegisteredBy,
    String? truckInIndustryUnLoadedBy,
    Map<String, dynamic>? searchTags,
  }) {
    return ViajesModel(
      viajesId: viajesId ?? this.viajesId,
      entryTimeToPort: entryTimeToPort ?? this.entryTimeToPort,
      entryTimeTruckWeightToPort:
          entryTimeTruckWeightToPort ?? this.entryTimeTruckWeightToPort,
      exitTimeToPort: exitTimeToPort ?? this.exitTimeToPort,
      exitTimeTruckWeightToPort:
          exitTimeTruckWeightToPort ?? this.exitTimeTruckWeightToPort,
      uploadingTime: uploadingTime ?? this.uploadingTime,
      pureCargoWeight: pureCargoWeight ?? this.pureCargoWeight,
      cargoUnloadWeight: cargoUnloadWeight ?? this.cargoUnloadWeight,
      cargoDeficitWeight: cargoDeficitWeight ?? this.cargoDeficitWeight,
      timeToIndustry: timeToIndustry ?? this.timeToIndustry,
      unloadingTimeInIndustry:
          unloadingTimeInIndustry ?? this.unloadingTimeInIndustry,
      guideNumber: guideNumber ?? this.guideNumber,
      industryId: industryId ?? this.industryId,
      industryName: industryName ?? this.industryName,
      realIndustryId: realIndustryId ?? this.realIndustryId,
      vesselId: vesselId ?? this.vesselId,
      vesselName: vesselName ?? this.vesselName,
      chofereId: chofereId ?? this.chofereId,
      cargoHoldCount: cargoHoldCount ?? this.cargoHoldCount,
      bogedaCountProductEnum:
          bogedaCountProductEnum ?? this.bogedaCountProductEnum,
      chofereName: chofereName ?? this.chofereName,
      licensePlate: licensePlate ?? this.licensePlate,
      marchamo1: marchamo1 ?? this.marchamo1,
      marchamo2: marchamo2 ?? this.marchamo2,
      cargoId: cargoId ?? this.cargoId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      viajesTypeEnum: viajesTypeEnum ?? this.viajesTypeEnum,
      viajesStatusEnum: viajesStatusEnum ?? this.viajesStatusEnum,
      weightUnitEnum: weightUnitEnum ?? this.weightUnitEnum,
      truckInPortRegisteredBy:
          truckInPortRegisteredBy ?? this.truckInPortRegisteredBy,
      truckInPortLoadedBy: truckInPortLoadedBy ?? this.truckInPortLoadedBy,
      truckInIndustryRegisteredBy:
          truckInIndustryRegisteredBy ?? this.truckInIndustryRegisteredBy,
      truckInIndustryUnLoadedBy:
          truckInIndustryUnLoadedBy ?? this.truckInIndustryUnLoadedBy,
      searchTags: searchTags ?? this.searchTags,
    );
  }



  Map<String, dynamic> toMap() {
    return {
      'viajesId': this.viajesId,
      'entryTimeToPort': this.entryTimeToPort.millisecondsSinceEpoch,
      'entryTimeTruckWeightToPort': this.entryTimeTruckWeightToPort,
      'exitTimeToPort': this.exitTimeToPort.millisecondsSinceEpoch,
      'exitTimeTruckWeightToPort': this.exitTimeTruckWeightToPort,
      'uploadingTime': this.uploadingTime.millisecondsSinceEpoch,
      'pureCargoWeight': this.pureCargoWeight,
      'cargoUnloadWeight': this.cargoUnloadWeight,
      'cargoDeficitWeight': this.cargoDeficitWeight,
      'timeToIndustry': this.timeToIndustry.millisecondsSinceEpoch,
      'unloadingTimeInIndustry':
      this.unloadingTimeInIndustry.millisecondsSinceEpoch,
      'guideNumber': this.guideNumber,
      'industryId': this.industryId,
      'industryName': this.industryName,
      'realIndustryId': this.realIndustryId,
      'vesselId': this.vesselId,
      'vesselName': this.vesselName,
      'chofereId': this.chofereId,
      'cargoHoldCount': this.cargoHoldCount,
      'chofereName': this.chofereName,
      'productName': this.productName,
      'licensePlate': this.licensePlate,
      'cargoId': this.cargoId,
      'bogedaCountProductEnum': this.bogedaCountProductEnum.type,
      'marchamo1': this.marchamo1,
      'marchamo2': this.marchamo2,
      'productId': this.productId,
      'viajesTypeEnum': this.viajesTypeEnum.type,
      'viajesStatusEnum': this.viajesStatusEnum.type,
      'weightUnitEnum': this.weightUnitEnum.type,
      'searchTags': this.searchTags,
      'truckInPortRegisteredBy': this.truckInPortRegisteredBy,
      'truckInPortLoadedBy': this.truckInPortLoadedBy,
      'truckInIndustryRegisteredBy': this.truckInIndustryRegisteredBy,
      'truckInIndustryUnLoadedBy': this.truckInIndustryUnLoadedBy,

    };
  }


  factory ViajesModel.fromMap(Map<String, dynamic> map) {
    return ViajesModel(
      entryTimeToPort:
      DateTime.fromMillisecondsSinceEpoch(map['entryTimeToPort']),
      exitTimeToPort:
      DateTime.fromMillisecondsSinceEpoch(map['exitTimeToPort']),
      timeToIndustry:
      DateTime.fromMillisecondsSinceEpoch(map['timeToIndustry']),
      unloadingTimeInIndustry:
      DateTime.fromMillisecondsSinceEpoch(map['unloadingTimeInIndustry']),
      uploadingTime: DateTime.fromMillisecondsSinceEpoch(map['uploadingTime']),
      pureCargoWeight: (map['pureCargoWeight'] as num).toDouble(),
      cargoUnloadWeight: (map['cargoUnloadWeight'] as num).toDouble(),
      cargoDeficitWeight: (map['cargoDeficitWeight'] as num).toDouble(),
      guideNumber: (map['guideNumber'] as num).toDouble(),
      industryId: map['industryId'] as String,
      industryName: map['industryName'] as String,
      realIndustryId: map['realIndustryId'] as String,
      vesselId: map['vesselId'] as String,
      vesselName: map['vesselName'] as String,
      chofereId: map['chofereId'] as String,
      cargoHoldCount: map['cargoHoldCount'] as int,
      chofereName: map['chofereName'] as String,
      productName: map['productName'] as String,
      licensePlate: map['licensePlate'] as String,
      cargoId: map['cargoId'] as String,
      viajesTypeEnum: (map['viajesTypeEnum'] as String).toViajesTypeEnum(),
      viajesStatusEnum:
      (map['viajesStatusEnum'] as String).toViajesStatusEnum(),
      viajesId: map['viajesId'] as String,
      entryTimeTruckWeightToPort:
      (map['entryTimeTruckWeightToPort'] as num).toDouble(),
      exitTimeTruckWeightToPort:
      (map['exitTimeTruckWeightToPort'] as num).toDouble(),
      bogedaCountProductEnum:  (map['bogedaCountProductEnum'] as String).toBogedaCountProductEnum(),
      marchamo1: map['marchamo1'] as String,
      marchamo2: map['marchamo2'] as String,
      productId: map['productId'] as String,
      weightUnitEnum: (map['weightUnitEnum'] as String).toWeightUnitEnum(),
      // truckInPortRegisteredBy: map['truckInPortRegisteredBy'] as String,
      // truckInPortLoadedBy: map['truckInPortLoadedBy'] as String,
      // truckInIndustryRegisteredBy: map['truckInIndustryRegisteredBy'] as String,
      // truckInIndustryUnLoadedBy: map['truckInIndustryUnLoadedBy'] as String,
      truckInPortRegisteredBy: map['truckInPortRegisteredBy'] == null
          ? ""
          : map['truckInPortRegisteredBy'] as String,
      truckInPortLoadedBy: map['truckInPortLoadedBy'] == null
          ? ""
          : map['truckInPortLoadedBy'] as String,
      truckInIndustryRegisteredBy: map['truckInIndustryRegisteredBy'] == null
          ? ""
          : map['truckInIndustryRegisteredBy'] as String,
      truckInIndustryUnLoadedBy: map['truckInIndustryUnLoadedBy'] == null
          ? ""
          : map['truckInIndustryUnLoadedBy'] as String,
      searchTags: map['searchTags'] as Map<String, dynamic>,
    );
  }

//</editor-fold>
}

/*





*/
