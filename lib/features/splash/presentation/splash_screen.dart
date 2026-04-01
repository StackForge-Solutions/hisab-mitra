import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/loader_view.dart';
import '../../../routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(AppConstants.splashDelay, () {
      if (!mounted) {
        return;
      }
      context.go(AppRoutes.preload);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF2FBF5), Color(0xFFF8FAF8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            LoaderView(
              title: AppConstants.appName,
              subtitle:
                  'Secure pharmacy purchases, invoice checks, and daily accounting in one flow.',
              imageAsset: 'assets/branding/hisaab_mitra_logo.png',
            ),
          ],
        ),
      ),
    );
  }
}
