import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/models/invitation.dart';
import 'invitation_state.dart';
import 'invitation_event.dart';

class InvitationsBloc extends Bloc<InvitationsEvent, InvitationsState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  InvitationsBloc() : super(InvitationsInitial()) {
    on<LoadInvitations>((event, emit) async {
      emit(InvitationsLoading());
      try {
        final snapshot = await _firestore
            .collection('invitations')
            .where('receiverEmail', isEqualTo: event.userEmail)
            .get();

        final invitations = snapshot.docs
            .map((doc) => Invitation.fromMap(doc.data(), doc.id))
            .toList();

        emit(InvitationsLoaded(invitations));
      } catch (e) {
        emit(InvitationsError(e.toString()));
      }
    });

    on<SendInvitation>((event, emit) async {
      try {
        await _firestore.collection('invitations').add({
          'senderEmail': event.senderEmail,
          'receiverEmail': event.receiverEmail,
          'status': 'pending',
          'sentAt': DateTime.now().toIso8601String(),
          if (event.sharedCartId != null) 'sharedCartId': event.sharedCartId,
          if (event.invitationType != null) 'invitationType': event.invitationType,
        });
        emit(InvitationSent());
      } catch (e) {
        emit(InvitationsError(e.toString()));
      }
    });

    on<UpdateInvitationStatus>((event, emit) async {
      emit(InvitationsLoading());
      try {
        // Get the invitation first to check if it's a shared cart invitation
        final invitationDoc = await _firestore
            .collection('invitations')
            .doc(event.invitationId)
            .get();
        
        if (!invitationDoc.exists) {
          emit(InvitationsError('Invitation not found'));
          return;
        }

        final invitationData = invitationDoc.data()!;
        final invitation = Invitation.fromMap(invitationData, event.invitationId);

        // Update invitation status
        await _firestore
            .collection('invitations')
            .doc(event.invitationId)
            .update({'status': event.newStatus});

        // If accepted and it's a shared cart invitation, add user as collaborator
        if (event.newStatus == 'accepted' && 
            invitation.sharedCartId != null && 
            invitation.invitationType == 'sharedCart') {
          // Get user ID from email
          final userSnapshot = await _firestore
              .collection('users')
              .where('email', isEqualTo: invitation.receiverEmail)
              .limit(1)
              .get();

          if (userSnapshot.docs.isNotEmpty) {
            final userId = userSnapshot.docs.first.id;
            // Add user as collaborator to the shared cart
            final cartRef = _firestore.collection('sharedCarts').doc(invitation.sharedCartId);
            await cartRef.update({
              'collabs': FieldValue.arrayUnion([userId]),
              'updatedAt': DateTime.now().toIso8601String(),
            });
          }
        }

        emit(InvitationUpdated());
      } catch (e) {
        emit(InvitationsError(e.toString()));
      }
    });
  }
}
