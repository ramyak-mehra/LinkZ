class HelperClassDefination {
  final dynamic dartType;
  final String fieldName;

  HelperClassDefination(
    this.dartType,
    this.fieldName,
  );

  @override
  String toString() => '$dartType  $fieldName';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HelperClassDefination &&
        other.dartType == dartType &&
        other.fieldName == fieldName;
  }

  @override
  int get hashCode => dartType.hashCode ^ fieldName.hashCode;
}
