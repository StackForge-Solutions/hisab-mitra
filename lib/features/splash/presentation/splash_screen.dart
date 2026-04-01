import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _introOpacity;
  late final Animation<double> _heroScale;
  late final Animation<Offset> _cardSlide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConstants.splashDelay,
    )..forward();
    _introOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.42, curve: Curves.easeOut),
    );
    _heroScale = Tween<double>(begin: 0.92, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.55, curve: Curves.easeOutBack),
      ),
    );
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.16), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.18, 0.72, curve: Curves.easeOutCubic),
          ),
        );

    Future<void>.delayed(AppConstants.splashDelay, () {
      if (!mounted) {
        return;
      }
      context.go(AppRoutes.landing);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FBFF), Color(0xFFF3F8FF), Color(0xFFF7F6FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const _AmbientGlow(
              alignment: Alignment.topCenter,
              size: 260,
              color: Color(0x2B8DC5FF),
              offset: Offset(0, -100),
            ),
            const _AmbientGlow(
              alignment: Alignment.bottomLeft,
              size: 280,
              color: Color(0x3388FFE7),
              offset: Offset(-40, 80),
            ),
            const _AmbientGlow(
              alignment: Alignment.bottomRight,
              size: 220,
              color: Color(0x26FFB5E9),
              offset: Offset(40, 60),
            ),
            const _AmbientGlow(
              alignment: Alignment.centerRight,
              size: 200,
              color: Color(0x1FFFB1C8),
              offset: Offset(60, 40),
            ),
            SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final contentWidth = math.min(
                    constraints.maxWidth - 48,
                    420.0,
                  );
                  final heroSize = math.min(contentWidth * 0.62, 220.0);
                  final topSpace = math.max(constraints.maxHeight * 0.06, 18.0);
                  final middleSpace = math.max(
                    constraints.maxHeight * 0.04,
                    22.0,
                  );
                  final bottomSpace = math.max(
                    constraints.maxHeight * 0.08,
                    28.0,
                  );

                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: contentWidth),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: FadeTransition(
                          opacity: _introOpacity,
                          child: Column(
                            children: [
                              SizedBox(height: topSpace),
                              ScaleTransition(
                                scale: _heroScale,
                                child: _HeroBadge(size: heroSize),
                              ),
                              const SizedBox(height: 28),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: theme.textTheme.displaySmall?.copyWith(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -1.2,
                                    color: const Color(0xFF151F35),
                                  ),
                                  children: const [
                                    TextSpan(text: 'Hisab'),
                                    TextSpan(
                                      text: 'Kitab',
                                      style: TextStyle(
                                        color: Color(0xFF5767FF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Smart Invoice Reader & Pharmacy\nManagement',
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  height: 1.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF7B879C),
                                ),
                              ),
                              SizedBox(height: middleSpace),
                              SlideTransition(
                                position: _cardSlide,
                                child: const _ScanningFeatureCard(),
                              ),
                              const Spacer(),
                              AnimatedBuilder(
                                animation: _controller,
                                builder: (context, _) {
                                  final progress = Curves.easeOutCubic
                                      .transform(_controller.value);
                                  return _StatusFooter(progress: progress);
                                },
                              ),
                              SizedBox(height: bottomSpace),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow({
    required this.alignment,
    required this.size,
    required this.color,
    this.offset = Offset.zero,
  });

  final Alignment alignment;
  final double size;
  final Color color;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Transform.translate(
        offset: offset,
        child: IgnorePointer(
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color,
                  color.withValues(alpha: color.a * 0.42),
                  Colors.transparent,
                ],
                stops: const [0, 0.42, 1],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final baseRadius = size * 0.23;
    final frontSize = size * 0.72;
    final logoSize = size * 0.34;

    return SizedBox(
      width: size + 48,
      height: size + 30,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.center,
            child: Transform.rotate(
              angle: -0.17,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(baseRadius),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3D7DFF), Color(0xFF22D3EE)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x334974FF),
                      blurRadius: 42,
                      offset: Offset(0, 22),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size * 0.24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  width: frontSize,
                  height: frontSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size * 0.24),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.66),
                        const Color(0xFFE9FDFF).withValues(alpha: 0.62),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.58),
                      width: 1.2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x26FFFFFF),
                        blurRadius: 18,
                        offset: Offset(0, 2),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(child: _HeroIcon(size: logoSize)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 14,
            bottom: 32,
            child: _FloatingChip(
              size: size * 0.19,
              icon: Icons.inventory_2_rounded,
              iconColor: const Color(0xFF3B82F6),
            ),
          ),
          Positioned(
            right: 18,
            top: 8,
            child: _FloatingChip(
              size: size * 0.19,
              icon: Icons.bolt_rounded,
              iconColor: const Color(0xFF8B5CF6),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingChip extends StatelessWidget {
  const _FloatingChip({
    required this.size,
    required this.icon,
    required this.iconColor,
  });

  final double size;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.95),
            const Color(0xFFEAF3FF).withValues(alpha: 0.82),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x20456DFF),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, size: size * 0.36, color: iconColor),
    );
  }
}

