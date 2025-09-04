// lib/features/alerts/data/models/rate_alert.dart

class RateAlert {
  final String? id; // Document ID from Firestore
  final String fromCurrency;
  final String toCurrency;
  final double targetRate;
  final bool isAbove;

  RateAlert({
    this.id,
    required this.fromCurrency,
    required this.toCurrency,
    required this.targetRate,
    this.isAbove = true,
  });

  // Factory constructor to create a RateAlert from a Firestore document
  factory RateAlert.fromJson(Map<String, dynamic> json, String documentId) {
    return RateAlert(
      id: documentId,
      fromCurrency: json['fromCurrency'],
      toCurrency: json['toCurrency'],
      targetRate: (json['targetRate'] as num).toDouble(),
      isAbove: json['isAbove'],
    );
  }

  // Method to convert a RateAlert instance to a map for Firestore
  Map<String, dynamic> toJson() {
    return {
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'targetRate': targetRate,
      'isAbove': isAbove,
    };
  }
}
