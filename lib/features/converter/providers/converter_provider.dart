import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:currensee/features/converter/data/currency_repository.dart';

// Provides the list of available currencies
final currenciesProvider = FutureProvider<Map<String, String>>((ref) async {
  final repository = ref.watch(currencyRepositoryProvider);
  return repository.getCurrencies();
});

// State for the currency converter
class ConverterState {
  final String fromCurrency;
  final String toCurrency;
  final String amount;
  final AsyncValue<double> conversionResult;

  ConverterState({
    this.fromCurrency = 'USD',
    this.toCurrency = 'PKR',
    this.amount = '1',
    this.conversionResult = const AsyncData(0.0),
  });

  ConverterState copyWith({
    String? fromCurrency,
    String? toCurrency,
    String? amount,
    AsyncValue<double>? conversionResult,
  }) {
    return ConverterState(
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      amount: amount ?? this.amount,
      conversionResult: conversionResult ?? this.conversionResult,
    );
  }
}

// Notifier to manage the converter's state
class ConverterNotifier extends StateNotifier<ConverterState> {
  final Ref _ref;
  ConverterNotifier(this._ref) : super(ConverterState());

  void setFromCurrency(String currency) {
    state = state.copyWith(fromCurrency: currency);
    convert();
  }

  void setToCurrency(String currency) {
    state = state.copyWith(toCurrency: currency);
    convert();
  }

  void setAmount(String amount) {
    state = state.copyWith(amount: amount);
  }

  void swapCurrencies() {
    final from = state.fromCurrency;
    final to = state.toCurrency;
    state = state.copyWith(fromCurrency: to, toCurrency: from);
    convert();
  }

  Future<void> convert() async {
    final amount = double.tryParse(state.amount) ?? 0.0;
    if (amount <= 0) {
      state = state.copyWith(conversionResult: const AsyncData(0.0));
      return;
    }

    state = state.copyWith(conversionResult: const AsyncLoading());

    try {
      final repository = _ref.read(currencyRepositoryProvider);
      final rate = await repository.getConversionRate(
          state.fromCurrency, state.toCurrency);
      final result = amount * rate;
      state = state.copyWith(conversionResult: AsyncData(result));
    } catch (e) {
      state =
          state.copyWith(conversionResult: AsyncError(e, StackTrace.current));
    }
  }
}

final converterProvider =
    StateNotifierProvider<ConverterNotifier, ConverterState>((ref) {
  return ConverterNotifier(ref);
});
