// Used in Vessel Model and also in industry sub model
class VesselProductModel {
  final String productId;
  final String
      productName; // comma seperated // tipo; origen; variety; cosecha;
  final double pesoTotal;
  final double pesoUnloaded;
  final List<String> viajesIds;
  final double pesoAssigned;
  final double deficit;

//<editor-fold desc="Data Methods">
  const VesselProductModel({
    required this.productId,
    required this.productName,
    required this.pesoTotal,
    required this.pesoUnloaded,
    required this.viajesIds,
    required this.pesoAssigned,
    required this.deficit,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VesselProductModel &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          productName == other.productName &&
          pesoTotal == other.pesoTotal &&
          pesoUnloaded == other.pesoUnloaded &&
          viajesIds == other.viajesIds &&
          pesoAssigned == other.pesoAssigned &&
          deficit == other.deficit);

  @override
  int get hashCode =>
      productId.hashCode ^
      productName.hashCode ^
      pesoTotal.hashCode ^
      pesoUnloaded.hashCode ^
      viajesIds.hashCode ^
      pesoAssigned.hashCode ^
      deficit.hashCode;

  @override
  String toString() {
    return 'VesselProductModel{' +
        ' productId: $productId,' +
        ' productName: $productName,' +
        ' pesoTotal: $pesoTotal,' +
        ' pesoUnloaded: $pesoUnloaded,' +
        ' viajesIds: $viajesIds,' +
        ' pesoAssigned: $pesoAssigned,' +
        ' deficit: $deficit,' +
        '}';
  }

  VesselProductModel copyWith({
    String? productId,
    String? productName,
    double? pesoTotal,
    double? pesoUnloaded,
    List<String>? viajesIds,
    double? pesoAssigned,
    double? deficit,
  }) {
    return VesselProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      pesoTotal: pesoTotal ?? this.pesoTotal,
      pesoUnloaded: pesoUnloaded ?? this.pesoUnloaded,
      viajesIds: viajesIds ?? this.viajesIds,
      pesoAssigned: pesoAssigned ?? this.pesoAssigned,
      deficit: deficit ?? this.deficit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'productName': this.productName,
      'pesoTotal': this.pesoTotal,
      'pesoUnloaded': this.pesoUnloaded,
      'viajesIds': this.viajesIds.map((e) => e.toString()).toList(),
      'pesoAssigned': this.pesoAssigned,
      'deficit': this.deficit,
    };
  }

  factory VesselProductModel.fromMap(Map<String, dynamic> map) {
    return VesselProductModel(
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      pesoTotal: (map['pesoTotal'] as num).toDouble(),
      pesoUnloaded: (map['pesoUnloaded'] as num).toDouble(),
      viajesIds: (map['viajesIds'] as List<dynamic>).cast<String>(),
      pesoAssigned: (map['pesoAssigned'] as num).toDouble(),
      deficit: (map['deficit'] as num).toDouble(),
    );
  }

//</editor-fold>
}
