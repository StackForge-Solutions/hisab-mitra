import 'package:flutter/material.dart';

import '../../../core/utils/app_formatters.dart';
import '../../../core/widgets/app_scaffold_wrapper.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../../../core/widgets/section_header.dart';

class SalesTransactionPage extends StatefulWidget {
  const SalesTransactionPage({super.key});

  @override
  State<SalesTransactionPage> createState() => _SalesTransactionPageState();
}

class _SalesTransactionPageState extends State<SalesTransactionPage> {
  late final TextEditingController _customerController;
  late final TextEditingController _invoiceController;
  late final TextEditingController _itemsController;
  late final TextEditingController _quantityController;
  late final TextEditingController _amountController;
  DateTime _selectedDate = DateTime(2026, 3, 31);

  @override
  void initState() {
    super.initState();
    _customerController = TextEditingController(text: 'City Care Walk-In');
    _invoiceController = TextEditingController(text: 'SAL-2026-031');
    _itemsController = TextEditingController(
      text: 'Paracetamol 650mg, Vitamin C Effervescent',
    );
    _quantityController = TextEditingController(text: '7');
    _amountController = TextEditingController(text: '1248');
  }

  @override
  void dispose() {
    _customerController.dispose();
    _invoiceController.dispose();
    _itemsController.dispose();
    _quantityController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWrapper(
      title: 'Sales Transaction',
      subtitle: 'Capture a retail invoice with customer and payment details.',
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Row(
          children: [
            Expanded(
              child: SecondaryButton(
                label: 'Reset',
                icon: Icons.restart_alt_rounded,
                onPressed: _reset,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: PrimaryButton(
                label: 'Save Sale',
                icon: Icons.check_circle_outline_rounded,
                onPressed: _save,
              ),
            ),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Sales entry',
            subtitle:
                'All fields stay editable so the counter team can close bills quickly.',
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  TextField(
                    controller: _customerController,
                    decoration: const InputDecoration(
                      labelText: 'Customer name',
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _invoiceController,
                    decoration: const InputDecoration(
                      labelText: 'Invoice number',
                    ),
                  ),
                  const SizedBox(height: 14),
                  InkWell(
                    onTap: _pickDate,
                    borderRadius: BorderRadius.circular(18),
                    child: InputDecorator(
                      decoration: const InputDecoration(labelText: 'Date'),
                      child: Text(AppFormatters.date(_selectedDate)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _itemsController,
                    maxLines: 3,
                    decoration: const InputDecoration(labelText: 'Items'),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _quantityController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Quantity',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Counter note',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This screen stays lightweight by design. It mirrors a quick pharmacy sale while keeping the purchase workflow separate.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
      initialDate: _selectedDate,
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _reset() {
    setState(() {
      _customerController.text = '';
      _invoiceController.text = 'SAL-2026-032';
      _itemsController.text = '';
      _quantityController.text = '';
      _amountController.text = '';
      _selectedDate = DateTime.now();
    });
  }

  void _save() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sales transaction captured locally.')),
    );
  }
}
