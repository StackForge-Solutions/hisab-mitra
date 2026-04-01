import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/loader_view.dart';
import '../../../routes/app_router.dart';

class PreloadScreen extends StatefulWidget {
  const PreloadScreen({super.key});

  @override
  State<PreloadScreen> createState() => _PreloadScreenState();
}

class _PreloadScreenState extends State<PreloadScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(AppConstants.preloadDelay, () {
      if (!mounted) {
        return;
      }
      context.go(AppRoutes.landing);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoaderView(
        title: 'Preparing workspace',
        subtitle:
            'Loading dashboard, syncing mock ledgers, and getting purchase tools ready.',
        imageAsset: 'assets/branding/hisaab_mitra_logo.png',
        steps: [
          'Preparing workspace',
          'Loading dashboard',
          'Checking recent drafts',
        ],
      ),
    );
  }
}
