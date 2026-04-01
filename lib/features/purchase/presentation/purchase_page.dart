import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/app_router.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({super.key});

  static const Color _purple = Color(0xFF4C44C7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x740E1020),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: _OverlayTopBar(),
              ),
            ),
            Positioned.fill(
              top: 64,
              bottom: 72,
              child: _TransactionSheet(
                onSalesBillTap: () => context.push(AppRoutes.salesTransaction),
                onReceivedPaymentTap: () => context.push(
                  AppRoutes.salesTransaction,
                ),
                onPurchaseTap: () => context.push(AppRoutes.uploadBill),
                onScanBillsTap: () => context.push(AppRoutes.uploadBill),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 22,
              child: Center(
                child: _SheetCloseButton(onTap: () => context.pop()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverlayTopBar extends StatelessWidget {
  const _OverlayTopBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        children: [
          Text(
            'Business Name',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF2D263D),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20,
            color: Color(0xFF8B8599),
          ),
          const Spacer(),
          const _OverlayTopIcon(
            icon: Icons.qr_code_2_rounded,
            color: Color(0xFFF0A45F),
          ),
          const SizedBox(width: 10),
          const _OverlayTopIcon(
            icon: Icons.card_giftcard_rounded,
            color: PurchasePage._purple,
          ),
          const SizedBox(width: 10),
          const _OverlayTopIcon(
            icon: Icons.campaign_outlined,
            color: Color(0xFFEDA34D),
          ),
        ],
      ),
    );
  }
}

class _OverlayTopIcon extends StatelessWidget {
  const _OverlayTopIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(icon, size: 20, color: color);
  }
}

class _TransactionSheet extends StatelessWidget {
  const _TransactionSheet({
    required this.onSalesBillTap,
    required this.onReceivedPaymentTap,
    required this.onPurchaseTap,
    required this.onScanBillsTap,
  });

  final VoidCallback onSalesBillTap;
  final VoidCallback onReceivedPaymentTap;
  final VoidCallback onPurchaseTap;
  final VoidCallback onScanBillsTap;

