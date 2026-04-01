import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_scaffold_wrapper.dart';
import '../../../routes/app_router.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  static const Color _pageBackground = Color(0xFFFDFCFF);
  static const Color _primaryPurple = Color(0xFF4C44C7);
  static const Color _navMuted = Color(0xFF9D9AAE);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(scaffoldBackgroundColor: _pageBackground),
      child: AppScaffoldWrapper(
        title: 'Dashboard',
        scrollable: false,
        appBar: const _LandingTopBar(),
        bottomNavigationBar: _LandingBottomBar(
          onReceivePayment: () => context.push(AppRoutes.salesTransaction),
          onCreateBill: () => context.push(AppRoutes.purchase),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6),
            _PromoBanner(),
            SizedBox(height: 12),
            _MetricsGrid(),
            SizedBox(height: 18),
            _TransactionsHeader(),
            Expanded(child: _TransactionsEmptyState()),
          ],
        ),
      ),
    );
  }
}

class _LandingTopBar extends StatelessWidget implements PreferredSizeWidget {
  const _LandingTopBar();

  @override
  Size get preferredSize => const Size.fromHeight(66);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: LandingPage._pageBackground,
      surfaceTintColor: Colors.transparent,
      toolbarHeight: 66,
      titleSpacing: 0,
      title: Row(
        children: [
          Text(
            'Business Name',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: const Color(0xFF3B3550),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF8E88A2),
            size: 20,
          ),
        ],
      ),
      actions: const [
        _TopBarIcon(icon: Icons.qr_code_2_rounded, color: Color(0xFFF0A45F)),
        SizedBox(width: 2),
        _TopBarIcon(icon: Icons.card_giftcard_rounded, color: LandingPage._primaryPurple),
        SizedBox(width: 2),
        _TopBarIcon(icon: Icons.campaign_outlined, color: Color(0xFFEDA34D)),
      ],
    );
  }
}

