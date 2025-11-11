import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import'../../../data/models/invitation.dart';
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
        });
        emit(InvitationSent());
      } catch (e) {
        emit(InvitationsError(e.toString()));
      }
    });

    on<UpdateInvitationStatus>((event, emit) async {
      emit(InvitationsLoading());
      try {
        await _firestore
            .collection('invitations')
            .doc(event.invitationId)
            .update({'status': event.newStatus});

        emit(InvitationUpdated());
      } catch (e) {
        emit(InvitationsError(e.toString()));
      }
    });
  }
}
