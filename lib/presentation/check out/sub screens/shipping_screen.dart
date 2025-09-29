import 'package:depi_graduation/presentation/check%20out/widgets/method_tile.dart';
import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:depi_graduation/presentation/resources/font_manager.dart';
import 'package:depi_graduation/presentation/resources/styles_manager.dart';
import 'package:depi_graduation/presentation/resources/value_manager.dart';
import 'package:depi_graduation/presentation/widgets/app_text_button.dart';
import 'package:depi_graduation/presentation/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key, required this.goNext});

  final void Function() goNext;
  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final countryController = TextEditingController();
  final streetNameController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String selectedCountry = "USA"; // default
  int selectedMethodIndex = -1; // -1 means no method selected

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    countryController.dispose();
    streetNameController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step 1',
              style: theme.textTheme.bodyLarge!.copyWith(color: Colors.grey),
            ),
            Text(
              'Shipping',
              style: theme.textTheme.titleLarge!.copyWith(
                color: theme.colorScheme.primary,
                fontSize: FontSize.s26,
              ),
            ),
            SizedBox(height: 15.h),
            // First Name
            AppTextField(
              hintText: 'First Name',
              controller: firstNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'First name is required';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
        
            // Last Name
            AppTextField(
              hintText: 'Last Name',
              controller: lastNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Last name is required';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
        
            // Country (Dropdown)
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                hintText: "Country",
                hintStyle: regularStyle(
                  fontSize: AppSize.s16, // ✅ from ValuesManager
                  color: theme.primaryColor,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.lightGrayDark,
                    width: AppSize.s1, // ✅ from ValuesManager
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: AppPadding.p10, // ✅ from ValuesManager
                  horizontal: AppPadding.p8,
                ),
              ),
              items: ["USA", "Canada", "UK", "Germany"]
                  .map((country) => DropdownMenuItem(
                        value: country,
                        child: Text(country),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCountry = value!;
                  countryController.text = value;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select a country";
                }
                return null;
              },
            ),
        
            SizedBox(height: 12),
        
            // Street Name
            AppTextField(
              hintText: 'Street Name',
              controller: streetNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Street name is required';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
        
            // City
            AppTextField(
              hintText: 'City',
              controller: cityController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'City is required';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
        
            // State
            AppTextField(
              hintText: 'State',
              controller: stateController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'State is required';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
        
            // Zip Code
            AppTextField(
              hintText: 'Zip Code',
              controller: zipCodeController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Zip code is required';
                }
                if (!RegExp(r'^\d{5}$').hasMatch(value)) {
                  return 'Enter a valid 5-digit ZIP code';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
        
            // Phone Number
            AppTextField(
              hintText: 'Phone Number',
              controller: phoneNumberController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Phone number is required';
                }
                if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                  return 'Enter a valid phone number';
                }
                return null;
              },
            ),
            //--------------------------End FORM------------------------------------------------
        
            SizedBox(
              height: 40.h,
            ),
            Text(
              'Shipping Method',
              style: theme.textTheme.bodyLarge,
            ),
            Divider(
              thickness: 0.5,
            ),
            Padding(
                padding: EdgeInsets.all(10.w),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (context, index) => Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      Divider(
                        thickness: 0.5,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                    ],
                  ),
                  itemBuilder: (context, index) => MethodTile(
                    deliveryMethod: methods[index]['deliveryMethod'],
                    deliveryPeriod: methods[index]['deliveryPeriod'],
                    price: methods[index]['price'],
                    isSelected: selectedMethodIndex == index,
                    onTap: () {
                      setState(() {
                        selectedMethodIndex = index;
                      });
                    },
                  ),
                )),
            //--------------------------------End Methods-------------------------------------------
        
            SizedBox(
              height: 40.h,
            ),
            Text(
              'Coupon Code',
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(
              height: 10.h,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Have a code? Type it here.....',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.2)),
            ),
            //-------------------------------End Coupon Field--------------------------------------------------------
            SizedBox(
              height: 40.h,
            ),
        
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

  final List<Map<String, dynamic>> methods = [
    {
      'deliveryMethod': 'Delivery to home',
      'deliveryPeriod': 'Delivery from 3 to 7 business days',
      'price': 55.0,
    },
    {
      'deliveryMethod': 'Delivery to home',
      'deliveryPeriod': 'Delivery from 4 to 6 business days',
      'price': 70.0,
    },
    {
      'deliveryMethod': 'Fast Delivery',
      'deliveryPeriod': 'Delivery from 2 to 3 business days',
      'price': 100.0,
    },
  ];
}
