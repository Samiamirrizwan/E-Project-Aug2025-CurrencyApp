import 'package:flutter/material.dart';

class CurrencySelector extends StatelessWidget {
  final String label;
  final String currencyCode;
  final VoidCallback onTap;
  final TextEditingController? amountController;
  final bool isResult;
  final Widget? resultWidget;

  const CurrencySelector({
    super.key,
    required this.label,
    required this.currencyCode,
    required this.onTap,
    this.amountController,
    this.isResult = false,
    this.resultWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall),
          Row(
            children: [
              InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      // In a real app, you'd have flag icons
                      Text(currencyCode,
                          style: Theme.of(context).textTheme.headlineSmall),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: isResult
                    ? Align(
                        alignment: Alignment.centerRight, child: resultWidget)
                    : TextField(
                        controller: amountController,
                        textAlign: TextAlign.right,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.00',
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
