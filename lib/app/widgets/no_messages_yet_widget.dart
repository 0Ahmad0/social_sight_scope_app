import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/sizer.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';

class NoMessagesYetWidget extends StatelessWidget {
  const NoMessagesYetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Divider(),
            Container(
              constraints: BoxConstraints(
                maxWidth: getWidth(context) / 2,
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 10.w, vertical: 6.h),
              alignment: Alignment.center,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: ColorManager.primaryColor,
                  borderRadius: BorderRadius.circular(4.r)),
              child: Text(
                'لا يوجد رسائل بعد☹️',
                style: StyleManager.font12Regular(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
