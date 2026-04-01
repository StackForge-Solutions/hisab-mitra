import '../core/constants/app_constants.dart';
import '../models/invoice_item_model.dart';
import '../models/invoice_model.dart';
import '../models/party_model.dart';
import '../models/place_of_supply_model.dart';
import '../models/uploaded_bill_model.dart';

class MockInvoiceParsingService {
  Future<InvoiceModel> parseInvoice({
    required UploadedBillModel uploadedBill,
    required List<PartyModel> suppliers,
    required List<PlaceOfSupplyModel> places,
    required List<InvoiceItemModel> catalogItems,
  }) async {
    await Future<void>.delayed(AppConstants.parsingDelay);

    final parsedItems = [
      catalogItems[0].copyWith(
        quantity: 24,
        rate: 36,
        discount: 22,
        taxPercent: 12,
      ),
      catalogItems[2].copyWith(
        quantity: 14,
        rate: 78,
        discount: 16,
        taxPercent: 12,
      ),
      catalogItems[5].copyWith(
        quantity: 30,
        rate: 19,
        discount: 10,
        taxPercent: 5,
      ),
    ];

    return InvoiceModel(
      id: 'inv_${uploadedBill.id}',
      party: suppliers[0],
      invoiceNumber: 'PUR-2026-0418',
      invoiceDate: DateTime(2026, 3, 28),
      placeOfSupply: places[0],
      gstin: suppliers[0].gstin,
      items: parsedItems,
    );
  }
}
