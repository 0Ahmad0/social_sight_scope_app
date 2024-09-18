import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:social_sight_scope/core/widgets/container_with_shadow_widget.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/string_manager.dart';
import '../../core/utils/style_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    this.showAppBar = true,
  });

  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
        title: Text(
          tr(LocaleKeys.navbar_profile_text),
        ),
      )
          : null,
      body: Center(
        child: SingleChildScrollView(
          child: AppPaddingWidget(
            child: Column(
              children: [
                verticalSpace(26.h),
                ContainerWidthShadowWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(10.h),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(Icons.edit_outlined),
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                            color: ColorManager.whiteColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: ColorManager.blackColor.withOpacity(
                                      .04),
                                  offset: Offset(0, 4.sp),
                                  blurRadius: 20.sp)
                            ]),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                          Container(
                          clipBehavior: Clip.hardEdge,
                          width: 120.w,
                          height: 120.h,
                          decoration: BoxDecoration(
                              color: ColorManager.blackColor,
                              shape: BoxShape.circle),
                          child: Image.network(
                              'https://th.bing.com/th/id/OIP.T9JAjD62Bdbaqn5nyyPjwAHaHa?rs=1&pid=ImgDetMain',

                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(30.h),
                Text(
                  tr(LocaleKeys.home_name_text),
                  style: StyleManager.font14Medium(),
                ),
                verticalSpace(10.h),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(text: 'ليلى الحربي'),
                  decoration: InputDecoration(),
                ),
                verticalSpace(30.h),
                Text(
                  tr(LocaleKeys.home_email_text),
                  style: StyleManager.font14Medium(),
                ),
                verticalSpace(10.h),
                TextFormField(
                  readOnly: true,
                  controller:
                  TextEditingController(text: 'laila@gmail.com'),
                  decoration: InputDecoration(),
                ),
              ],
            ),
          ),

          ],
        ),
      ),
    ),)
    ,
    );
  }
}
