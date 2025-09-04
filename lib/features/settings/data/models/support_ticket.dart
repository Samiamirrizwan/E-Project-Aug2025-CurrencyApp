import 'package:cloud_firestore/cloud_firestore.dart';

/// Data model for a support ticket.
/// This structure is used to create and read ticket documents
/// from the Firestore 'supportTickets' collection.
class SupportTicket {
  final String? userId;
  final String? userEmail;
  final String subject;
  final String description;
  final Timestamp createdAt;
  final String status; // e.g., "open", "in_progress", "closed"

  SupportTicket({
    this.userId,
    this.userEmail,
    required this.subject,
    required this.description,
    required this.createdAt,
    this.status = 'open',
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userEmail': userEmail,
      'subject': subject,
      'description': description,
      'createdAt': createdAt,
      'status': status,
    };
  }
}
