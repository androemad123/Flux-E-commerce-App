import 'package:depi_graduation/app/BLoC/CheckoutBLoC/checkout_bloc.dart';
import 'package:depi_graduation/app/BLoC/CheckoutBLoC/checkout_state.dart';
import 'package:depi_graduation/presentation/check%20out/sub%20screens/final_checkout_screen.dart';
import 'package:depi_graduation/presentation/check%20out/sub%20screens/payment_screen.dart';
import 'package:depi_graduation/presentation/check%20out/sub%20screens/shipping_screen.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:depi_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int currentStep = 0;
  void goToNextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    }
  }

  void goToPrevStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkoutState = context.watch<CheckoutBloc>().state;
    if (checkoutState.cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).checkOut),
        ),
        body: Center(
          child: Text(S.of(context).yourCartIsEmptyFull),
        ),
      );
    }

    final checkOutScreens = [
      ShippingScreen(goNext: goToNextStep),
      PaymentScreen(
        goNext: goToNextStep,
      ),
      const FinalCheckoutScreen(),
    ];

    return BlocListener<CheckoutBloc, CheckoutState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == CheckoutStatus.success) {
          setState(() {
            currentStep = 2;
          });
        } else if (state.status == CheckoutStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).checkOut),
          leading: currentStep == 0
              ? null
              : IconButton(onPressed: goToPrevStep, icon: const Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: EdgeInsets.all(AppPadding.p10),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) {
                          final isCompleted = index <= currentStep;
                          final iconsList = [
                            const Icon(Icons.location_on),
                            Icon(
                              Icons.credit_card,
                              color: isCompleted ? Colors.black : Colors.grey,
                            ),
                            Container(
                              padding: EdgeInsets.all(1.w),
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? Colors.black
                                    : Colors.grey.shade400,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.done,
                                color: Colors.white,
                              ),
                            ),
                          ];
                          return Row(
                            children: [
                              iconsList[index],
                              SizedBox(
                                width: 5.w,
                              ),
                              if (index < 2)
                                ...List.generate(
                                  5,
                                  (index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4), // spacing
                                    width: 5.w,
                                    height: 5.h,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              SizedBox(
                                width: 5.w,
                              ),
                            ],
                          );
                        },
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  checkOutScreens[currentStep],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
