import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_formatters.dart';
import '../../../core/widgets/app_scaffold_wrapper.dart';
import '../../../core/widgets/empty_state_view.dart';
import '../../../core/widgets/invoice_item_card.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../core/widgets/section_header.dart';
import '../../../models/invoice_item_model.dart';
import '../../../models/party_model.dart';
import '../../../models/place_of_supply_model.dart';
import '../../../services/invoice_flow_controller.dart';
import '../../../routes/app_router.dart';
import '../../../services/invoice_flow_state.dart';
import '../../../services/providers.dart';

class ParsedInvoicePage extends ConsumerWidget {
  const ParsedInvoicePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(invoiceFlowControllerProvider);
    final invoice = state.invoice;
    final notifier = ref.read(invoiceFlowControllerProvider.notifier);

    return AppScaffoldWrapper(
      title: 'Parsed Invoice',
      subtitle:
          'Verify the parsed data before saving draft or creating the purchase.',
      bottomNavigationBar: invoice == null
          ? null
          : SafeArea(
              minimum: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      label: 'Save Draft',
                      icon: Icons.drafts_outlined,
                      onPressed:
                          state.submissionStatus ==
                              SubmissionStatus.creatingPurchase
                          ? null
                          : () => _saveDraft(context, notifier),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Create Purchase',
                      icon: Icons.check_circle_outline_rounded,
                      isLoading:
                          state.submissionStatus ==
                          SubmissionStatus.creatingPurchase,
                      onPressed: state.isBusy
                          ? null
                          : () => _createPurchase(
                              context,
                              notifier,
                              invoice.grandTotal,
                            ),
                    ),
                  ),
                ],
              ),
            ),
      child: invoice == null
          ? EmptyStateView(
              title: 'Nothing to review yet',
              message:
                  'Upload a bill and let the parser generate the editable invoice first.',
              action: PrimaryButton(
                label: 'Go to Purchase',
                icon: Icons.shopping_bag_outlined,
                onPressed: () => context.go(AppRoutes.purchase),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          title: 'Supplier / Party',
                          subtitle: 'Change the matched supplier if required.',
                        ),
                        const SizedBox(height: 12),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            invoice.party.name,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            '${invoice.party.address}, ${invoice.party.city}\nGSTIN ${invoice.party.gstin}',
                          ),
                          isThreeLine: true,
                          trailing: TextButton.icon(
                            onPressed: () => _changeParty(context, ref),
                            icon: const Icon(Icons.swap_horiz_rounded),
                            label: const Text('Change Party'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        TextFormField(
                          key: ValueKey(invoice.invoiceNumber),
                          initialValue: invoice.invoiceNumber,
                          onChanged: notifier.updateInvoiceNumber,
                          decoration: const InputDecoration(
                            labelText: 'Invoice number',
                          ),
                        ),
                        const SizedBox(height: 14),
                        InkWell(
                          onTap: () => _pickInvoiceDate(context, ref),
                          borderRadius: BorderRadius.circular(18),
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Invoice date',
                            ),
                            child: Text(
                              AppFormatters.date(invoice.invoiceDate),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text(
                            'Place of Supply',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(invoice.placeOfSupply.label),
                          trailing: TextButton.icon(
                            onPressed: () => _changePlaceOfSupply(context, ref),
                            icon: const Icon(Icons.edit_location_alt_rounded),
                            label: const Text('Edit Place of Supply'),
                          ),
                        ),
                        const Divider(height: 28),
                        Row(
                          children: [
                            Expanded(
                              child: _TaxBox(
                                label: 'Supplier GSTIN',
                                value: invoice.gstin,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _TaxBox(
                                label: 'Items',
                                value: invoice.items.length.toString(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          title: 'Bill summary',
                          subtitle: 'Parsed values ready for validation.',
                        ),
                        const SizedBox(height: 14),
                        _SummaryRow(
                          label: 'Subtotal',
                          value: AppFormatters.currency(invoice.subtotal),
                        ),
                        _SummaryRow(
                          label: 'Discount total',
                          value: AppFormatters.currency(invoice.discountTotal),
                        ),
                        _SummaryRow(
                          label: 'Tax total',
                          value: AppFormatters.currency(invoice.taxTotal),
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                SectionHeader(
                  title: 'Item list',
                  subtitle:
                      'Adjust any parsed medicine before final purchase creation.',
                  actionLabel: 'Add item',
                  onAction: () => _addItem(context, ref),
                ),
                const SizedBox(height: 12),
                ...invoice.items.asMap().entries.map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InvoiceItemCard(
                      index: entry.key,
                      item: entry.value,
                      onChangeItem: () => _changeItem(context, ref, entry.key),
                      onRemove: () => notifier.removeItem(entry.key),
                      onQuantityChanged: (value) =>
                          notifier.updateItemQuantity(entry.key, value),
                      onUnitChanged: (value) =>
                          notifier.updateItemUnit(entry.key, value),
                      onRateChanged: (value) =>
                          notifier.updateItemRate(entry.key, value),
                      onDiscountChanged: (value) =>
                          notifier.updateItemDiscount(entry.key, value),
                      onTaxChanged: (value) =>
                          notifier.updateItemTax(entry.key, value),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        _SummaryRow(
                          label: 'Grand total',
                          value: AppFormatters.currency(invoice.grandTotal),
                        ),
                        _SummaryRow(
                          label: 'Payable amount',
                          value: AppFormatters.currency(invoice.payableAmount),
                          emphasize: true,
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

  Future<void> _pickInvoiceDate(BuildContext context, WidgetRef ref) async {
    final invoice = ref.read(invoiceFlowControllerProvider).invoice;
    if (invoice == null) {
      return;
    }

    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: invoice.invoiceDate,
    );

    if (picked != null) {
      ref
          .read(invoiceFlowControllerProvider.notifier)
          .updateInvoiceDate(picked);
    }
  }

  Future<void> _changePlaceOfSupply(BuildContext context, WidgetRef ref) async {
    final selected = await context.push<PlaceOfSupplyModel>(
      AppRoutes.placeOfSupply,
    );
    if (selected != null) {
      ref
          .read(invoiceFlowControllerProvider.notifier)
          .updatePlaceOfSupply(selected);
    }
  }

  Future<void> _changeParty(BuildContext context, WidgetRef ref) async {
    final selected = await context.push<PartyModel>(AppRoutes.changeParty);
    if (selected != null) {
      ref.read(invoiceFlowControllerProvider.notifier).updateParty(selected);
    }
  }

  Future<void> _changeItem(
    BuildContext context,
    WidgetRef ref,
    int index,
  ) async {
    final item = await context.push<InvoiceItemModel>(
      AppRoutes.changeItem,
      extra: index,
    );
    if (item != null) {
      ref.read(invoiceFlowControllerProvider.notifier).replaceItem(index, item);
    }
  }

  Future<void> _addItem(BuildContext context, WidgetRef ref) async {
    final item = await context.push<InvoiceItemModel>(
      AppRoutes.changeItem,
      extra: -1,
    );
    if (item != null) {
      ref.read(invoiceFlowControllerProvider.notifier).addItem(item);
    }
  }

  Future<void> _saveDraft(
    BuildContext context,
    InvoiceFlowController notifier,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final message = await notifier.saveDraft();
    messenger.showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _createPurchase(
    BuildContext context,
    InvoiceFlowController notifier,
    double total,
  ) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Create purchase'),
            content: Text(
              'Confirm purchase creation for ${AppFormatters.currency(total)}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Create'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    final message = await notifier.createPurchase();
    if (!context.mounted) {
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Purchase created'),
        content: Text(
          '$message\n\nPayable amount: ${AppFormatters.currency(total)}',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}

class _TaxBox extends StatelessWidget {
  const _TaxBox({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF5FAF7),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasize = false,
    this.isLast = false,
  });

  final String label;
  final String value;
  final bool emphasize;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final style = emphasize
        ? Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)
        : Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600);

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }
}
