class PlaceOfSupplyModel {
  const PlaceOfSupplyModel({required this.code, required this.name});

  final String code;
  final String name;

  String get label => '$name ($code)';
}
