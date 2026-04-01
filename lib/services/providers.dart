import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/invoice_item_model.dart';
import '../models/party_model.dart';
import '../models/place_of_supply_model.dart';
import 'invoice_flow_controller.dart';
import 'invoice_flow_state.dart';
import 'mock_catalog_service.dart';
import 'mock_invoice_parsing_service.dart';
import 'mock_purchase_service.dart';

final mockCatalogServiceProvider = Provider<MockCatalogService>((ref) {
  return MockCatalogService();
});

final mockInvoiceParsingServiceProvider = Provider<MockInvoiceParsingService>((
  ref,
) {
  return MockInvoiceParsingService();
});

final mockPurchaseServiceProvider = Provider<MockPurchaseService>((ref) {
  return MockPurchaseService();
});

final suppliersProvider = Provider<List<PartyModel>>((ref) {
  return ref.watch(mockCatalogServiceProvider).getSuppliers();
});

final placesOfSupplyProvider = Provider<List<PlaceOfSupplyModel>>((ref) {
  return ref.watch(mockCatalogServiceProvider).getPlacesOfSupply();
});

final catalogItemsProvider = Provider<List<InvoiceItemModel>>((ref) {
  return ref.watch(mockCatalogServiceProvider).getItems();
});

final invoiceFlowControllerProvider =
    StateNotifierProvider<InvoiceFlowController, InvoiceFlowState>((ref) {
      return InvoiceFlowController(
        catalogService: ref.read(mockCatalogServiceProvider),
        parsingService: ref.read(mockInvoiceParsingServiceProvider),
        purchaseService: ref.read(mockPurchaseServiceProvider),
      );
    });
