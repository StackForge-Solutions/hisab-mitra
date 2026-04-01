import 'party_model.dart';
import 'place_of_supply_model.dart';
import 'invoice_item_model.dart';

class InvoiceModel {
  const InvoiceModel({
    required this.id,
    required this.party,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.placeOfSupply,
    required this.gstin,
    required this.items,
  });

  final String id;
  final PartyModel party;
  final String invoiceNumber;
  final DateTime invoiceDate;
  final PlaceOfSupplyModel placeOfSupply;
  final String gstin;
  final List<InvoiceItemModel> items;

  double get subtotal => items.fold(0, (sum, item) => sum + item.grossAmount);
  double get discountTotal => items.fold(0, (sum, item) => sum + item.discount);
  double get taxTotal => items.fold(0, (sum, item) => sum + item.taxAmount);
  double get grandTotal => items.fold(0, (sum, item) => sum + item.total);
  double get payableAmount => grandTotal;

  InvoiceModel copyWith({
    String? id,
    PartyModel? party,
    String? invoiceNumber,
    DateTime? invoiceDate,
    PlaceOfSupplyModel? placeOfSupply,
    String? gstin,
    List<InvoiceItemModel>? items,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      party: party ?? this.party,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      placeOfSupply: placeOfSupply ?? this.placeOfSupply,
      gstin: gstin ?? this.gstin,
      items: items ?? this.items,
    );
  }
}
