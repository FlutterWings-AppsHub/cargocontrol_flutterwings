import 'package:flutter/material.dart';
class NumberPlateModel{
  final String plateNo;
  final String model;
  final String color;
  final Map<String, dynamic> searchTags;

//<editor-fold desc="Data Methods">
  const NumberPlateModel({
    required this.plateNo,
    required this.model,
    required this.color,
    required this.searchTags,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NumberPlateModel &&
          runtimeType == other.runtimeType &&
          plateNo == other.plateNo &&
          model == other.model &&
          searchTags == other.searchTags &&
          color == other.color);

  @override
  int get hashCode => plateNo.hashCode ^ model.hashCode ^ color.hashCode;

  @override
  String toString() {
    return 'NumberPlateModel{' +
        ' plateNo: $plateNo,' +
        ' model: $model,' +
        ' color: $color,' +
        ' searchTags: $searchTags,' +
        '}';
  }

  NumberPlateModel copyWith({
    String? plateNo,
    String? model,
    String? color,
    Map<String, dynamic>? searchTags,
  }) {
    return NumberPlateModel(
      plateNo: plateNo ?? this.plateNo,
      model: model ?? this.model,
      color: color ?? this.color,
      searchTags: searchTags ?? this.searchTags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'plateNo': this.plateNo,
      'model': this.model,
      'color': this.color,
      'searchTags': this.searchTags,
    };
  }

  factory NumberPlateModel.fromMap(Map<String, dynamic> map) {
    return NumberPlateModel(
      plateNo: map['plateNo'] as String,
      model: map['model'] as String,
      color: map['color'] as String,
      searchTags: map['searchTags'] as Map<String, dynamic>,
    );
  }

//</editor-fold>
}