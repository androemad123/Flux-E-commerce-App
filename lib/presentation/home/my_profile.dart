import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../firebase_services/firebase_auth_services.dart';
import '../../routing/routes.dart';
import '../../generated/l10n.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;
    final user = _auth.currentUser;
    final authService = FirebaseAuthServices();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.whiteLight,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: AppPadding.p18),
                child: Center(
                  child: FutureBuilder<DocumentSnapshot>(
                    future: user != null
                        ? _firestore.collection('users').doc(user.uid).get()
                        : null,
                    builder: (context, snapshot) {
                      String userName = S.of(context).nameOfUser;
                      String userEmail = S.of(context).hisEmail;

                      if (user != null) {
                        if (snapshot.hasData && snapshot.data!.exists) {
                          final data = snapshot.data!.data() as Map<String, dynamic>?;
                          userName = data?['name'] as String? ?? user.displayName ?? S.of(context).user;
                          userEmail = data?['email'] as String? ?? user.email ?? S.of(context).noEmail;
                        } else if (user.displayName != null || user.email != null) {
                          userName = user.displayName ?? S.of(context).user;
                          userEmail = user.email ?? S.of(context).noEmail;
                        }
                      }

                      return ListTile(
                        leading: CircleAvatar(
                          radius: 30.r,
                          backgroundImage: NetworkImage("https://wallpapers.com/images/hd/generic-male-avatar-icon-piiktqtfffyzulft.jpg"),
                        ),
                        title: Text(userName , style: TextStyle(
                          fontWeight: FontWeightManager.bold,
                          color: ColorManager.primaryLight,
                        ),),
                        subtitle: Text(userEmail, style: TextStyle(
                          fontWeight: FontWeightManager.regular,
                          color: ColorManager.primaryLight,
                          fontSize: FontSize.s16,
                        ),),
                        trailing: IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
                      );
                    },
                  ),
                ),
              ),
          
              SizedBox(height: 30.h,),
          
              Padding(
                padding: EdgeInsets.symmetric(vertical:AppPadding.p18 , horizontal: AppPadding.p8),
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.whiteLight,
                    border: Border.all(color: ColorManager.lighterGrayLight , width: 0.25),
                    borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                  BoxShadow(
                  color: ColorManager.lighterGrayLight.withOpacity(0.1),
                  blurRadius: 14.r,
                  offset: Offset(0, 4),
                ),],
          
                  ),
                  child: Column(
                    spacing: AppPadding.p14,
                    children: [
                      _buildTile(Icons.location_on, S.of(context).address),
                      Divider(height: 1.h, thickness: 0.3.h, color: ColorManager.lighterGrayLight, indent: 12.w,),
                      _buildTile(Icons.payment_rounded, S.of(context).paymentMethod),
                      Divider(height: 1.h, thickness: 0.3.h, color: ColorManager.lighterGrayLight, indent: 12.w,),
                      _buildTile(Icons.confirmation_num, S.of(context).voucher),
                      Divider(height: 1.h, thickness: 0.3.h, color: ColorManager.lighterGrayLight, indent: 12.w,),
                      _buildTile(Icons.favorite, S.of(context).myWishlist),
                      Divider(height: 1.h, thickness: 0.3.h, color: ColorManager.lighterGrayLight, indent: 12.w,),
                      _buildTile(Icons.star, S.of(context).rateThisApp),
                      Divider(height: 1.h, thickness: 0.3.h, color: ColorManager.lighterGrayLight, indent: 12.w,),
                      _buildLogoutTile(context, authService),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTile(IconData icon , String title){
    return ListTile(leading: Icon(icon , size: AppSize.s30, color: ColorManager.lighterGrayLight,),
      title: Text(title , style: TextStyle(
        fontSize: FontSize.s18,
        fontWeight: FontWeightManager.regular,
      ),),
      trailing: Icon(Icons.arrow_forward_ios , size: AppSize.s30, color: ColorManager.lighterGrayLight,),
      onTap: (){},
    );
  }

  Widget _buildLogoutTile(BuildContext context, FirebaseAuthServices authService) {
    return ListTile(
      leading: Icon(Icons.logout, size: AppSize.s30, color: Colors.red,),
      title: Text(S.of(context).logOut, style: TextStyle(
        fontSize: FontSize.s18,
        fontWeight: FontWeightManager.regular,
        color: Colors.red,
      ),),
      trailing: Icon(Icons.arrow_forward_ios , size: AppSize.s30, color: ColorManager.lighterGrayLight,),
      onTap: () async {
        // Show confirmation dialog
        final shouldLogout = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(S.of(context).logout),
            content: Text(S.of(context).areYouSureYouWantToLogout),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(S.of(context).cancel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: Text(S.of(context).logout),
              ),
            ],
          ),
        );

        if (shouldLogout == true) {
          try {
            await authService.signOut();
            // Navigate to login screen
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.loginRoute,
              (route) => false,
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${S.of(context).cancel}: $e')),
            );
          }
        }
      },
    );
  }
}
