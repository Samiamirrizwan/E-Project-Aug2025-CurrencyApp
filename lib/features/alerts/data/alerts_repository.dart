// lib/features/alerts/data/alerts_repository.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currensee/features/alerts/data/models/rate_alert.dart';

class AlertsRepository {
  final FirebaseFirestore _firestore;
  AlertsRepository(this._firestore);

  CollectionReference _getAlertsCollection(String userId) {
    return _firestore.collection('users').doc(userId).collection('alerts');
  }

  Stream<List<RateAlert>> getAlertsStream(String userId) {
    return _getAlertsCollection(userId).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              RateAlert.fromJson(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<void> addAlert(String userId, RateAlert alert) async {
    await _getAlertsCollection(userId).add(alert.toJson());
  }

  Future<void> removeAlert(String userId, String alertId) async {
    await _getAlertsCollection(userId).doc(alertId).delete();
  }
}
