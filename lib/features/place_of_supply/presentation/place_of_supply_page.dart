import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_scaffold_wrapper.dart';
import '../../../core/widgets/search_text_field.dart';
import '../../../services/providers.dart';

class PlaceOfSupplyPage extends ConsumerStatefulWidget {
  const PlaceOfSupplyPage({super.key});

  @override
  ConsumerState<PlaceOfSupplyPage> createState() => _PlaceOfSupplyPageState();
}

class _PlaceOfSupplyPageState extends ConsumerState<PlaceOfSupplyPage> {
  late final TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesOfSupplyProvider);
    final selected = ref.watch(
      invoiceFlowControllerProvider.select(
        (state) => state.invoice?.placeOfSupply,
      ),
    );
    final filtered = places
        .where(
          (place) =>
              place.name.toLowerCase().contains(_query.toLowerCase()) ||
              place.code.contains(_query),
        )
        .toList();

    return AppScaffoldWrapper(
      title: 'Place of Supply',
      subtitle: 'Search and select the applicable GST place of supply.',
      child: Column(
        children: [
          SearchTextField(
            hintText: 'Search state or GST code',
            controller: _searchController,
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 16),
          ...filtered.map(
            (place) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: ListTile(
                  onTap: () => context.pop(place),
                  title: Text(
                    place.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text('GST code ${place.code}'),
                  trailing: Icon(
                    selected?.code == place.code
                        ? Icons.radio_button_checked
                        : Icons.radio_button_off,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
