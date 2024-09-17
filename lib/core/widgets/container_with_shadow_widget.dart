import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/color_manager.dart';

class ContainerWidthShadowWidget extends StatelessWidget {
  const ContainerWidthShadowWidget({
    super.key,
    required this.child,
    this.horizontalPadding = 20.0,
     this.verticalPadding = 12.0,
  });

  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding.w, vertical: verticalPadding.h),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: ColorManager.blackColor.withOpacity(.1),
              offset: Offset(0, 4.sp),
              blurRadius: 8.sp,
            )
          ]),
      child: child,
    );
  }
}
