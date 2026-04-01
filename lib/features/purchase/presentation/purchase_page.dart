import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_scaffold_wrapper.dart';
import '../../../routes/app_router.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({super.key});

  static const Color _pageBackground = Color(0xFFF7F8FC);
  static const Color _purchaseAccent = Color(0xFF3F63F3);
  static const Color _salesAccent = Color(0xFF25975E);
  static const Color _expenseAccent = Color(0xFFE07A58);
  static const Color _warningAccent = Color(0xFFCC9A2F);

  @override
  Widget build(BuildContext context) {
    final quickActions = [
      _QuickActionData(
        title: 'Purchase bill',
        subtitle: 'Upload or capture a supplier bill and continue to parsing.',
        icon: Icons.receipt_long_rounded,
        accentColor: _purchaseAccent,
        surfaceColor: const Color(0xFFF3F5FF),
        onTap: () => context.push(AppRoutes.uploadBill),
      ),
      _QuickActionData(
        title: 'Scan supplier bill',
        subtitle: 'Use the camera or gallery when the bill is already on hand.',
        icon: Icons.document_scanner_outlined,
        accentColor: _purchaseAccent,
        surfaceColor: const Color(0xFFF4F7FF),
        onTap: () => context.push(AppRoutes.uploadBill),
      ),
      _QuickActionData(
        title: 'Sales invoice',
        subtitle:
            'Create a quick sales transaction for a walk-in or counter sale.',
        icon: Icons.point_of_sale_rounded,
        accentColor: _salesAccent,
        surfaceColor: const Color(0xFFF2FBF5),
        onTap: () => context.push(AppRoutes.salesTransaction),
      ),
      _QuickActionData(
        title: 'Received payment',
        subtitle:
            'Open the sales flow to capture an incoming customer payment.',
        icon: Icons.payments_outlined,
        accentColor: _salesAccent,
        surfaceColor: const Color(0xFFF2FBF5),
        onTap: () => context.push(AppRoutes.salesTransaction),
      ),
    ];

    return Theme(
      data: Theme.of(
        context,
      ).copyWith(scaffoldBackgroundColor: _pageBackground),
      child: AppScaffoldWrapper(
        title: 'Create Transaction',
        subtitle:
            'Start with the most common sales and purchase flows, then open secondary shortcuts only when you need them.',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _OverviewBanner(),
            const SizedBox(height: 24),
            const _ColorSectionHeader(
              title: 'Most used',
              subtitle:
                  'These are the four actions your team is most likely to use day to day.',
              accentColor: _purchaseAccent,
            ),
            const SizedBox(height: 14),
            _QuickActionsGrid(actions: quickActions),
            const SizedBox(height: 24),
            const _ColorSectionHeader(
              title: 'Purchase shortcuts',
              subtitle:
                  'Supplier-side actions stay grouped together so the purchase flow feels predictable.',
              accentColor: _purchaseAccent,
            ),
            const SizedBox(height: 12),
            _ShortcutGroupCard(
              tintColor: const Color(0xFFF6F7FF),
              borderColor: const Color(0xFFDCE3FF),
              items: [
                _ShortcutItemData(
                  title: 'Payment out',
                  subtitle: 'Register a supplier payment or settlement.',
                  icon: Icons.outbox_outlined,
                  accentColor: _purchaseAccent,
                ),
                _ShortcutItemData(
                  title: 'Purchase return',
                  subtitle: 'Record returned stock against a supplier bill.',
                  icon: Icons.assignment_return_outlined,
                  accentColor: _purchaseAccent,
                ),
                _ShortcutItemData(
                  title: 'Debit note',
                  subtitle:
                      'Adjust supplier dues for damage or pricing issues.',
                  icon: Icons.note_add_outlined,
                  accentColor: _purchaseAccent,
                ),
                _ShortcutItemData(
                  title: 'Purchase order',
                  subtitle: 'Prepare a supplier order before the bill arrives.',
                  icon: Icons.assignment_outlined,
                  accentColor: _purchaseAccent,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const _ColorSectionHeader(
              title: 'Sales shortcuts',
              subtitle:
                  'Keep less-frequent sales documents available without giving them the same visual weight as the main flows.',
              accentColor: _salesAccent,
            ),
            const SizedBox(height: 12),
            _ShortcutGroupCard(
              tintColor: const Color(0xFFF3FBF6),
              borderColor: const Color(0xFFD7EEDF),
              items: [
                _ShortcutItemData(
                  title: 'Sales return',
                  subtitle:
                      'Create a return entry for customer stock coming back.',
                  icon: Icons.keyboard_return_rounded,
                  accentColor: _salesAccent,
                ),
                _ShortcutItemData(
                  title: 'Credit note',
                  subtitle:
                      'Issue a credit note against an earlier sales bill.',
                  icon: Icons.note_alt_outlined,
                  accentColor: _salesAccent,
                ),
                _ShortcutItemData(
                  title: 'Quotation / estimate',
                  subtitle: 'Prepare a shareable quote before invoicing.',
                  icon: Icons.request_quote_outlined,
                  accentColor: _salesAccent,
                ),
                _ShortcutItemData(
                  title: 'Delivery challan',
                  subtitle:
                      'Create a dispatch note for goods leaving the store.',
                  icon: Icons.local_shipping_outlined,
                  accentColor: _salesAccent,
                ),
                _ShortcutItemData(
                  title: 'Proforma invoice',
                  subtitle: 'Share a draft invoice before confirming the sale.',
                  icon: Icons.description_outlined,
                  accentColor: _salesAccent,
                  statusLabel: 'Pro',
                  statusColor: _warningAccent,
                ),
                _ShortcutItemData(
                  title: 'Automated bill',
                  subtitle:
                      'Use the premium billing shortcut for repeated invoice patterns.',
                  icon: Icons.auto_mode_outlined,
                  accentColor: _salesAccent,
                  statusLabel: 'Pro',
                  statusColor: _warningAccent,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const _ColorSectionHeader(
              title: 'Other',
              subtitle:
                  'Separate operational entries from core billing so this page stays easier to scan.',
              accentColor: _expenseAccent,
            ),
            const SizedBox(height: 12),
            _ShortcutGroupCard(
              tintColor: const Color(0xFFFFF6F1),
              borderColor: const Color(0xFFF3DDCF),
              items: [
                _ShortcutItemData(
                  title: 'Expense',
                  subtitle:
                      'Capture a daily business expense or pharmacy overhead.',
                  icon: Icons.account_balance_wallet_outlined,
                  accentColor: _expenseAccent,
                ),
                _ShortcutItemData(
                  title: 'Counter',
                  subtitle:
                      'Open a faster counter-only workflow for very quick billing.',
                  icon: Icons.storefront_outlined,
                  accentColor: _warningAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewBanner extends StatelessWidget {
  const _OverviewBanner();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF4064F4), Color(0xFF7692FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F3253D8),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _BannerChip(
                label: 'Purchase',
                icon: Icons.shopping_bag_outlined,
                color: const Color(0xFFF5F7FF),
                foregroundColor: const Color(0xFF3253D8),
              ),
              const SizedBox(width: 8),
              _BannerChip(
                label: 'Sales',
                icon: Icons.point_of_sale_rounded,
                color: const Color(0x332FFFFFF),
                foregroundColor: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Start the right flow fast',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Common actions stay large and colorful. Secondary entries stay grouped below so the page feels lighter to use.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFE8EEFF),
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerChip extends StatelessWidget {
  const _BannerChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.foregroundColor,
  });

  final String label;
  final IconData icon;
  final Color color;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: foregroundColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorSectionHeader extends StatelessWidget {
  const _ColorSectionHeader({
    required this.title,
    required this.subtitle,
    required this.accentColor,
  });

  final String title;
  final String subtitle;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(99),
                boxShadow: [
                  BoxShadow(
                    color: accentColor.withValues(alpha: 0.28),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: const Color(0xFF233047),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF687487),
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid({required this.actions});

  final List<_QuickActionData> actions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 12.0;
        final isSingleColumn = constraints.maxWidth < 340;
        final itemWidth = isSingleColumn
            ? constraints.maxWidth
            : (constraints.maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: actions
              .map(
                (action) => SizedBox(
                  width: itemWidth,
                  child: _QuickActionCard(data: action),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.data});

  final _QuickActionData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: data.onTap,
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [data.surfaceColor, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: data.accentColor.withValues(alpha: 0.18)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F23314D),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: data.surfaceColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(data.icon, color: data.accentColor),
                    ),
                    const Spacer(),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: data.accentColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: data.accentColor.withValues(alpha: 0.28),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  data.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF233047),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  data.subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF687487),
                    fontWeight: FontWeight.w500,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShortcutGroupCard extends StatelessWidget {
  const _ShortcutGroupCard({
    required this.items,
    required this.tintColor,
    required this.borderColor,
  });

  final List<_ShortcutItemData> items;
  final Color tintColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: tintColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          for (var index = 0; index < items.length; index++) ...[
            _ShortcutTile(data: items[index]),
            if (index < items.length - 1)
              Divider(
                height: 1,
                indent: 74,
                endIndent: 18,
                color: theme.dividerColor,
              ),
          ],
        ],
      ),
    );
  }
}

class _ShortcutTile extends StatelessWidget {
  const _ShortcutTile({required this.data});

  final _ShortcutItemData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => _showComingSoon(context, data),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: data.accentColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(data.icon, color: data.accentColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: const Color(0xFF233047),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (data.statusLabel != null) ...[
                        const SizedBox(width: 8),
                        _StatusPill(
                          label: data.statusLabel!,
                          color: data.statusColor ?? data.accentColor,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data.subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF6C7789),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF9FA8B7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, _ShortcutItemData data) {
    final label = data.statusLabel == 'Pro'
        ? '${data.title} is part of the premium flow.'
        : '${data.title} is not connected yet.';

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(label)));
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _QuickActionData {
  const _QuickActionData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.surfaceColor,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final Color surfaceColor;
  final VoidCallback onTap;
}

class _ShortcutItemData {
  const _ShortcutItemData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    this.statusLabel,
    this.statusColor,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final String? statusLabel;
  final Color? statusColor;
}