class _TopBarIcon extends StatelessWidget {
  const _TopBarIcon({
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      splashRadius: 20,
      icon: Icon(icon, size: 21, color: color),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 86,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFFFFEBF3), Color(0xFFF7EEF9)],
        ),
        border: Border.all(color: const Color(0xFFF1D9E7)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 14,
            top: 12,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: Color(0xFFD6D0D7),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close_rounded, size: 11, color: Colors.white),
            ),
          ),
          Positioned(
            right: 22,
            bottom: 12,
            child: Row(
              children: List.generate(
                4,
                (_) => Container(
                  width: 3,
                  height: 3,
                  margin: const EdgeInsets.only(left: 4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD8A3C2),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 72,
            top: 14,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFF2CDE1),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Save Upto 65%',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: const Color(0xFFEA8E3F),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Get higher discounts on multi-year plans',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF4F4763),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.72),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFF1D9E7)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Talk to Sales',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: const Color(0xFF8D621E),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 12,
                              color: Color(0xFF8D621E),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                const _BannerArtwork(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerArtwork extends StatelessWidget {
  const _BannerArtwork();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 2,
            top: 7,
            child: Transform.rotate(
              angle: -0.18,
              child: Container(
                width: 22,
                height: 2,
                color: const Color(0xFFE7A9C7),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              'END OF FY',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF2C243A),
                fontWeight: FontWeight.w900,
                letterSpacing: -0.8,
                height: 0.95,
              ),
            ),
          ),
          Positioned(
            right: 2,
            top: 36,
            child: Text(
              'Sale',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: const Color(0xFF58B4C1),
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic,
                letterSpacing: -0.6,
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 58,
            child: Transform.rotate(
              angle: -0.22,
              child: Container(
                width: 28,
                height: 2,
                color: const Color(0xFF58B4C1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                value: '₹ 0',
                label: 'To Collect',
                backgroundColor: Color(0xFFF4FCF6),
                borderColor: Color(0xFFD6EAD9),
                accentColor: Color(0xFF4FBA71),
                trendIcon: Icons.south_rounded,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _MetricCard(
                value: '₹ 89,610',
                label: 'To Pay',
                backgroundColor: Color(0xFFFFF5F5),
                borderColor: Color(0xFFF0DADA),
                accentColor: Color(0xFFE68181),
                trendIcon: Icons.north_rounded,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                title: 'Stock Value',
                label: 'Value of Items',
                backgroundColor: Color(0xFFF8FBFF),
                borderColor: Color(0xFFDCE8F5),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _MetricCard(
                value: '₹ 0',
                label: 'This week\'s sale',
                backgroundColor: Color(0xFFF8FBFF),
                borderColor: Color(0xFFDCE8F5),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                title: 'Total Balance',
                label: 'Cash + Bank Balance',
                backgroundColor: Color(0xFFF8FBFF),
                borderColor: Color(0xFFDCE8F5),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _MetricCard(
                title: 'Reports',
                label: 'Sales, Party, GST...',
                backgroundColor: Color(0xFFF8FBFF),
                borderColor: Color(0xFFDCE8F5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    this.title,
    this.value,
    required this.label,
    required this.backgroundColor,
    required this.borderColor,
    this.accentColor,
    this.trendIcon,
  });

  final String? title;
  final String? value;
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Color? accentColor;
  final IconData? trendIcon;

  @override
  Widget build(BuildContext context) {
    final isEmphasisCard = value != null;
    final labelColor = accentColor ?? const Color(0xFF777085);

    return Container(
      height: 82,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D312E4D),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value ?? title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF3D3551),
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: labelColor,
                          fontWeight: isEmphasisCard ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (trendIcon != null) ...[
                      const SizedBox(width: 4),
                      Icon(trendIcon, size: 14, color: labelColor),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFFAAA6B6),
            size: 22,
          ),
        ],
      ),
    );
  }
}

class _TransactionsHeader extends StatelessWidget {
  const _TransactionsHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Transactions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: const Color(0xFF3D3551),
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.calendar_month_outlined,
          size: 18,
          color: LandingPage._primaryPurple,
        ),
        const SizedBox(width: 6),
        Text(
          'LAST 365 DAYS',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: LandingPage._primaryPurple,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}

class _TransactionsEmptyState extends StatelessWidget {
  const _TransactionsEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE9E4EC)),
              color: Colors.white,
            ),
            child: const Icon(
              Icons.calendar_month_outlined,
              size: 34,
              color: Color(0xFFD8D2DD),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'No Transactions Found',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF726B80),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _LandingBottomBar extends StatelessWidget {
  const _LandingBottomBar({
    required this.onReceivePayment,
    required this.onCreateBill,
  });

  final VoidCallback onReceivePayment;
  final VoidCallback onCreateBill;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: _BottomActionPill(
                        label: 'Received Payment',
                        colors: const [Color(0xFF393069), Color(0xFF47407E)],
                        onTap: onReceivePayment,
                      ),
                    ),
                    const SizedBox(width: 10),
                    _CenterActionButton(onTap: onCreateBill),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _BottomActionPill(
                        label: '+ Bill / Invoice',
                        colors: const [Color(0xFF4A35D2), Color(0xFF2A53E5)],
                        onTap: onCreateBill,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _BottomNavItem(
                      icon: Icons.home_rounded,
                      label: 'Dashboard',
                      selected: true,
                    ),
                    _BottomNavItem(
                      icon: Icons.people_outline_rounded,
                      label: 'Parties',
                    ),
                    _BottomNavItem(
                      icon: Icons.inventory_2_outlined,
                      label: 'Items',
                    ),
                    _BottomNavItem(
                      icon: Icons.auto_awesome_outlined,
                      label: 'For You',
                    ),
                    _BottomNavItem(
                      icon: Icons.more_horiz_rounded,
                      label: 'More',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomActionPill extends StatelessWidget {
  const _BottomActionPill({
    required this.label,
    required this.colors,
    required this.onTap,
  });

  final String label;
  final List<Color> colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x24000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Center(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CenterActionButton extends StatelessWidget {
  const _CenterActionButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFFA9DA87), Color(0xFF68C78A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 10,
            offset: Offset(0, 3),
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
            child: Icon(Icons.add_rounded, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final color = selected ? LandingPage._primaryPurple : LandingPage._navMuted;

    return SizedBox(
      width: 62,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(height: 3),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
