import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/loader_view.dart';
import '../../../routes/app_router.dart';
import '../../../services/providers.dart';

class ParsingLoaderPage extends ConsumerStatefulWidget {
  const ParsingLoaderPage({super.key});

  @override
  ConsumerState<ParsingLoaderPage> createState() => _ParsingLoaderPageState();
}

class _ParsingLoaderPageState extends ConsumerState<ParsingLoaderPage> {
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) {
      return;
    }
    _started = true;
    Future<void>(() async {
      await ref
          .read(invoiceFlowControllerProvider.notifier)
          .parseUploadedBill();
      if (!mounted) {
        return;
      }
      context.go(AppRoutes.parsedInvoice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoaderView(
        title: 'Parsing invoice',
        subtitle:
            'Extracting line items, identifying GST, and mapping totals for review.',
        icon: Icons.auto_awesome_motion_rounded,
        steps: [
          'Reading supplier and invoice metadata',
          'Extracting line items',
          'Identifying GST and totals',
        ],
      ),
    );
  }
}
