import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hisaab_mitra/core/constants/app_constants.dart';
import 'package:hisaab_mitra/features/parsed_invoice/presentation/parsed_invoice_page.dart';
import 'package:hisaab_mitra/main.dart';
import 'package:hisaab_mitra/models/invoice_item_model.dart';
import 'package:hisaab_mitra/models/invoice_model.dart';
import 'package:hisaab_mitra/models/party_model.dart';
import 'package:hisaab_mitra/models/place_of_supply_model.dart';
import 'package:hisaab_mitra/services/invoice_flow_controller.dart';
import 'package:hisaab_mitra/services/invoice_flow_state.dart';
import 'package:hisaab_mitra/services/mock_catalog_service.dart';
import 'package:hisaab_mitra/services/mock_invoice_parsing_service.dart';
import 'package:hisaab_mitra/services/mock_purchase_service.dart';
import 'package:hisaab_mitra/services/providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('app flow', () {
    testWidgets('launches through splash and preload into dashboard', (
      tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: HisaabMitraApp()));

      expect(find.text(AppConstants.appName), findsOneWidget);
      expect(find.textContaining('Secure pharmacy purchases'), findsOneWidget);

      await tester.pump(AppConstants.splashDelay);
      await tester.pump();
      expect(find.text('Preparing workspace'), findsOneWidget);

      await tester.pump(AppConstants.preloadDelay);
      await tester.pumpAndSettle();

      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Purchase'), findsOneWidget);
      expect(find.text('Sales Transaction'), findsOneWidget);
    });

    testWidgets('dashboard actions navigate to purchase and upload bill', (
      tester,
    ) async {
      await tester.pumpWidget(const ProviderScope(child: HisaabMitraApp()));
      await tester.pump(AppConstants.splashDelay + AppConstants.preloadDelay);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Purchase').first);
      await tester.pumpAndSettle();

      expect(find.text('Purchase workflow'), findsOneWidget);
      expect(find.byIcon(Icons.upload_file_rounded), findsOneWidget);

      await tester.tap(find.byIcon(Icons.upload_file_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Upload Bill'), findsOneWidget);
      expect(find.text('Continue to Preview'), findsOneWidget);
    });

    testWidgets('sales fab opens sales transaction page', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: HisaabMitraApp()));
      await tester.pump(AppConstants.splashDelay + AppConstants.preloadDelay);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('Sales entry'), findsOneWidget);
      expect(find.text('Save Sale'), findsOneWidget);
    });
  });

  group('parsed invoice', () {
    testWidgets('renders seeded invoice and saves draft', (tester) async {
      final controller = _SeededInvoiceFlowController(_seededState());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            invoiceFlowControllerProvider.overrideWith((ref) => controller),
          ],
          child: MaterialApp(
            home: const ParsedInvoicePage(),
            theme: ThemeData(useMaterial3: true),
          ),
        ),
      );

      expect(find.text('Parsed Invoice'), findsOneWidget);
      expect(find.text('Sunrise Pharma Distributors'), findsOneWidget);
      expect(find.text('PUR-2026-0418'), findsOneWidget);
      expect(find.text('Paracetamol 650mg Tablets'), findsOneWidget);
      expect(find.text('Payable amount'), findsOneWidget);

      await tester.tap(find.text('Save Draft'));
      await tester.pump(const Duration(milliseconds: 950));
      await tester.pumpAndSettle();

      expect(find.text('Draft saved locally'), findsOneWidget);
    });
  });
}

InvoiceFlowState _seededState() {
  const party = PartyModel(
    id: 'party_1',
    name: 'Sunrise Pharma Distributors',
    gstin: '27AABCU9603R1ZX',
    address: '14 Wholesale Medicine Market',
    city: 'Mumbai',
    phone: '+91 98765 23001',
  );
  const place = PlaceOfSupplyModel(code: '27', name: 'Maharashtra');
  const items = [
    InvoiceItemModel(
      id: 'item_1',
      name: 'Paracetamol 650mg Tablets',
      sku: 'PCM650',
      hsnCode: '30049069',
      quantity: 24,
      unit: 'Strip',
      rate: 36,
      discount: 22,
      taxPercent: 12,
    ),
    InvoiceItemModel(
      id: 'item_2',
      name: 'Omeprazole 20mg Capsules',
      sku: 'OMP20',
      hsnCode: '30049099',
      quantity: 14,
      unit: 'Box',
      rate: 78,
      discount: 16,
      taxPercent: 12,
    ),
  ];

  return InvoiceFlowState(
    invoice: InvoiceModel(
      id: 'inv_seeded',
      party: party,
      invoiceNumber: 'PUR-2026-0418',
      invoiceDate: DateTime(2026, 3, 28),
      placeOfSupply: place,
      gstin: party.gstin,
      items: items,
    ),
  );
}

class _SeededInvoiceFlowController extends InvoiceFlowController {
  _SeededInvoiceFlowController(InvoiceFlowState initial)
    : super(
        catalogService: MockCatalogService(),
        parsingService: MockInvoiceParsingService(),
        purchaseService: MockPurchaseService(),
      ) {
    state = initial;
  }
}
