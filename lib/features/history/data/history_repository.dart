// lib/features/history/data/history_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currensee/features/converter/data/models/conversion.dart';

class HistoryRepository {
  final FirebaseFirestore _firestore;
  HistoryRepository(this._firestore);

  // Get a real-time stream of conversion history for a user
  Stream<List<Conversion>> getHistoryStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('conversions')
        .orderBy('date', descending: true)
        .limit(50) // Limit to the latest 50 conversions for performance
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Conversion.fromJson(doc.data()))
          .toList();
    });
  }

  // **NEW**: Add a conversion document to Firestore
  Future<void> addConversion(String userId, Conversion conversion) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('conversions')
        .add(conversion.toJson());
  }

  // Clear all history for a user
  Future<void> clearHistory(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('conversions')
        .get();

    WriteBatch batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
