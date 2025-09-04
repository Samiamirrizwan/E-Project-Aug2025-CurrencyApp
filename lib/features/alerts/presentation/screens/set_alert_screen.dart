// lib/features/alerts/presentation/screens/set_alert_screen.dart

import 'package:currensee/features/alerts/data/models/rate_alert.dart';
import 'package:currensee/features/alerts/providers/alerts_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SetAlertScreen extends ConsumerWidget {
  const SetAlertScreen({super.key});

  void _showAddAlertDialog(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final fromController = TextEditingController();
    final toController = TextEditingController();
    final rateController = TextEditingController();
    bool isAbove = true; // Use a stateful builder for the switch

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add New Alert'),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: fromController,
                      decoration: const InputDecoration(
                          labelText: 'From Currency (e.g., USD)'),
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      controller: toController,
                      decoration: const InputDecoration(
                          labelText: 'To Currency (e.g., PKR)'),
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      controller: rateController,
                      decoration:
                          const InputDecoration(labelText: 'Target Rate'),
                      keyboardType: TextInputType.number,
                      validator: (val) => val!.isEmpty ? 'Required' : null,
                    ),
                    SwitchListTile(
                      title: const Text('Alert condition'),
                      subtitle: Text(
                          'Alert when rate is ${isAbove ? 'ABOVE' : 'BELOW'} target'),
                      value: isAbove,
                      onChanged: (val) => setState(() => isAbove = val),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                FilledButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final newAlert = RateAlert(
                        fromCurrency: fromController.text.toUpperCase(),
                        toCurrency: toController.text.toUpperCase(),
                        targetRate: double.parse(rateController.text),
                        isAbove: isAbove,
                      );
                      ref
                          .read(alertsNotifierProvider.notifier)
                          .addAlert(newAlert);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alertsAsync = ref.watch(alertsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Alerts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_alert),
            onPressed: () => _showAddAlertDialog(context, ref),
            tooltip: 'Add Alert',
          ),
        ],
      ),
      body: alertsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (alerts) {
          if (alerts.isEmpty) {
            return const Center(child: Text('No rate alerts set.'));
          }
          return ListView.builder(
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              final alert = alerts[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: ListTile(
                  leading: const Icon(Icons.show_chart),
                  title: Text('${alert.fromCurrency} → ${alert.toCurrency}'),
                  subtitle: Text(
                      'Notify when rate is ${alert.isAbove ? 'above' : 'below'} ${alert.targetRate}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline,
                        color: Colors.redAccent),
                    onPressed: () => ref
                        .read(alertsNotifierProvider.notifier)
                        .removeAlert(alert.id!),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
