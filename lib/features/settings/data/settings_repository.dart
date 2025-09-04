import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currensee/features/settings/data/models/support_ticket.dart';

/// Repository for handling settings-related data operations,
/// primarily for submitting support tickets to Firestore.
class SettingsRepository {
  final FirebaseFirestore _firestore;

  SettingsRepository(this._firestore);

  Future<void> submitSupportTicket(SupportTicket ticket) async {
    try {
      await _firestore.collection('supportTickets').add(ticket.toMap());
    } catch (e) {
      // Propagate error to be handled by the UI layer
      throw Exception('Error submitting ticket: $e');
    }
  }
}
