import 'package:depi_graduation/app/BLoC/CheckoutBLoC/checkout_bloc.dart';
import 'package:depi_graduation/app/BLoC/CheckoutBLoC/checkout_event.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.goNext});
  final void Function() goNext;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final checkoutState = context.watch<CheckoutBloc>().state;
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
              _paymentMethodCard(
                theme,
                methodKey: 'cash',
                title: 'Cash',
                imagePath: 'assets/images/Money icon.png',
              ),
              SizedBox(
                width: 25.w,
              ),
              _paymentMethodCard(
                theme,
                methodKey: 'card',
                title: 'Credit Card',
                imagePath: 'assets/images/Credit Card Icon.png',
                color: ColorManager.lightGrayLight,
              ),
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
              '\$${checkoutState.subtotal.toStringAsFixed(2)}',
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
              '\$${checkoutState.shippingFee.toStringAsFixed(2)}',
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
              '\$${checkoutState.total.toStringAsFixed(2)}',
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Spacer(),
          AppTextButton(
            onPressed: () {
              if (selectedPaymentMethod == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select a payment method.'),
                  ),
                );
                return;
              }

              context.read<CheckoutBloc>().add(
                    CheckoutPaymentMethodSelected(selectedPaymentMethod!),
                  );
              widget.goNext();
            },
            text: 'Continue Payment',
            width: double.infinity,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Widget _paymentMethodCard(
    ThemeData theme, {
    required String methodKey,
    required String title,
    required String imagePath,
    Color? color,
  }) {
    final bool isSelected = selectedPaymentMethod == methodKey;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = methodKey;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 135,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color:
                isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.3),
              blurRadius: 8.0,
              spreadRadius: 2,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                color: color ?? (isSelected ? theme.colorScheme.primary : null),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                title,
                style: theme.textTheme.titleLarge!.copyWith(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : ColorManager.lightGrayLight,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
