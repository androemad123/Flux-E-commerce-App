import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinalCheckoutScreen extends StatefulWidget {
  const FinalCheckoutScreen({super.key, required this.goNext});
  final void Function() goNext;
  @override
  State<FinalCheckoutScreen> createState() => _FinalCheckoutScreenState();
}

class _FinalCheckoutScreenState extends State<FinalCheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Completed',
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.primary,
                fontSize: FontSize.s26,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Container(
              decoration: BoxDecoration(
                border: null,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/Vector.png',
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Center(
              child: Text.rich(
                  TextSpan(style: theme.textTheme.bodyLarge, children: [
                TextSpan(text: 'Thank you for your purchase.\n'),
                TextSpan(
                    text: 'You can view your order in ‘My Orders’ section.')
              ])),
            ),
            Spacer(),
            AppTextButton(
              onPressed: widget.goNext,
              text: 'Continue Payment',
              width: double.infinity,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
