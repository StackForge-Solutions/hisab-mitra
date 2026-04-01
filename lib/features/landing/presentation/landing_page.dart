import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_formatters.dart';
import '../../../core/widgets/app_scaffold_wrapper.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/summary_card.dart';
import '../../../routes/app_router.dart';
import '../../../services/providers.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowState = ref.watch(invoiceFlowControllerProvider);

    return AppScaffoldWrapper(
      title: 'Dashboard',
      subtitle: 'Good evening, manage pharmacy purchases and sales faster.',
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        onPressed: () => context.push(AppRoutes.salesTransaction),
        child: const Icon(Icons.add_rounded),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OverviewBanner(
            draftCount: flowState.draftCount,
            purchaseCount: flowState.purchaseCount,
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Today at a glance',
            subtitle:
                'Quick visibility across purchase checks, payable amount, and sales.',
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              SizedBox(
                width: 170,
                child: SummaryCard(
                  title: 'Purchase queue',
                  value: flowState.draftCount.toString(),
                  caption: 'Invoices saved as draft',
                  icon: Icons.drafts_outlined,
                ),
              ),
              SizedBox(
                width: 170,
                child: SummaryCard(
                  title: 'Purchases booked',
                  value: flowState.purchaseCount.toString(),
                  caption: 'Completed in this session',
                  icon: Icons.inventory_2_outlined,
                  color: const Color(0xFF0E7A51),
                ),
              ),
              SizedBox(
                width: 170,
                child: SummaryCard(
                  title: 'Expected payables',
                  value: AppFormatters.compactCurrency(28650),
                  caption: 'Mock daily total',
                  icon: Icons.account_balance_wallet_outlined,
                  color: const Color(0xFF3B8B68),
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          const SectionHeader(
            title: 'Quick actions',
            subtitle: 'Jump into the most common accounting workflows.',
          ),
          const SizedBox(height: 14),
          _ActionTile(
            title: 'Purchase',
            subtitle:
                'Upload a supplier bill, verify parsed data, and create a purchase entry.',
            icon: Icons.shopping_bag_outlined,
            accent: const Color(0xFF1F8F5F),
            onTap: () => context.push(AppRoutes.purchase),
          ),
          const SizedBox(height: 14),
          _ActionTile(
            title: 'Sales Transaction',
            subtitle:
                'Record a retail sale with customer details, item values, and invoice amount.',
            icon: Icons.point_of_sale_rounded,
            accent: const Color(0xFF2E6FBA),
            onTap: () => context.push(AppRoutes.salesTransaction),
          ),
          const SizedBox(height: 26),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent workflow',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const _MiniTimelineStep(
                    title: 'Bill preview ready',
                    subtitle:
                        'Uploaded invoice previews appear before parsing starts.',
                  ),
                  const _MiniTimelineStep(
                    title: 'OCR verification',
                    subtitle:
                        'Parsed invoice keeps party, GST, items, totals, and place editable.',
                  ),
                  const _MiniTimelineStep(
                    title: 'Finalize purchase',
                    subtitle:
                        'Create Purchase confirms completion after review.',
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

class _OverviewBanner extends StatelessWidget {
  const _OverviewBanner({
    required this.draftCount,
    required this.purchaseCount,
  });

  final int draftCount;
  final int purchaseCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF185A3E), Color(0xFF2F9A68)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22185A3E),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/branding/hisaab_mitra_logo.png',
                width: 46,
                height: 46,
                errorBuilder: (_, _, _) => const Icon(
                  Icons.health_and_safety_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'HisaabMitra',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Store balance looks healthy',
            style: theme.textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Drafts $draftCount • Purchases booked $purchaseCount • Next payment batch closes at 8:30 PM',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
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
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(icon, color: accent),
              ),
              const SizedBox(width: 16),
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
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniTimelineStep extends StatelessWidget {
  const _MiniTimelineStep({
    required this.title,
    required this.subtitle,
    this.isLast = false,
  });

  final String title;
  final String subtitle;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    color: theme.dividerColor,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
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
          ),
        ],
      ),
    );
  }
}