  @override
  Widget build(BuildContext context) {
    const dividerColor = Color(0xFFF0EEF4);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(14, 18, 14, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TransactionSection(
              title: 'Sales Transactions',
              items: [
                _ActionItemData(
                  label: 'Bill / Invoice',
                  icon: Icons.receipt_long_outlined,
                  iconColor: const Color(0xFF4FBA71),
                  backgroundColor: const Color(0xFFF2FFF4),
                  onTap: onSalesBillTap,
                ),
                _ActionItemData(
                  label: 'Received\nPayment',
                  icon: Icons.currency_rupee_rounded,
                  iconColor: const Color(0xFF4FBA71),
                  backgroundColor: const Color(0xFFF2FFF4),
                  onTap: onReceivedPaymentTap,
                ),
                const _ActionItemData(
                  label: 'Sales Return',
                  icon: Icons.assignment_return_outlined,
                  iconColor: Color(0xFF4FBA71),
                  backgroundColor: Color(0xFFF2FFF4),
                ),
                const _ActionItemData(
                  label: 'Credit Note',
                  icon: Icons.note_alt_outlined,
                  iconColor: Color(0xFF4FBA71),
                  backgroundColor: Color(0xFFF2FFF4),
                ),
                const _ActionItemData(
                  label: 'Quotation/\nEstimate',
                  icon: Icons.request_quote_outlined,
                  iconColor: Color(0xFF4FBA71),
                  backgroundColor: Color(0xFFF2FFF4),
                ),
                const _ActionItemData(
                  label: 'Delivery\nChallan',
                  icon: Icons.local_shipping_outlined,
                  iconColor: Color(0xFF4FBA71),
                  backgroundColor: Color(0xFFF2FFF4),
                ),
                const _ActionItemData(
                  label: 'Proforma\nInvoice',
                  icon: Icons.description_outlined,
                  iconColor: Color(0xFF4FBA71),
                  backgroundColor: Color(0xFFF2FFF4),
                  showCrown: true,
                ),
                const _ActionItemData(
                  label: 'Automated\nBill',
                  icon: Icons.auto_mode_outlined,
                  iconColor: Color(0xFF4FBA71),
                  backgroundColor: Color(0xFFF2FFF4),
                  showCrown: true,
                ),
                const _ActionItemData(
                  label: 'Counter',
                  icon: Icons.point_of_sale_outlined,
                  iconColor: Color(0xFFE0B54D),
                  backgroundColor: Color(0xFFFFFBED),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(height: 1, color: dividerColor),
            ),
            _TransactionSection(
              title: 'Purchase Transactions',
              items: [
                _ActionItemData(
                  label: 'Purchase',
                  icon: Icons.shopping_cart_outlined,
                  iconColor: const Color(0xFF5C66D6),
                  backgroundColor: const Color(0xFFF3F5FF),
                  onTap: onPurchaseTap,
                ),
                const _ActionItemData(
                  label: 'Payment Out',
                  icon: Icons.currency_rupee_rounded,
                  iconColor: Color(0xFF5C66D6),
                  backgroundColor: Color(0xFFF3F5FF),
                ),
                const _ActionItemData(
                  label: 'Purchase\nReturn',
                  icon: Icons.reply_outlined,
                  iconColor: Color(0xFF5C66D6),
                  backgroundColor: Color(0xFFF3F5FF),
                ),
                const _ActionItemData(
                  label: 'Debit Note',
                  icon: Icons.note_add_outlined,
                  iconColor: Color(0xFF5C66D6),
                  backgroundColor: Color(0xFFF3F5FF),
                ),
                const _ActionItemData(
                  label: 'Purchase\nOrder',
                  icon: Icons.assignment_outlined,
                  iconColor: Color(0xFF5C66D6),
                  backgroundColor: Color(0xFFF3F5FF),
                ),
                _ActionItemData(
                  label: 'Scan &\nRecord Bills',
                  icon: Icons.document_scanner_outlined,
                  iconColor: const Color(0xFF5C66D6),
                  backgroundColor: const Color(0xFFF3F5FF),
                  onTap: onScanBillsTap,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Divider(height: 1, color: dividerColor),
            ),
            const _TransactionSection(
              title: 'Other Transactions',
              items: [
                _ActionItemData(
                  label: 'Expense',
                  icon: Icons.account_balance_wallet_outlined,
                  iconColor: Color(0xFFE38C8C),
                  backgroundColor: Color(0xFFFFF2F2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionSection extends StatelessWidget {
  const _TransactionSection({
    required this.title,
    required this.items,
  });

  final String title;
  final List<_ActionItemData> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: const Color(0xFF342C45),
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 14.0;
            final itemWidth = (constraints.maxWidth - (spacing * 3)) / 4;

            return Wrap(
              spacing: spacing,
              runSpacing: 18,
              children: items
                  .map((item) => SizedBox(
                        width: itemWidth,
                        child: _TransactionActionTile(data: item),
                      ))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}

class _TransactionActionTile extends StatelessWidget {
  const _TransactionActionTile({required this.data});

  final _ActionItemData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: data.onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: data.backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0A1B1036),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(data.icon, size: 21, color: data.iconColor),
                ),
                if (data.showCrown)
                  const Positioned(
                    top: -2,
                    right: -2,
                    child: Icon(
                      Icons.workspace_premium_rounded,
                      size: 13,
                      color: Color(0xFFE0B54D),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 9),
            Text(
              data.label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xFF6C667B),
                fontWeight: FontWeight.w500,
                height: 1.22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetCloseButton extends StatelessWidget {
  const _SheetCloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0x25000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: const SizedBox(
            width: 40,
            height: 40,
            child: Icon(Icons.close_rounded, color: Color(0xFF4A4458), size: 24),
          ),
        ),
      ),
    );
  }
}

class _ActionItemData {
  const _ActionItemData({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    this.showCrown = false,
    this.onTap,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final bool showCrown;
  final VoidCallback? onTap;
}
