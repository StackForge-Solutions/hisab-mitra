import '../models/invoice_model.dart';

class MockPurchaseService {
  final List<InvoiceModel> _drafts = <InvoiceModel>[];
  final List<InvoiceModel> _purchases = <InvoiceModel>[];

  Future<String> saveDraft(InvoiceModel invoice) async {
    await Future<void>.delayed(const Duration(milliseconds: 900));
    _drafts.removeWhere((draft) => draft.id == invoice.id);
    _drafts.add(invoice);
    return 'Draft saved locally';
  }

  Future<String> createPurchase(InvoiceModel invoice) async {
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    _purchases.add(invoice);
    return 'Purchase created successfully';
  }

  int get draftCount => _drafts.length;
  int get purchaseCount => _purchases.length;
}
