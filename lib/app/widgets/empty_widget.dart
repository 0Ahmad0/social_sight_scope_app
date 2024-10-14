import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,  this.text = 'لا يوجد شيء لعرضه',
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   AssetsManager.emptyBoxIcon,
          //   width: 120.sp,
          //   height: 120.sp,
          // ),
          Icon(Icons.wifi_tethering_error,
            size: 80.sp ,
            color: ColorManager.primaryColor,
          ),
           SizedBox(
            height:10.sp,
          ),
          Text(
            '☹️  ' + text + '  ☹️',
            textAlign: TextAlign.center,
            style: StyleManager.font16SemiBold(
              color: ColorManager.primaryColor,
              // size: 16.sp
            ),
          ),
        ],
      ),
    );
  }
}
