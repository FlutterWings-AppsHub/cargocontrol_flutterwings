// Used in Vessel Model and also in industry sub model
class VesselProductModel{
  final String productId;
  final String productName; // comma seperated // tipo; origen; variety; cosecha;
  final dynamic pesoTotal;
  final dynamic pesoUnloaded;

//<editor-fold desc="Data Methods">
  const VesselProductModel({
    required this.productId,
    required this.productName,
    required this.pesoTotal,
    required this.pesoUnloaded,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VesselProductModel &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          productName == other.productName &&
          pesoTotal == other.pesoTotal &&
          pesoUnloaded == other.pesoUnloaded);

  @override
  int get hashCode =>
      productId.hashCode ^
      productName.hashCode ^
      pesoTotal.hashCode ^
      pesoUnloaded.hashCode;

  @override
  String toString() {
    return 'VesselProductModel{' +
        ' productId: $productId,' +
        ' productName: $productName,' +
        ' pesoTotal: $pesoTotal,' +
        ' pesoUnloaded: $pesoUnloaded,' +
        '}';
  }

  VesselProductModel copyWith({
    String? productId,
    String? productName,
    dynamic? pesoTotal,
    dynamic? pesoUnloaded,
  }) {
    return VesselProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      pesoTotal: pesoTotal ?? this.pesoTotal,
      pesoUnloaded: pesoUnloaded ?? this.pesoUnloaded,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': this.productId,
      'productName': this.productName,
      'pesoTotal': this.pesoTotal,
      'pesoUnloaded': this.pesoUnloaded,
    };
  }

  factory VesselProductModel.fromMap(Map<String, dynamic> map) {
    return VesselProductModel(
      productId: map['productId'] as String,
      productName: map['productName'] as String,
      pesoTotal: map['pesoTotal'] as dynamic,
      pesoUnloaded: map['pesoUnloaded'] as dynamic,
    );
  }

//</editor-fold>
}