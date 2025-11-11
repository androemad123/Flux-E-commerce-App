class Invitation {
  final String id;
  final String senderEmail;
  final String receiverEmail;
  final String status;
  final DateTime sentAt;

  Invitation({
    required this.id,
    required this.senderEmail,
    required this.receiverEmail,
    required this.status,
    required this.sentAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'status': status,
      'sentAt': sentAt.toIso8601String(),
    };
  }

  factory Invitation.fromMap(Map<String, dynamic> map, String id) {
    return Invitation(
      id: id,
      senderEmail: map['senderEmail'] ?? '',
      receiverEmail: map['receiverEmail'] ?? '',
      status: map['status'] ?? 'pending',
      sentAt: DateTime.parse(map['sentAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}
