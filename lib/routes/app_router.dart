import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/bill_preview/presentation/bill_preview_page.dart';
import '../features/change_item/presentation/change_item_page.dart';
import '../features/change_party/presentation/change_party_page.dart';
import '../features/landing/presentation/landing_page.dart';
import '../features/parsed_invoice/presentation/parsed_invoice_page.dart';
import '../features/parsing/presentation/parsing_loader_page.dart';
import '../features/place_of_supply/presentation/place_of_supply_page.dart';
import '../features/preload/presentation/preload_screen.dart';
import '../features/purchase/presentation/purchase_page.dart';
import '../features/sales_transaction/presentation/sales_transaction_page.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/upload_bill/presentation/upload_bill_page.dart';

class AppRoutes {
  const AppRoutes._();

  static const splash = '/';
  static const preload = '/preload';
  static const landing = '/landing';
  static const salesTransaction = '/sales-transaction';
  static const purchase = '/purchase';
  static const uploadBill = '/upload-bill';
  static const billPreview = '/bill-preview';
  static const parsing = '/parsing';
  static const parsedInvoice = '/parsed-invoice';
  static const placeOfSupply = '/place-of-supply';
  static const changeParty = '/change-party';
  static const changeItem = '/change-item';
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.preload,
        builder: (context, state) => const PreloadScreen(),
      ),
      GoRoute(
        path: AppRoutes.landing,
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: AppRoutes.salesTransaction,
        builder: (context, state) => const SalesTransactionPage(),
      ),
      GoRoute(
        path: AppRoutes.purchase,
        builder: (context, state) => const PurchasePage(),
      ),
      GoRoute(
        path: AppRoutes.uploadBill,
        builder: (context, state) => const UploadBillPage(),
      ),
      GoRoute(
        path: AppRoutes.billPreview,
        builder: (context, state) => const BillPreviewPage(),
      ),
      GoRoute(
        path: AppRoutes.parsing,
        builder: (context, state) => const ParsingLoaderPage(),
      ),
      GoRoute(
        path: AppRoutes.parsedInvoice,
        builder: (context, state) => const ParsedInvoicePage(),
      ),
      GoRoute(
        path: AppRoutes.placeOfSupply,
        builder: (context, state) => const PlaceOfSupplyPage(),
      ),
      GoRoute(
        path: AppRoutes.changeParty,
        builder: (context, state) => const ChangePartyPage(),
      ),
      GoRoute(
        path: AppRoutes.changeItem,
        builder: (context, state) =>
            ChangeItemPage(itemIndex: state.extra as int? ?? -1),
      ),
    ],
  );
});
