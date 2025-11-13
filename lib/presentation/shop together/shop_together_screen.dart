import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_graduation/app/BLoC/InvitaionBLoC/invitation_bloc.dart';
import 'package:depi_graduation/app/BLoC/InvitaionBLoC/invitation_event.dart';
import 'package:depi_graduation/app/BLoC/SharedCartBLoC/shared_cart_bloc.dart';
import 'package:depi_graduation/app/BLoC/SharedCartBLoC/shared_cart_event.dart';
import 'package:depi_graduation/app/BLoC/SharedCartBLoC/shared_cart_state.dart';
import 'package:depi_graduation/data/models/shared_cart.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:depi_graduation/presentation/shop%20together/shared_cart_details_screen.dart';
import 'package:depi_graduation/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopTogetherScreen extends StatefulWidget {
  const ShopTogetherScreen({super.key});

  @override
  State<ShopTogetherScreen> createState() => _ShopTogetherScreenState();
}

class _ShopTogetherScreenState extends State<ShopTogetherScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final Map<String, String> _userNames = {}; // Cache for user names
  List<String>? _pendingInvitations; // Store emails to invite after cart creation
  String? _pendingSenderEmail; // Store sender email for pending invitations

  @override
  void initState() {
    super.initState();
    _loadSharedCarts();
  }

  void _loadSharedCarts() {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      context.read<SharedCartBloc>().add(LoadSharedCarts(userId));
    }
  }

  Future<String> _getUserName(String userId) async {
    if (_userNames.containsKey(userId)) {
      return _userNames[userId]!;
    }
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      final name = doc.data()?['name'] as String? ?? 'User';
      _userNames[userId] = name;
      return name;
    } catch (e) {
      return 'User';
    }
  }

  Future<String?> _getUserEmail() async {
    final user = _auth.currentUser;
    if (user?.email != null) return user!.email;
    
    // Fallback: get email from Firestore
    try {
      final doc = await _firestore.collection('users').doc(user?.uid).get();
      return doc.data()?['email'] as String?;
    } catch (e) {
      return null;
    }
  }

  void _showCreateCartDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final List<String> invitedEmails = [];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(S.of(context).createSharedCart),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: S.of(context).enterCartName,
                    border: OutlineInputBorder(),
                    labelText: S.of(context).cartName,
                  ),
                  autofocus: true,
                ),
                const SizedBox(height: 16),
                Text(S.of(context).invitePeopleByEmail),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: S.of(context).enterEmail,
                          border: OutlineInputBorder(),
                          labelText: S.of(context).email,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        final email = emailController.text.trim();
                        if (email.isNotEmpty && 
                            email.contains('@') && 
                            !invitedEmails.contains(email)) {
                          setState(() {
                            invitedEmails.add(email);
                            emailController.clear();
                          });
                        }
                      },
                    ),
                  ],
                ),
                if (invitedEmails.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ...invitedEmails.map((email) => Chip(
                    label: Text(email),
                    onDeleted: () {
                      setState(() {
                        invitedEmails.remove(email);
                      });
                    },
                  )),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isNotEmpty) {
                  final userId = _auth.currentUser?.uid;
                  final senderEmail = await _getUserEmail();
                  
                  if (userId != null && senderEmail != null) {
                    // Store invitations to send after cart creation
                    if (invitedEmails.isNotEmpty) {
                      _pendingInvitations = List.from(invitedEmails);
                      _pendingSenderEmail = senderEmail;
                    }
                    
                    // Create the cart - invitations will be sent in the listener
                    context.read<SharedCartBloc>().add(
                          CreateSharedCart(name: name, ownerId: userId),
                        );
                    
                    Navigator.pop(context);
                  }
                }
              },
              child: Text(S.of(context).create),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(S.of(context).shopTogether),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: boldStyle(fontSize: FontSize.s20, color: Colors.black87),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
        ),
      ),
      body: BlocConsumer<SharedCartBloc, SharedCartState>(
        listener: (context, state) {
          if (state is SharedCartCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(S.of(context).sharedCartCreatedSuccessfully)),
            );
            
            // Send pending invitations if any
            if (_pendingInvitations != null && 
                _pendingInvitations!.isNotEmpty && 
                _pendingSenderEmail != null) {
              final cartId = state.cart.id;
              for (final email in _pendingInvitations!) {
                context.read<InvitationsBloc>().add(
                  SendInvitation(
                    _pendingSenderEmail!,
                    email,
                    sharedCartId: cartId,
                    invitationType: 'sharedCart',
                  ),
                );
              }
              _pendingInvitations = null;
              _pendingSenderEmail = null;
            }
            
            _loadSharedCarts();
          } else if (state is SharedCartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            _pendingInvitations = null;
            _pendingSenderEmail = null;
          }
        },
        builder: (context, state) {
          // If state is SharedCartItemsLoaded (from cart details), reload carts when coming back
          if (state is SharedCartItemsLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _loadSharedCarts();
              }
            });
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is SharedCartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SharedCartsLoaded) {
            final carts = state.carts;
            if (carts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined,
                        size: 64, color: ColorManager.lightGrayLight),
                    const SizedBox(height: 16),
                    Text(
                      S.of(context).noSharedCartsYet,
                      style: TextStyle(
                        color: ColorManager.lightGrayLight,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context).createOneToStartShoppingTogether,
                      style: TextStyle(
                        color: ColorManager.lighterGrayLight,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async => _loadSharedCarts(),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: ListView.separated(
                  itemCount: carts.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12.h),
                  itemBuilder: (context, index) {
                    final cart = carts[index];
                    final isOwner = cart.owner == _auth.currentUser?.uid;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SharedCartDetailsScreen(cart: cart),
                          ),
                        );
                      },
                      child: Container(
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
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    cart.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                if (isOwner)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      S.of(context).owner,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(Icons.group,
                                    color: ColorManager.lighterGrayLight,
                                    size: 18.sp),
                                SizedBox(width: 6.w),
                                Expanded(
                                  child: FutureBuilder<String>(
                                    future: _buildMembersText(cart),
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.data ?? 'Loading...',
                                        style: TextStyle(
                                          color: ColorManager.lightGrayLight,
                                          fontSize: 14.sp,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }

          if (state is SharedCartError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${state.message}',
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadSharedCarts,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('No data'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateCartDialog,
        backgroundColor: ColorManager.primaryLight,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<String> _buildMembersText(SharedCart cart) async {
    final currentUserId = _auth.currentUser?.uid;
    final allMembers = [cart.owner, ...cart.collabs];
    final memberNames = <String>[];

    for (final userId in allMembers) {
      if (userId == currentUserId) {
        memberNames.add('You');
      } else {
        final name = await _getUserName(userId);
        memberNames.add(name);
      }
    }

    return memberNames.join(', ');
  }
}

