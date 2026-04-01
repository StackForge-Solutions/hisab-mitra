import '../models/invoice_model.dart';
import '../models/uploaded_bill_model.dart';

enum SubmissionStatus { idle, savingDraft, creatingPurchase }

class InvoiceFlowState {
  const InvoiceFlowState({
    this.uploadedBill,
    this.invoice,
    this.submissionStatus = SubmissionStatus.idle,
    this.draftCount = 0,
    this.purchaseCount = 0,
  });

  final UploadedBillModel? uploadedBill;
  final InvoiceModel? invoice;
  final SubmissionStatus submissionStatus;
  final int draftCount;
  final int purchaseCount;

  bool get isBusy => submissionStatus != SubmissionStatus.idle;

  InvoiceFlowState copyWith({
    UploadedBillModel? uploadedBill,
    bool clearUploadedBill = false,
    InvoiceModel? invoice,
    bool clearInvoice = false,
    SubmissionStatus? submissionStatus,
    int? draftCount,
    int? purchaseCount,
  }) {
    return InvoiceFlowState(
      uploadedBill: clearUploadedBill
          ? null
          : uploadedBill ?? this.uploadedBill,
      invoice: clearInvoice ? null : invoice ?? this.invoice,
      submissionStatus: submissionStatus ?? this.submissionStatus,
      draftCount: draftCount ?? this.draftCount,
      purchaseCount: purchaseCount ?? this.purchaseCount,
    );
  }
}
