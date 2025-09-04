import 'package:currensee/features/converter/data/models/conversion.dart'; // ** NEW **
import 'package:currensee/features/converter/presentation/widgets/currency_selector.dart';
import 'package:currensee/features/converter/providers/converter_provider.dart';
import 'package:currensee/features/history/providers/history_provider.dart'; // ** NEW **
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ConverterScreen extends ConsumerStatefulWidget {
  const ConverterScreen({super.key});
  @override
  ConsumerState<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends ConsumerState<ConverterScreen> {
  final _amountController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    _amountController.addListener(() {
      ref.read(converterProvider.notifier).setAmount(_amountController.text);
    });
    // Perform initial conversion
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(converterProvider.notifier).convert();
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final converterState = ref.watch(converterProvider);
    final converterNotifier = ref.read(converterProvider.notifier);

    // ** NEW: Listen for successful conversions to save them to history. **
    ref.listen<ConverterState>(converterProvider, (previous, next) {
      // Check if the previous state was loading and the new state has data.
      final bool wasLoading = previous?.conversionResult.isLoading ?? false;
      final bool hasValue = next.conversionResult.hasValue;

      // This ensures we only save once, right after a successful conversion.
      if (wasLoading && hasValue) {
        final double? amount = double.tryParse(next.amount);
        final double? result = next.conversionResult.value;

        if (amount != null && result != null && amount > 0) {
          // Create the conversion record
          final newConversion = Conversion(
            fromCurrency: next.fromCurrency,
            toCurrency: next.toCurrency,
            amount: amount,
            result: result,
            date: DateTime.now(),
          );

          // Save the record to Firestore using the history provider
          ref
              .read(historyNotifierProvider.notifier)
              .addConversion(newConversion);

          // Show feedback to the user
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Saved to conversion history!'),
                backgroundColor: Colors.green,
              ),
            );
        }
      }
    });

    final NumberFormat currencyFormatter = NumberFormat.currency(symbol: '');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currensee'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // FROM
            CurrencySelector(
              label: 'From',
              currencyCode: converterState.fromCurrency,
              onTap: () async {
                final selected =
                    await context.push<String>('/converter/currency-list');
                if (selected != null) {
                  converterNotifier.setFromCurrency(selected);
                }
              },
              amountController: _amountController,
            ),

            // SWAP BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: IconButton(
                icon: const Icon(Icons.swap_vert, size: 32),
                onPressed: converterNotifier.swapCurrencies,
              ),
            ),

            // TO
            CurrencySelector(
              label: 'To',
              currencyCode: converterState.toCurrency,
              isResult: true,
              resultWidget: converterState.conversionResult.when(
                data: (value) => Text(
                  currencyFormatter.format(value),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                loading: () => const SizedBox(
                    height: 24, width: 24, child: CircularProgressIndicator()),
                error: (err, stack) =>
                    const Icon(Icons.error, color: Colors.red),
              ),
              onTap: () async {
                final selected =
                    await context.push<String>('/converter/currency-list');
                if (selected != null) converterNotifier.setToCurrency(selected);
              },
            ),

            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: converterNotifier.convert,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Convert'),
            )
          ],
        ),
      ),
    );
  }
}