class _HeroIcon extends StatelessWidget {
  const _HeroIcon({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF4D78FF), Color(0xFF2EDEFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x194C67FF),
            blurRadius: 16,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Container(
              width: size * 0.58,
              height: size * 0.66,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.94),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.description_rounded,
                    size: size * 0.2,
                    color: const Color(0xFF4F63FF),
                  ),
                  const SizedBox(height: 2),
                  ...List.generate(
                    3,
                    (_) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Container(
                        width: size * 0.22,
                        height: 3,
                        decoration: BoxDecoration(
                          color: const Color(0xFF7A89FF).withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: size * 0.12,
            bottom: size * 0.12,
            child: Container(
              width: size * 0.28,
              height: size * 0.28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: const Color(0xFFBDFBFF), width: 2),
              ),
              child: const Icon(
                Icons.add_rounded,
                size: 16,
                color: Color(0xFF30C3D9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanningFeatureCard extends StatelessWidget {
  const _ScanningFeatureCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.94),
            const Color(0xFFF8FBFF).withValues(alpha: 0.84),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.82),
          width: 1.1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1B5570C7),
            blurRadius: 28,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFE7EEFF),
                  const Color(0xFFF3F7FF).withValues(alpha: 0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Icon(
              Icons.bolt_rounded,
              color: Color(0xFF3B82F6),
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI-Powered Scanning',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF25314A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Auto-extracting medical bills & stock...',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.45,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF96A0B6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusFooter extends StatelessWidget {
  const _StatusFooter({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final normalizedProgress = progress.clamp(0.0, 1.0).toDouble();
    final activityPulse =
        0.88 +
        (((math.sin(normalizedProgress * math.pi * 6) + 1) / 2) * 0.34);
    final dotCount = math.min(3, (normalizedProgress * 4).floor());
    final trailingDots = '.' * dotCount;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0x203382F6),
                      Color(0x18C084FC),
                      Color(0x18F7AED8),
                    ],
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: normalizedProgress,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF14B8FF), Color(0xFF4F63FF)],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x553E66FF),
                        blurRadius: 14,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: activityPulse,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF5B6FFF), width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x335B6FFF),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Color(0xFF5B6FFF),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'INITIALIZING WORKSPACE',
                  style: theme.textTheme.labelMedium?.copyWith(
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF8A96A9),
                  ),
                ),
                SizedBox(
                  width: 18,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      trailingDots,
                      style: theme.textTheme.labelMedium?.copyWith(
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF5B6FFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          '${(normalizedProgress * 100).round()}% ready',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF7E8AA3),
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'v2.4.0 • Secure Encrypted',
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFFA6B0C3),
          ),
        ),
      ],
    );
  }
}
