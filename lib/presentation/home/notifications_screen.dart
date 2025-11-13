import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_graduation/app/BLoC/InvitaionBLoC/invitation_bloc.dart';
import 'package:depi_graduation/app/BLoC/InvitaionBLoC/invitation_event.dart';
import 'package:depi_graduation/app/BLoC/InvitaionBLoC/invitation_state.dart';
import 'package:depi_graduation/data/models/invitation.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final Map<String, String> _senderNames = {}; // Cache for sender names
  final Map<String, String> _cartNames = {}; // Cache for cart names

  @override
  void initState() {
    super.initState();
    _loadInvitations();
  }

  Future<String?> _getUserEmail() async {
    final user = _auth.currentUser;
    if (user?.email != null) return user!.email;

    try {
      final doc = await _firestore.collection('users').doc(user?.uid).get();
      return doc.data()?['email'] as String?;
    } catch (e) {
      return null;
    }
  }

  void _loadInvitations() async {
    final email = await _getUserEmail();
    if (email != null) {
      context.read<InvitationsBloc>().add(LoadInvitations(email));
    }
  }

  Future<String> _getSenderName(String senderEmail) async {
    if (_senderNames.containsKey(senderEmail)) {
      return _senderNames[senderEmail]!;
    }
    try {
      final snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: senderEmail)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final name = snapshot.docs.first.data()['name'] as String? ?? 'User';
        _senderNames[senderEmail] = name;
        return name;
      }
      return 'User';
    } catch (e) {
      return 'User';
    }
  }

  Future<String> _getCartName(String cartId) async {
    if (_cartNames.containsKey(cartId)) {
      return _cartNames[cartId]!;
    }
    try {
      final doc = await _firestore.collection('sharedCarts').doc(cartId).get();
      if (doc.exists) {
        final name = doc.data()?['name'] as String? ?? 'Shared Cart';
        _cartNames[cartId] = name;
        return name;
      }
      return 'Shared Cart';
    } catch (e) {
      return 'Shared Cart';
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  void _handleAcceptInvitation(Invitation invitation) {
    context.read<InvitationsBloc>().add(
          UpdateInvitationStatus(invitation.id, 'accepted'),
        );
  }

  void _handleRejectInvitation(Invitation invitation) {
    context.read<InvitationsBloc>().add(
          UpdateInvitationStatus(invitation.id, 'rejected'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Notifications",
          style: TextStyle(
            fontFamily: FontConstants.fontFamily,
            fontWeight: FontWeightManager.bold,
            fontSize: FontSize.s20,
            color: ColorManager.primaryLight,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black87,
            )),
      ),
      body: BlocConsumer<InvitationsBloc, InvitationsState>(
        listener: (context, state) {
          if (state is InvitationUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Invitation updated')),
            );
            _loadInvitations();
          } else if (state is InvitationsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is InvitationsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InvitationsLoaded) {
            final invitations = state.invitations
                .where((inv) => inv.status == 'pending')
                .toList();

            if (invitations.isEmpty) {
              return Center(
                child: Text(
                  "No notifications yet",
                  style: TextStyle(
                    fontFamily: FontConstants.fontFamily,
                    fontWeight: FontWeightManager.regular,
                    fontSize: FontSize.s16,
                    color: ColorManager.lightGrayLight,
                  ),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async => _loadInvitations(),
              child: ListView.separated(
                padding: EdgeInsets.all(16.w),
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemCount: invitations.length,
                itemBuilder: (context, index) {
                  final invitation = invitations[index];
                  return FutureBuilder<Map<String, String>>(
                    future: _buildInvitationData(invitation),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const SizedBox.shrink();
                      }
                      final data = snapshot.data!;

                      return Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: ColorManager.darkGrayLight,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title']!,
                              style: TextStyle(
                                fontFamily: FontConstants.fontFamily,
                                fontWeight: FontWeightManager.semiBold,
                                fontSize: FontSize.s16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              data['subtitle']!,
                              style: TextStyle(
                                fontFamily: FontConstants.fontFamily,
                                fontWeight: FontWeightManager.regular,
                                fontSize: FontSize.s14,
                                color: ColorManager.lighterGrayLight,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data['time']!,
                                  style: TextStyle(
                                    fontFamily: FontConstants.fontFamily,
                                    fontWeight: FontWeightManager.regular,
                                    fontSize: FontSize.s12,
                                    color: ColorManager.lightGrayLight,
                                  ),
                                ),
                                if (invitation.status == 'pending' &&
                                    invitation.invitationType == 'sharedCart')
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            _handleRejectInvitation(invitation),
                                        child: Text(
                                          'Reject',
                                          style: TextStyle(
                                            color: Colors.red.shade300,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            _handleAcceptInvitation(invitation),
                                        child: Text(
                                          'Accept',
                                          style: TextStyle(
                                            color: Colors.green.shade300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          if (state is InvitationsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadInvitations,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('No data'));
        },
      ),
    );
  }

  Future<Map<String, String>> _buildInvitationData(
      Invitation invitation) async {
    final senderName = await _getSenderName(invitation.senderEmail);

    if (invitation.invitationType == 'sharedCart' &&
        invitation.sharedCartId != null) {
      final cartName = await _getCartName(invitation.sharedCartId!);
      return {
        'title': 'Cart shared with you',
        'subtitle': '$senderName invited you to join "$cartName".',
        'time': _formatTime(invitation.sentAt),
      };
    }

    return {
      'title': 'New invitation',
      'subtitle': '$senderName sent you an invitation.',
      'time': _formatTime(invitation.sentAt),
    };
  }
}
