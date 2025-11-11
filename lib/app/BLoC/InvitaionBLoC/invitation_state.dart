import'../../../data/models/invitation.dart';

abstract class InvitationsState {}

class InvitationsInitial extends InvitationsState {}
class InvitationsLoading extends InvitationsState {}
class InvitationsLoaded extends InvitationsState {
  final List<Invitation> invitations;
  InvitationsLoaded(this.invitations);
}
class InvitationsError extends InvitationsState {
  final String message;
  InvitationsError(this.message);
}
class InvitationSent extends InvitationsState {}
class InvitationUpdated extends InvitationsState {}
