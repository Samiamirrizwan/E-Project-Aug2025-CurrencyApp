import 'package:flutter_riverpod/flutter_riverpod.dart';

// Mock data for currencies. In a real app, this would come from an API.
const Map<String, String> _mockCurrencies = {
  'USD': 'United States Dollar',
  'EUR': 'Euro',
  'JPY': 'Japanese Yen',
  'GBP': 'British Pound',
  'PKR': 'Pakistani Rupee',
  'INR': 'Indian Rupee',
  'AUD': 'Australian Dollar',
  'CAD': 'Canadian Dollar',
};

// Mock exchange rates relative to USD.
const Map<String, double> _mockRates = {
  'USD': 1.0,
  'EUR': 0.92,
  'JPY': 157.5,
  'GBP': 0.78,
  'PKR': 278.5,
  'INR': 83.4,
  'AUD': 1.5,
  'CAD': 1.37,
};

class CurrencyRepository {
  Future<Map<String, String>> getCurrencies() async {
    // Simulate a network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockCurrencies;
  }

  Future<double> getConversionRate(String from, String to) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final fromRate = _mockRates[from] ?? 1.0;
    final toRate = _mockRates[to] ?? 1.0;
    // Convert 'from' to USD, then USD to 'to'
    return toRate / fromRate;
  }
}

final currencyRepositoryProvider = Provider<CurrencyRepository>((ref) {
  return CurrencyRepository();
});
