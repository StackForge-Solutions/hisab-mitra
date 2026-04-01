import 'package:flutter/material.dart';

import '../../models/invoice_item_model.dart';
import '../utils/app_formatters.dart';

class InvoiceItemCard extends StatelessWidget {
  const InvoiceItemCard({
    super.key,
    required this.index,
    required this.item,
    required this.onChangeItem,
    required this.onRemove,
    required this.onQuantityChanged,
    required this.onUnitChanged,
    required this.onRateChanged,
    required this.onDiscountChanged,
    required this.onTaxChanged,
  });

  final int index;
  final InvoiceItemModel item;
  final VoidCallback onChangeItem;
  final VoidCallback onRemove;
  final ValueChanged<double> onQuantityChanged;
  final ValueChanged<String> onUnitChanged;
  final ValueChanged<double> onRateChanged;
  final ValueChanged<double> onDiscountChanged;
  final ValueChanged<double> onTaxChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'SKU ${item.sku} • HSN ${item.hsnCode}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onChangeItem,
                  icon: const Icon(Icons.sync_alt_rounded),
                  tooltip: 'Change item',
                ),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline_rounded),
                  tooltip: 'Remove item',
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _field(
                  label: 'Qty',
                  initialValue: AppFormatters.decimal(item.quantity),
                  width: 92,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (value) =>
                      _parseAndSubmit(value, item.quantity, onQuantityChanged),
                ),
                _field(
                  label: 'Unit',
                  initialValue: item.unit,
                  width: 90,
                  onChanged: onUnitChanged,
                ),
                _field(
                  label: 'Rate',
                  initialValue: AppFormatters.decimal(item.rate),
                  width: 104,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (value) =>
                      _parseAndSubmit(value, item.rate, onRateChanged),
                ),
                _field(
                  label: 'Discount',
                  initialValue: AppFormatters.decimal(item.discount),
                  width: 116,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (value) =>
                      _parseAndSubmit(value, item.discount, onDiscountChanged),
                ),
                _field(
                  label: 'Tax %',
                  initialValue: AppFormatters.decimal(item.taxPercent),
                  width: 96,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (value) =>
                      _parseAndSubmit(value, item.taxPercent, onTaxChanged),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF5FAF7),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Line ${index + 1} amount',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Text(
                    AppFormatters.currency(item.total),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required String label,
    required String initialValue,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
    double width = 120,
  }) {
    return SizedBox(
      width: width,
      child: TextFormField(
        key: ValueKey('$label-$initialValue-$index-${item.id}'),
        initialValue: initialValue,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  void _parseAndSubmit(
    String raw,
    double fallback,
    ValueChanged<double> onChanged,
  ) {
    onChanged(AppFormatters.parseDouble(raw) ?? fallback);
  }
}
