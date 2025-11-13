import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/BLoC/ProductBLoC/ProductBLoC.dart';
import '../../utils/seed_products_helper.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            )),
        backgroundColor: ColorManager.whiteLight,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppPadding.p10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: AppPadding.p18),
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30.r,
                    backgroundImage: NetworkImage("https://wallpapers.com/images/hd/generic-male-avatar-icon-piiktqtfffyzulft.jpg"),
                  ),
                  title: Text("Name of user" , style: TextStyle(
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.primaryLight,
                  ),),
                  subtitle: Text("his email", style: TextStyle(
                    fontWeight: FontWeightManager.regular,
                    color: ColorManager.primaryLight,
                    fontSize: FontSize.s16,
                  ),),
                  trailing: IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
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
                    _buildTile(Icons.location_on, "Address"),
                    Divider(height: 1.h, thickness: 0.3.h, color: ColorManager.lighterGrayLight, indent: 12.w,),
                    _buildTile(Icons.payment_rounded, "Payment Method"),
                    Divider(height: 1.h, thickness: 0.3.h, color: ColorManager.lighterGrayLight, indent: 12.w,),
                    _buildTile(Icons.confirmation_num, "Voucher"),
                    Divider(height: 1.h, thickness: 0.3.h, color: ColorManager.lighterGrayLight, indent: 12.w,),
                    _buildTile(Icons.favorite, "My Wishlist"),
                    Divider(height: 1.h, thickness: 0.3.h, color: ColorManager.lighterGrayLight, indent: 12.w,),
                    _buildTile(Icons.star, "Rate this app"),
                    Divider(height: 1.h, thickness: 0.3.h, color: ColorManager.lighterGrayLight, indent: 12.w,),
                    _buildTile(Icons.logout, "Log out"),
                  ],
                ),
              ),
            ),
          ],
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
}
