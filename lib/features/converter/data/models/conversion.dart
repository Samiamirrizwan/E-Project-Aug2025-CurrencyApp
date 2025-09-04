// lib/features/converter/data/models/conversion.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Conversion {
  final String fromCurrency;
  final String toCurrency;
  final double amount;
  final double result;
  final DateTime date;

  Conversion({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
    required this.result,
    required this.date,
  });

  // Creates a Conversion object from a Firestore document
  factory Conversion.fromJson(Map<String, dynamic> json) {
    return Conversion(
      fromCurrency: json['fromCurrency'],
      toCurrency: json['toCurrency'],
      amount: (json['amount'] as num).toDouble(),
      result: (json['result'] as num).toDouble(),
      // Firestore Timestamps need to be converted to DateTime
      date: (json['date'] as Timestamp).toDate(),
    );
  }

  // Converts a Conversion object to a Map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'amount': amount,
      'result': result,
      'date':
          Timestamp.fromDate(date), // Convert DateTime to Firestore Timestamp
    };
  }
}
