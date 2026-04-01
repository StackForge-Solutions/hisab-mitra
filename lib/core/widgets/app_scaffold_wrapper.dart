import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class AppScaffoldWrapper extends StatelessWidget {
  const AppScaffoldWrapper({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.scrollable = true,
    this.appBar,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool scrollable;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.screenPadding,
        8,
        AppConstants.screenPadding,
        AppConstants.screenPadding,
      ),
      child: child,
    );

    return Scaffold(
      appBar:
          appBar ??
          AppBar(
            titleSpacing: AppConstants.screenPadding,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
              ],
            ),
            actions: actions,
          ),
      body: SafeArea(
        child: scrollable ? SingleChildScrollView(child: content) : content,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
