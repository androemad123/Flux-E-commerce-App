abstract class InvitationsEvent {}

class SendInvitation extends InvitationsEvent {
  final String senderEmail;
  final String receiverEmail;
  SendInvitation(this.senderEmail, this.receiverEmail);
}

class LoadInvitations extends InvitationsEvent {
  final String userEmail;
  LoadInvitations(this.userEmail);
}

class UpdateInvitationStatus extends InvitationsEvent {
  final String invitationId;
  final String newStatus; // 'accepted' / 'rejected'
  UpdateInvitationStatus(this.invitationId, this.newStatus);
}
