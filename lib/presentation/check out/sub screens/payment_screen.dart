import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.goNext});
  final void Function() goNext;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IntrinsicHeight(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 2',
            style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey),
          ),
          Text(
            'Payment',
            style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.primary,
              fontSize: FontSize.s26,
            ),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _paymentMethodCard(theme, 'Cash', 'assets/images/Money icon.png'),
              SizedBox(
                width: 25.w,
              ),
              _paymentMethodCard(
                  theme, 'Credit Card', 'assets/images/Credit Card Icon.png',
                  color: ColorManager.lightGrayLight),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Divider(
            thickness: 0.5,
          ),
          ListTile(
            leading: Text(
              'Product Price',
              style: theme.textTheme.bodyLarge!.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            trailing: Text(
              '\$ 55',
              style: theme.textTheme.bodyLarge,
            ),
          ),
          Divider(
            thickness: 0.5,
          ),
          ListTile(
            leading: Text('Shipping',
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                )),
            trailing: Text(
              '\$ 55',
              style: theme.textTheme.bodyLarge,
            ),
          ),
          Divider(
            thickness: 0.5,
          ),
          ListTile(
            leading: Text(
              'SubTotal',
              style: theme.textTheme.bodyLarge,
            ),
            trailing: Text(
              '\$ 55',
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(
            height: 20.h,
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
    );
  }

  Widget _paymentMethodCard(ThemeData theme, String title, String imagePath,
      {Color? color}) {
    return Container(
      width: 135,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15.r),
          border: null,
          boxShadow: [
            BoxShadow(
                color: theme.shadowColor.withValues(alpha: 0.5),
                blurRadius: 10.0,
                spreadRadius: 5,
                offset: Offset(0, 10))
          ]),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15.r),
          border: null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              color: color ?? null,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              title,
              style: theme.textTheme.titleLarge!
                  .copyWith(color: ColorManager.lightGrayLight),
            )
          ],
        ),
      ),
    );
  }
}
