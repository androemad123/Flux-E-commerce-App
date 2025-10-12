import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:depi_graduation/presentation/widgets/app_text_button.dart';

import '../../generated/l10n.dart';

class RateProductScreen extends StatefulWidget {
  const RateProductScreen({super.key});

  @override
  State<RateProductScreen> createState() => _RateProductScreenState();
}

class _RateProductScreenState extends State<RateProductScreen> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,color: Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          S.of(context).rateProductTitle,
          style: boldStyle(fontSize: 18.sp, color: ColorManager.darkGrayLight),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Info box
            Container(
              height: 56.h,
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: ColorManager.darkGrayLight,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.card_giftcard, color: Colors.white, size: 20.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      S.of(context).submitReviewInfo,
                      style: regularStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // Star rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: ColorManager.greenLight,
                    size: 36.sp,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 16.h),

            // Text field
            TextField(
              controller: _reviewController,
              maxLines: 7,
              maxLength: 200,
              decoration: InputDecoration(
                hintText: S.of(context).reviewFieldHint,
                hintStyle: regularStyle(
                  fontSize: 14.sp,
                  color: ColorManager.lightGrayLight,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.black12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.black12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.black12),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Upload image/video
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildUploadBox(Icons.image, S.of(context).uploadImage),
                SizedBox(width: 16.w),
                _buildUploadBox(Icons.camera_alt, S.of(context).uploadCamera),
              ],
            ),
            SizedBox(height: 40.h),

            // Submit button
            AppTextButton(
              width: 315,
              text: S.of(context).submitReview,
              onPressed: () {
                // Handle submit
              },
              fontSize: 20,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadBox(IconData icon, String label) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(radius: Radius.circular(12),
        color: Colors.black12,
        dashPattern: [10, 5],
        strokeWidth: 2,
        padding: EdgeInsets.all(16),
      ),
      child: Icon(icon, color: Colors.black12, size: 28.sp),
    );
  }
}
