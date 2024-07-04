class DeleteAccountOptionModel{
  final bool showDeleteOption;

//<editor-fold desc="Data Methods">
  const DeleteAccountOptionModel({
    required this.showDeleteOption,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeleteAccountOptionModel &&
          runtimeType == other.runtimeType &&
          showDeleteOption == other.showDeleteOption);

  @override
  int get hashCode => showDeleteOption.hashCode;

  @override
  String toString() {
    return 'DeleteAccountOptionModel{' +
        ' showDeleteOption: $showDeleteOption,' +
        '}';
  }

  DeleteAccountOptionModel copyWith({
    bool? showDeleteOption,
  }) {
    return DeleteAccountOptionModel(
      showDeleteOption: showDeleteOption ?? this.showDeleteOption,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'showDeleteOption': this.showDeleteOption,
    };
  }

  factory DeleteAccountOptionModel.fromMap(Map<String, dynamic> map) {
    return DeleteAccountOptionModel(
      showDeleteOption: map['showDeleteOption'] as bool,
    );
  }

//</editor-fold>
}