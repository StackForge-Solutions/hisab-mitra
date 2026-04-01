import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_formatters.dart';
import '../../../core/widgets/app_scaffold_wrapper.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../routes/app_router.dart';
import '../../../services/providers.dart';

class BillPreviewPage extends ConsumerWidget {
  const BillPreviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bill = ref.watch(
      invoiceFlowControllerProvider.select((state) => state.uploadedBill),
    );

    return AppScaffoldWrapper(
      title: 'Bill Preview',
      subtitle: 'Review the selected bill before parsing the invoice details.',
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Row(
          children: [
            Expanded(
              child: SecondaryButton(
                label: 'Back',
                icon: Icons.arrow_back_rounded,
                onPressed: () => context.pop(),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: PrimaryButton(
                label: 'Proceed',
                icon: Icons.play_arrow_rounded,
                onPressed: bill == null
                    ? null
                    : () => context.push(AppRoutes.parsing),
              ),
            ),
          ],
        ),
      ),
      child: bill == null
          ? EmptyStateView(
              title: 'No uploaded bill found',
              message:
                  'Select a mock bill first, then return here to preview it.',
              action: PrimaryButton(
                label: 'Go to Upload Bill',
                icon: Icons.upload_file_rounded,
                onPressed: () => context.go(AppRoutes.uploadBill),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 360,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFF5FBF7), Color(0xFFE5F2EA)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Supplier Tax Invoice',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w800,
                                            ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Sunrise Pharma Distributors',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Divider(height: 30),
                                      const _PreviewLine(
                                        text:
                                            'Paracetamol 650mg Tablets         Qty 24',
                                      ),
                                      const _PreviewLine(
                                        text:
                                            'Omeprazole 20mg Capsules         Qty 14',
                                      ),
                                      const _PreviewLine(
                                        text:
                                            'ORS Sachet Orange Flavour        Qty 30',
                                      ),
                                      const Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF1F8F5F),
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                          child: const Text(
                                            'Mock preview',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          bill.fileName,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${bill.fileSizeLabel} • ${bill.sourceLabel} • ${AppFormatters.dateTime(bill.uploadedAt)}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
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

class _PreviewLine extends StatelessWidget {
  const _PreviewLine({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontFeatures: const [FontFeature.tabularFigures()],
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
