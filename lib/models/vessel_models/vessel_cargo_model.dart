import 'package:cargocontrol/core/enums/bogeda_count_product_enum.dart';

import '../../core/enums/bogeda_count_product_enum.dart';

class VesselCargoModel{
  final String cargoId;
  final String productName;
  final String tipo;
  final String origen;
  final String variety;
  final String cosecha;
  final double pesoTotal;
  final double pesoUnloaded;
  final bool multipleProductInBodega;
  final int cargoCountNumber;
  final BogedaCountProductEnum bogedaCountProductEnum;

//<editor-fold desc="Data Methods">

  const VesselCargoModel({
    required this.cargoId,
    required this.productName,
    required this.tipo,
    required this.origen,
    required this.variety,
    required this.cosecha,
    required this.pesoTotal,
    required this.pesoUnloaded,
    required this.multipleProductInBodega,
    required this.cargoCountNumber,
    required this.bogedaCountProductEnum,
  });

// A,@override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is VesselCargoModel &&
              runtimeType == other.runtimeType &&
              cargoId == other.cargoId &&
              productName == other.productName &&
              tipo == other.tipo &&
              origen == other.origen &&
              variety == other.variety &&
              cosecha == other.cosecha &&
              pesoTotal == other.pesoTotal &&
              pesoUnloaded == other.pesoUnloaded &&
              multipleProductInBodega == other.multipleProductInBodega &&
              cargoCountNumber == other.cargoCountNumber &&
              bogedaCountProductEnum == other.bogedaCountProductEnum
          );


  @override
  int get hashCode =>
      cargoId.hashCode ^
      productName.hashCode ^
      tipo.hashCode ^
      origen.hashCode ^
      variety.hashCode ^
      cosecha.hashCode ^
      pesoTotal.hashCode ^
      pesoUnloaded.hashCode ^
      multipleProductInBodega.hashCode ^
      cargoCountNumber.hashCode ^
      bogedaCountProductEnum.hashCode;


  @override
  String toString() {
    return 'VesselCargoModel{' +
        ' cargoId: $cargoId,' +
        ' productName: $productName,' +
        ' tipo: $tipo,' +
        ' origen: $origen,' +
        ' variety: $variety,' +
        ' cosecha: $cosecha,' +
        ' pesoTotal: $pesoTotal,' +
        ' pesoUnloaded: $pesoUnloaded,' +
        ' multipleProductInBodega: $multipleProductInBodega,' +
        ' cargoCountNumber: $cargoCountNumber,' +
        ' bogedaCountProductEnum: $bogedaCountProductEnum,' +
        '}';
  }


  VesselCargoModel copyWith({
    String? cargoId,
    String? productName,
    String? tipo,
    String? origen,
    String? variety,
    String? cosecha,
    dynamic? pesoTotal,
    dynamic? pesoUnloaded,
    bool? multipleProductInBodega,
    int? cargoCountNumber,
    BogedaCountProductEnum? bogedaCountProductEnum,
  }) {
    return VesselCargoModel(
      cargoId: cargoId ?? this.cargoId,
      productName: productName ?? this.productName,
      tipo: tipo ?? this.tipo,
      origen: origen ?? this.origen,
      variety: variety ?? this.variety,
      cosecha: cosecha ?? this.cosecha,
      pesoTotal: pesoTotal ?? this.pesoTotal,
      pesoUnloaded: pesoUnloaded ?? this.pesoUnloaded,
      multipleProductInBodega: multipleProductInBodega ??
          this.multipleProductInBodega,
      cargoCountNumber: cargoCountNumber ?? this.cargoCountNumber,
      bogedaCountProductEnum: bogedaCountProductEnum ??
          this.bogedaCountProductEnum,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'cargoId': this.cargoId,
      'productName': this.productName,
      'tipo': this.tipo,
      'origen': this.origen,
      'variety': this.variety,
      'cosecha': this.cosecha,
      'pesoTotal': this.pesoTotal,
      'pesoUnloaded': this.pesoUnloaded,
      'multipleProductInBodega': this.multipleProductInBodega,
      'cargoCountNumber': this.cargoCountNumber,
      'bogedaCountProductEnum': this.bogedaCountProductEnum.type,
    };
  }

  factory VesselCargoModel.fromMap(Map<String, dynamic> map) {
    return VesselCargoModel(
      cargoId: map['cargoId'] as String,
      productName: map['productName'] as String,
      tipo: map['tipo'] as String,
      origen: map['origen'] as String,
      variety: map['variety'] as String,
      cosecha: map['cosecha'] as String,
      pesoTotal: (map['pesoTotal'] as num).toDouble(),
      pesoUnloaded: (map['pesoUnloaded'] as num).toDouble(),
      multipleProductInBodega: map['multipleProductInBodega'] as bool,
      cargoCountNumber: map['cargoCountNumber'] as int,
      bogedaCountProductEnum: (map['bogedaCountProductEnum'] as String).toBogedaCountProductEnum(),
    );
  }


  //</editor-fold>




}