import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/app_formatters.dart';
import '../../../core/widgets/app_scaffold_wrapper.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/search_text_field.dart';
import '../../../models/invoice_item_model.dart';
import '../../../services/providers.dart';

class ChangeItemPage extends ConsumerStatefulWidget {
  const ChangeItemPage({super.key, required this.itemIndex});

  final int itemIndex;

  @override
  ConsumerState<ChangeItemPage> createState() => _ChangeItemPageState();
}

class _ChangeItemPageState extends ConsumerState<ChangeItemPage> {
  late final TextEditingController _searchController;
  late final TextEditingController _quantityController;
  late final TextEditingController _rateController;
  late final TextEditingController _discountController;
  late final TextEditingController _taxController;
  String _query = '';
  InvoiceItemModel? _selectedItem;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _quantityController = TextEditingController(text: '1');
    _rateController = TextEditingController();
    _discountController = TextEditingController(text: '0');
    _taxController = TextEditingController(text: '12');

    final currentInvoice = ref.read(invoiceFlowControllerProvider).invoice;
    if (widget.itemIndex >= 0 &&
        currentInvoice != null &&
        widget.itemIndex < currentInvoice.items.length) {
      final item = currentInvoice.items[widget.itemIndex];
      _selectedItem = item;
      _quantityController.text = AppFormatters.decimal(item.quantity);
      _rateController.text = AppFormatters.decimal(item.rate);
      _discountController.text = AppFormatters.decimal(item.discount);
      _taxController.text = AppFormatters.decimal(item.taxPercent);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _quantityController.dispose();
    _rateController.dispose();
    _discountController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(catalogItemsProvider);
    final filtered = items.where((item) {
      final query = _query.toLowerCase();
      return item.name.toLowerCase().contains(query) ||
          item.sku.toLowerCase().contains(query) ||
          item.hsnCode.contains(query);
    }).toList();

    return AppScaffoldWrapper(
      title: widget.itemIndex == -1 ? 'Add Item' : 'Change Item',
      subtitle:
          'Search the medicine catalog and optionally adjust quantity, rate, discount, or tax before confirming.',
      bottomNavigationBar: _selectedItem == null
          ? null
          : SafeArea(
              minimum: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: PrimaryButton(
                label: widget.itemIndex == -1
                    ? 'Add Selected Item'
                    : 'Confirm Item Change',
                icon: Icons.check_rounded,
                onPressed: () => context.pop(_buildSelectedItem()),
              ),
            ),
      child: Column(
        children: [
          SearchTextField(
            hintText: 'Search medicine, SKU, or HSN',
            controller: _searchController,
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 16),
          ...filtered.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: ListTile(
                  onTap: () => _selectItem(item),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    'SKU ${item.sku} • HSN ${item.hsnCode} • Default ${AppFormatters.currency(item.rate)}',
                  ),
                  trailing: Icon(
                    _selectedItem?.id == item.id
                        ? Icons.check_circle_rounded
                        : Icons.chevron_right_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          if (_selectedItem != null) ...[
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick edit',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _SmallField(
                          controller: _quantityController,
                          label: 'Qty',
                        ),
                        _SmallField(controller: _rateController, label: 'Rate'),
                        _SmallField(
                          controller: _discountController,
                          label: 'Discount',
                        ),
                        _SmallField(controller: _taxController, label: 'Tax %'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _selectItem(InvoiceItemModel item) {
    setState(() {
      _selectedItem = item;
      _quantityController.text = AppFormatters.decimal(item.quantity);
      _rateController.text = AppFormatters.decimal(item.rate);
      _discountController.text = AppFormatters.decimal(item.discount);
      _taxController.text = AppFormatters.decimal(item.taxPercent);
    });
  }

  InvoiceItemModel _buildSelectedItem() {
    final item = _selectedItem!;
    return item.copyWith(
      quantity:
          AppFormatters.parseDouble(_quantityController.text) ?? item.quantity,
      rate: AppFormatters.parseDouble(_rateController.text) ?? item.rate,
      discount:
          AppFormatters.parseDouble(_discountController.text) ?? item.discount,
      taxPercent:
          AppFormatters.parseDouble(_taxController.text) ?? item.taxPercent,
    );
  }
}

class _SmallField extends StatelessWidget {
  const _SmallField({required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
