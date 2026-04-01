import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_scaffold_wrapper.dart';
import '../../../core/widgets/search_text_field.dart';
import '../../../services/providers.dart';

class ChangePartyPage extends ConsumerStatefulWidget {
  const ChangePartyPage({super.key});

  @override
  ConsumerState<ChangePartyPage> createState() => _ChangePartyPageState();
}

class _ChangePartyPageState extends ConsumerState<ChangePartyPage> {
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
    final suppliers = ref.watch(suppliersProvider);
    final selectedId = ref.watch(
      invoiceFlowControllerProvider.select((state) => state.invoice?.party.id),
    );
    final filtered = suppliers.where((party) {
      final query = _query.toLowerCase();
      return party.name.toLowerCase().contains(query) ||
          party.city.toLowerCase().contains(query) ||
          party.gstin.toLowerCase().contains(query);
    }).toList();

    return AppScaffoldWrapper(
      title: 'Change Party',
      subtitle: 'Choose a supplier to replace the parsed party.',
      child: Column(
        children: [
          SearchTextField(
            hintText: 'Search supplier, city, or GSTIN',
            controller: _searchController,
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 16),
          ...filtered.map(
            (party) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                child: ListTile(
                  onTap: () => context.pop(party),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.12),
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(party.name.characters.first),
                  ),
                  title: Text(
                    party.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(
                    '${party.city} • ${party.gstin}\n${party.address}',
                  ),
                  isThreeLine: true,
                  trailing: Icon(
                    selectedId == party.id
                        ? Icons.check_circle_rounded
                        : Icons.chevron_right_rounded,
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
