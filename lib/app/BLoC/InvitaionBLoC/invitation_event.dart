abstract class InvitationsEvent {}

class SendInvitation extends InvitationsEvent {
  final String senderEmail;
  final String receiverEmail;
  final String? sharedCartId;
  final String? invitationType;
  SendInvitation(this.senderEmail, this.receiverEmail, {this.sharedCartId, this.invitationType});
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
