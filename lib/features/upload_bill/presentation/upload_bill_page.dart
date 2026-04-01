import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_formatters.dart';
import '../../../core/widgets/app_scaffold_wrapper.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_header.dart';
import '../../../models/uploaded_bill_model.dart';
import '../../../routes/app_router.dart';
import '../../../services/providers.dart';

class UploadBillPage extends ConsumerWidget {
  const UploadBillPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBill = ref.watch(
      invoiceFlowControllerProvider.select((state) => state.uploadedBill),
    );
    final notifier = ref.read(invoiceFlowControllerProvider.notifier);

    return AppScaffoldWrapper(
      title: 'Upload Bill',
      subtitle:
          'Choose a bill source. The file picker behavior is mocked for this demo.',
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: PrimaryButton(
          label: 'Continue to Preview',
          icon: Icons.visibility_outlined,
          onPressed: selectedBill == null
              ? null
              : () => context.push(AppRoutes.billPreview),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Select source',
            subtitle:
                'Simulate a bill upload from files, gallery, or the camera.',
          ),
          const SizedBox(height: 14),
          _UploadSourceCard(
            title: 'Pick from gallery',
            subtitle:
                'Use existing scanned bills or medicine distributor snapshots.',
            icon: Icons.photo_library_outlined,
            onTap: () => notifier.selectUploadedBill(
              _mockBill(UploadedBillSource.gallery),
            ),
          ),
          const SizedBox(height: 12),
          _UploadSourceCard(
            title: 'Pick from files',
            subtitle: 'Use PDF or image bills from your device storage.',
            icon: Icons.folder_open_rounded,
            onTap: () => notifier.selectUploadedBill(
              _mockBill(UploadedBillSource.files),
            ),
          ),
          const SizedBox(height: 12),
          _UploadSourceCard(
            title: 'Capture with camera',
            subtitle: 'Simulate taking a live photo of the supplier bill.',
            icon: Icons.camera_alt_outlined,
            onTap: () => notifier.selectUploadedBill(
              _mockBill(UploadedBillSource.camera),
            ),
          ),
          const SizedBox(height: 20),
          if (selectedBill != null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selected bill',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      selectedBill.fileName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${selectedBill.fileSizeLabel} • ${selectedBill.sourceLabel} • ${AppFormatters.dateTime(selectedBill.uploadedAt)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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

  UploadedBillModel _mockBill(UploadedBillSource source) {
    switch (source) {
      case UploadedBillSource.gallery:
        return UploadedBillModel(
          id: 'gallery_001',
          fileName: 'sunrise_invoice_mar28.jpg',
          fileSizeLabel: '2.4 MB',
          source: source,
          uploadedAt: DateTime(2026, 3, 31, 10, 42),
        );
      case UploadedBillSource.files:
        return UploadedBillModel(
          id: 'file_001',
          fileName: 'purchase_bill_sunrise_q1.pdf',
          fileSizeLabel: '1.1 MB',
          source: source,
          uploadedAt: DateTime(2026, 3, 31, 11, 15),
        );
      case UploadedBillSource.camera:
        return UploadedBillModel(
          id: 'camera_001',
          fileName: 'captured_bill_20260331.png',
          fileSizeLabel: '3.0 MB',
          source: source,
          uploadedAt: DateTime(2026, 3, 31, 12, 5),
        );
    }
  }
}

class _UploadSourceCard extends StatelessWidget {
  const _UploadSourceCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
