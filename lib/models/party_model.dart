class PartyModel {
  const PartyModel({
    required this.id,
    required this.name,
    required this.gstin,
    required this.address,
    required this.city,
    required this.phone,
  });

  final String id;
  final String name;
  final String gstin;
  final String address;
  final String city;
  final String phone;

  String get subtitle => '$city • GSTIN $gstin';
}
