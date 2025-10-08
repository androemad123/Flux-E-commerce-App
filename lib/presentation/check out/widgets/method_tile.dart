import 'package:depi_graduation/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MethodTile extends StatelessWidget {
   MethodTile(
      {super.key,
      required this.deliveryMethod,
      required this.deliveryPeriod,
      required this.price,
      required this.isSelected,
      required this.onTap});
  final String deliveryMethod;
  final String deliveryPeriod;
  final double price;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color:
                    isSelected ? ColorManager.greenLight : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 1.5)),
            child: Center(
              child: CircleAvatar(
                radius: 5,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '\$ $price',
                    style: theme.textTheme.bodyLarge,
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    deliveryMethod,
                    style: theme.textTheme.bodyLarge!
                        .copyWith(color: ColorManager.darkGrayLight),
                  )
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(deliveryPeriod)
            ],
          )
        ],
      ),
    );
  }
}
