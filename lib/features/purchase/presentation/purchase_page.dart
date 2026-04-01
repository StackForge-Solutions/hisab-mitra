import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_formatters.dart';
import '../../../core/widgets/app_scaffold_wrapper.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/summary_card.dart';
import '../../../routes/app_router.dart';
import '../../../services/providers.dart';

class PurchasePage extends ConsumerWidget {
  const PurchasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uploadedBill = ref.watch(
      invoiceFlowControllerProvider.select((state) => state.uploadedBill),
    );
    final invoice = ref.watch(
      invoiceFlowControllerProvider.select((state) => state.invoice),
    );

    return AppScaffoldWrapper(
      title: 'Purchase',
      subtitle:
          'Review supplier bills, parse invoices, and confirm stock inward.',
      actions: [
        IconButton(
          onPressed: () => context.push(AppRoutes.uploadBill),
          icon: const Icon(Icons.upload_file_rounded),
          tooltip: 'Upload Bill',
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              SizedBox(
                width: 170,
                child: SummaryCard(
                  title: 'Pending preview',
                  value: uploadedBill == null ? '0' : '1',
                  caption: uploadedBill?.fileName ?? 'No bill selected yet',
                  icon: Icons.document_scanner_outlined,
                ),
              ),
              SizedBox(
                width: 170,
                child: SummaryCard(
                  title: 'Parsed total',
                  value: invoice == null
                      ? AppFormatters.currency(0)
                      : AppFormatters.currency(invoice.grandTotal),
                  caption: 'Ready after OCR mock parsing',
                  icon: Icons.calculate_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Purchase workflow',
            subtitle:
                'Use the top-right upload action to start the supplier bill flow.',
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(
                    label: 'Supplier',
                    value: invoice?.party.name ?? 'Awaiting parsed invoice',
                  ),
                  _InfoRow(
                    label: 'Invoice number',
                    value:
                        invoice?.invoiceNumber ?? 'Will populate after parsing',
                  ),
                  _InfoRow(
                    label: 'Invoice date',
                    value: invoice == null
                        ? 'Not parsed yet'
                        : AppFormatters.date(invoice.invoiceDate),
                  ),
                  _InfoRow(
                    label: 'Place of supply',
                    value: invoice?.placeOfSupply.label ?? 'Not parsed yet',
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How it works',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const _Checklist(
                    text: 'Open Upload Bill from the top-right action.',
                  ),
                  const _Checklist(
                    text: 'Preview the selected invoice before parsing begins.',
                  ),
                  const _Checklist(
                    text:
                        'Verify supplier, GST, line items, and totals on the parsed invoice page.',
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Checklist extends StatelessWidget {
  const _Checklist({required this.text, this.isLast = false});

  final String text;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            size: 18,
            color: Color(0xFF1F8F5F),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
