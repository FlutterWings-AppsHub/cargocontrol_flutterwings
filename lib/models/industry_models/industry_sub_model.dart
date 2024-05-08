import 'package:cargocontrol/models/vessel_models/vessel_product_model.dart';

import '../vessel_models/vessel_cargo_model.dart';

class IndustrySubModel{
  final String industryId;
  final String realIndustryId;
  final String industryName;
  final String vesselId;
  final List<String> vesselProductIds;
  final String vesselName;
  final List<VesselProductModel> vesselProductModels;
  final bool finishedUnloading;
  final List<dynamic> usedGuideNumbers;
  final List<dynamic> viajesIds;
  final double cargoAssigned;
  final double cargoUnloaded;
  final double deficit;
  final dynamic initialGuide;
  final dynamic lastGuide;

//<editor-fold desc="Data Methods">


  const IndustrySubModel({
    required this.industryId,
    required this.realIndustryId,
    required this.industryName,
    required this.vesselId,
    required this.vesselProductIds,
    required this.vesselName,
    required this.vesselProductModels,
    required this.finishedUnloading,
    required this.usedGuideNumbers,
    required this.viajesIds,
    required this.cargoAssigned,
    required this.cargoUnloaded,
    required this.deficit,
    required this.initialGuide,
    required this.lastGuide,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is IndustrySubModel &&
              runtimeType == other.runtimeType &&
              industryId == other.industryId &&
              realIndustryId == other.realIndustryId &&
              industryName == other.industryName &&
              vesselId == other.vesselId &&
              vesselProductIds == other.vesselProductIds &&
              vesselName == other.vesselName &&
              vesselProductModels == other.vesselProductModels &&
              finishedUnloading == other.finishedUnloading &&
              usedGuideNumbers == other.usedGuideNumbers &&
              viajesIds == other.viajesIds &&
              cargoAssigned == other.cargoAssigned &&
              cargoUnloaded == other.cargoUnloaded &&
              deficit == other.deficit &&
              initialGuide == other.initialGuide &&
              lastGuide == other.lastGuide
          );


  @override
  int get hashCode =>
      industryId.hashCode ^
      realIndustryId.hashCode ^
      industryName.hashCode ^
      vesselId.hashCode ^
      vesselProductIds.hashCode ^
      vesselName.hashCode ^
      vesselProductModels.hashCode ^
      finishedUnloading.hashCode ^
      usedGuideNumbers.hashCode ^
      viajesIds.hashCode ^
      cargoAssigned.hashCode ^
      cargoUnloaded.hashCode ^
      deficit.hashCode ^
      initialGuide.hashCode ^
      lastGuide.hashCode;


  @override
  String toString() {
    return 'IndustrySubModel{' +
        ' industryId: $industryId,' +
        ' realIndustryId: $realIndustryId,' +
        ' industryName: $industryName,' +
        ' vesselId: $vesselId,' +
        ' vesselProductIds: $vesselProductIds,' +
        ' vesselName: $vesselName,' +
        ' vesselProductModels: $vesselProductModels,' +
        ' finishedUnloading: $finishedUnloading,' +
        ' usedGuideNumbers: $usedGuideNumbers,' +
        ' viajesIds: $viajesIds,' +
        ' cargoAssigned: $cargoAssigned,' +
        ' cargoUnloaded: $cargoUnloaded,' +
        ' deficit: $deficit,' +
        ' initialGuide: $initialGuide,' +
        ' lastGuide: $lastGuide,' +
        '}';
  }


  IndustrySubModel copyWith({
    String? industryId,
    String? realIndustryId,
    String? industryName,
    String? vesselId,
    List<String>? vesselProductIds,
    String? vesselName,
    List<VesselProductModel>? vesselProductModels,
    bool? finishedUnloading,
    List<dynamic>? usedGuideNumbers,
    List<dynamic>? viajesIds,
    dynamic? cargoAssigned,
    dynamic? cargoUnloaded,
    dynamic? deficit,
    dynamic? initialGuide,
    dynamic? lastGuide,
  }) {
    return IndustrySubModel(
      industryId: industryId ?? this.industryId,
      realIndustryId: realIndustryId ?? this.realIndustryId,
      industryName: industryName ?? this.industryName,
      vesselId: vesselId ?? this.vesselId,
      vesselProductIds: vesselProductIds ?? this.vesselProductIds,
      vesselName: vesselName ?? this.vesselName,
      vesselProductModels: vesselProductModels ?? this.vesselProductModels,
      finishedUnloading: finishedUnloading ?? this.finishedUnloading,
      usedGuideNumbers: usedGuideNumbers ?? this.usedGuideNumbers,
      viajesIds: viajesIds ?? this.viajesIds,
      cargoAssigned: cargoAssigned ?? this.cargoAssigned,
      cargoUnloaded: cargoUnloaded ?? this.cargoUnloaded,
      deficit: deficit ?? this.deficit,
      initialGuide: initialGuide ?? this.initialGuide,
      lastGuide: lastGuide ?? this.lastGuide,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'industryId': this.industryId,
      'realIndustryId': this.realIndustryId,
      'industryName': this.industryName,
      'vesselId': this.vesselId,
      'vesselProductIds': this.vesselProductIds.map((e) => e.toString()).toList(),
      'vesselName': this.vesselName,
      'vesselProductModels': this.vesselProductModels.map((e) => e.toMap()).toList(),
      'finishedUnloading': this.finishedUnloading,
      'usedGuideNumbers': this.usedGuideNumbers,
      'viajesIds': this.viajesIds,
      'cargoAssigned': this.cargoAssigned,
      'cargoUnloaded': this.cargoUnloaded,
      'deficit': this.deficit,
      'initialGuide': this.initialGuide,
      'lastGuide': this.lastGuide,
    };
  }

  factory IndustrySubModel.fromMap(Map<String, dynamic> map) {
    return IndustrySubModel(
      industryId: map['industryId'] as String,
      realIndustryId: map['realIndustryId'] as String,
      industryName: map['industryName'] as String,
      vesselId: map['vesselId'] as String,
      vesselProductIds: (map['vesselProductIds'] as List<dynamic>).cast<String>(),
      vesselName: map['vesselName'] as String,
      vesselProductModels:   (map['vesselProductModels'] as List<dynamic>).
      map((e) => VesselProductModel.fromMap(e)).toList(),
      finishedUnloading: map['finishedUnloading'] as bool,
      usedGuideNumbers: map['usedGuideNumbers'] as List<dynamic>,
      viajesIds: map['viajesIds'] as List<dynamic>,
      cargoAssigned: (map['cargoAssigned'] as num).toDouble(),
      cargoUnloaded: (map['cargoUnloaded'] as num).toDouble(),
      deficit: (map['deficit'] as num).toDouble(),
      initialGuide: map['initialGuide'] as dynamic,
      lastGuide: map['lastGuide'] as dynamic,
    );
  }


//</editor-fold>
}

