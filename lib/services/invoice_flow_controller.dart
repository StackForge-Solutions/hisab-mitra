import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/app_formatters.dart';
import '../models/invoice_item_model.dart';
import '../models/invoice_model.dart';
import '../models/party_model.dart';
import '../models/place_of_supply_model.dart';
import '../models/uploaded_bill_model.dart';
import 'invoice_flow_state.dart';
import 'mock_catalog_service.dart';
import 'mock_invoice_parsing_service.dart';
import 'mock_purchase_service.dart';

class InvoiceFlowController extends StateNotifier<InvoiceFlowState> {
  InvoiceFlowController({
    required MockCatalogService catalogService,
    required MockInvoiceParsingService parsingService,
    required MockPurchaseService purchaseService,
  }) : _catalogService = catalogService,
       _parsingService = parsingService,
       _purchaseService = purchaseService,
       super(const InvoiceFlowState());

  final MockCatalogService _catalogService;
  final MockInvoiceParsingService _parsingService;
  final MockPurchaseService _purchaseService;

  void selectUploadedBill(UploadedBillModel bill) {
    state = state.copyWith(uploadedBill: bill, clearInvoice: true);
  }

  Future<void> parseUploadedBill() async {
    final bill = state.uploadedBill;
    if (bill == null) {
      return;
    }

    final invoice = await _parsingService.parseInvoice(
      uploadedBill: bill,
      suppliers: _catalogService.getSuppliers(),
      places: _catalogService.getPlacesOfSupply(),
      catalogItems: _catalogService.getItems(),
    );

    state = state.copyWith(invoice: invoice);
  }

  void updateInvoiceNumber(String value) {
    _updateInvoice((invoice) => invoice.copyWith(invoiceNumber: value));
  }

  void updateInvoiceDate(DateTime value) {
    _updateInvoice((invoice) => invoice.copyWith(invoiceDate: value));
  }

  void updateParty(PartyModel party) {
    _updateInvoice(
      (invoice) => invoice.copyWith(party: party, gstin: party.gstin),
    );
  }

  void updatePlaceOfSupply(PlaceOfSupplyModel place) {
    _updateInvoice((invoice) => invoice.copyWith(placeOfSupply: place));
  }

  void replaceItem(int index, InvoiceItemModel newItem) {
    _updateItems((items) {
      final updated = [...items];
      if (index >= 0 && index < updated.length) {
        updated[index] = newItem;
      }
      return updated;
    });
  }

  void addItem(InvoiceItemModel item) {
    _updateItems((items) => [...items, item]);
  }

  void removeItem(int index) {
    _updateItems((items) {
      final updated = [...items]..removeAt(index);
      return updated;
    });
  }

  void updateItemQuantity(int index, double quantity) {
    _updateSingleItem(index, (item) => item.copyWith(quantity: quantity));
  }

  void updateItemRate(int index, double rate) {
    _updateSingleItem(index, (item) => item.copyWith(rate: rate));
  }

  void updateItemUnit(int index, String unit) {
    _updateSingleItem(index, (item) => item.copyWith(unit: unit));
  }

  void updateItemDiscount(int index, double discount) {
    _updateSingleItem(index, (item) => item.copyWith(discount: discount));
  }

  void updateItemTax(int index, double taxPercent) {
    _updateSingleItem(index, (item) => item.copyWith(taxPercent: taxPercent));
  }

  Future<String> saveDraft() async {
    final invoice = state.invoice;
    if (invoice == null) {
      return 'No invoice available to save';
    }

    state = state.copyWith(submissionStatus: SubmissionStatus.savingDraft);
    final message = await _purchaseService.saveDraft(invoice);
    state = state.copyWith(
      submissionStatus: SubmissionStatus.idle,
      draftCount: _purchaseService.draftCount,
    );
    return message;
  }

  Future<String> createPurchase() async {
    final invoice = state.invoice;
    if (invoice == null) {
      return 'No invoice available to create';
    }

    state = state.copyWith(submissionStatus: SubmissionStatus.creatingPurchase);
    final message = await _purchaseService.createPurchase(invoice);
    state = state.copyWith(
      submissionStatus: SubmissionStatus.idle,
      purchaseCount: _purchaseService.purchaseCount,
    );
    return message;
  }

  void _updateSingleItem(
    int index,
    InvoiceItemModel Function(InvoiceItemModel item) mapper,
  ) {
    _updateItems((items) {
      final updated = [...items];
      if (index >= 0 && index < updated.length) {
        updated[index] = mapper(updated[index]);
      }
      return updated;
    });
  }

  void _updateItems(
    List<InvoiceItemModel> Function(List<InvoiceItemModel> items) transform,
  ) {
    _updateInvoice(
      (invoice) => invoice.copyWith(items: transform(invoice.items)),
    );
  }

  void _updateInvoice(InvoiceModel Function(InvoiceModel invoice) mapper) {
    final invoice = state.invoice;
    if (invoice == null) {
      return;
    }
    state = state.copyWith(invoice: mapper(invoice));
  }

  String itemAmountLabel(InvoiceItemModel item) =>
      AppFormatters.currency(item.total);
}
