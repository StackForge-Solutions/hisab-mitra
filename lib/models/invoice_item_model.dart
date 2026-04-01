class InvoiceItemModel {
  const InvoiceItemModel({
    required this.id,
    required this.name,
    required this.sku,
    required this.hsnCode,
    required this.quantity,
    required this.unit,
    required this.rate,
    required this.discount,
    required this.taxPercent,
  });

  final String id;
  final String name;
  final String sku;
  final String hsnCode;
  final double quantity;
  final String unit;
  final double rate;
  final double discount;
  final double taxPercent;

  double get grossAmount => quantity * rate;
  double get taxableAmount =>
      (grossAmount - discount).clamp(0, double.infinity);
  double get taxAmount => taxableAmount * taxPercent / 100;
  double get total => taxableAmount + taxAmount;

  InvoiceItemModel copyWith({
    String? id,
    String? name,
    String? sku,
    String? hsnCode,
    double? quantity,
    String? unit,
    double? rate,
    double? discount,
    double? taxPercent,
  }) {
    return InvoiceItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      hsnCode: hsnCode ?? this.hsnCode,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      rate: rate ?? this.rate,
      discount: discount ?? this.discount,
      taxPercent: taxPercent ?? this.taxPercent,
    );
  }
}
