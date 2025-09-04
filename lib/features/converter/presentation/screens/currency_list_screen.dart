import 'package:currensee/features/converter/providers/converter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CurrencyListScreen extends ConsumerWidget {
  const CurrencyListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currenciesAsync = ref.watch(currenciesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Select Currency')),
      body: currenciesAsync.when(
        data: (currencies) {
          final currencyList = currencies.entries.toList();
          return ListView.builder(
            itemCount: currencyList.length,
            itemBuilder: (context, index) {
              final code = currencyList[index].key;
              final name = currencyList[index].value;
              return ListTile(
                title: Text(code),
                subtitle: Text(name),
                onTap: () {
                  context.pop(code);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
