import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:social_sight_scope/app/widgets/picture/cach_picture_widget.dart';
import 'package:social_sight_scope/app/widgets/picture/profile_picture_widget.dart';
import 'package:social_sight_scope/core/dialogs/general_bottom_sheet.dart';
import 'package:social_sight_scope/core/dialogs/type/logout_dialog.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/helpers/sizer.dart';
import 'package:social_sight_scope/core/routing/routes.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../controllers/person_controller.dart';
import '../controllers/profile_controller.dart';
import 'drawer_item_widget.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(PersonController()).person=null;
    return Drawer(
      width: getWidth(context) - 40.w,
      child: Column(
        children: [
      GetBuilder<ProfileController>(
      init: Get.put(ProfileController()),
    builder: (controller) =>
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: ColorManager.primaryColor,
            ),
            accountName: Padding(
              padding: EdgeInsetsDirectional.only(top: 30.h, end: 20.w),
              child: Text.rich(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                TextSpan(
                  children: [
                    TextSpan(
                        text: '${tr(LocaleKeys.home_welcome_text)}',
                        style: StyleManager.font20SemiBold(
                            color: ColorManager.whiteColor)),
                    TextSpan(
                      text:(controller.currentUser.value?.name??  ''),

                      style: StyleManager.font14Regular().copyWith(),
                    ),
                  ],
                ),
              ),
            ),
            accountEmail: Text(
             (controller.currentUser.value?.email??  ''),
              // 'laila@gmail.com',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: StyleManager.font16Regular(),
            ),
            currentAccountPicture:   CacheNetworkImage(
                photoUrl:  // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
    // 'https://th.bing.com/th/id/OIP.T9JAjD62Bdbaqn5nyyPjwAHaHa?rs=1&pid=ImgDetMain',
                '${ controller.currentUser.value?.photoUrl??''}',
                // width: radius.sp,
                // height: radius.sp,
                // boxFit: BoxFit.cover,
                waitWidget: WidgetProfilePicture(
                  name: controller.currentUser.value?.name??'',
                  // radius: radius.sp,

                  backgroundColor: ColorManager.whiteColor,
                  textColor: ColorManager.primaryColor,
                ),
                errorWidget: WidgetProfilePicture(
                  name: controller.currentUser.value?.name??'',
                  // radius: radius.sp,


                  backgroundColor: ColorManager.whiteColor,
                  textColor: ColorManager.primaryColor,
                ),
              ),
            // currentAccountPicture: CircleAvatar(
            //   backgroundImage:

              // NetworkImage(
              //     (controller.currentUser.value?.photoUrl??  ''),
              //     // 'https://th.bing.com/th/id/OIP.T9JAjD62Bdbaqn5nyyPjwAHaHa?rs=1&pid=ImgDetMain'
              // ),
            // ),
            otherAccountsPictures: [
              IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.close,
                  color: ColorManager.whiteColor,
                ),
              )
            ],
          )),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [



                  DrawerItemWidget(
                    text: tr(LocaleKeys.home_logout_text),
                    icon: Icons.logout,
                    onTap: () {
                      showCustomBottomSheet(context, child: LogoutDialog());
                    },
                    isColored: true,
                  ),
            
                  DrawerItemWidget(
                    text: tr(LocaleKeys.home_recognize_face_text),
                    icon: Icons.face,
                    route: Routes.addNewPersonRoute,
                  ),
                  DrawerItemWidget(
                    text: tr(LocaleKeys.home_translate_language_text),
                    icon: Icons.translate,
                    route: Routes.translationRoute,
                  ),
                  DrawerItemWidget(
                    text: tr(LocaleKeys.home_display_real_time_text),
                    icon: Icons.chat_outlined,
                    route: Routes.geminiChatRoute,
                  ),
                  DrawerItemWidget(
                    text: tr(LocaleKeys.home_analyze_emotion_text),
                    icon: Icons.emoji_emotions_outlined,
                    route: Routes.faceDetectionModeRoute,
                  ),
                  DrawerItemWidget(
                    text: tr(LocaleKeys.home_setting_text),
                    icon: Icons.settings_outlined,
                    route: Routes.settingRoute,
                  ),
                  DrawerItemWidget(
                    text: tr(LocaleKeys.home_contact_us_text),
                    icon: Icons.info_outline,
                    route: Routes.contactUsRoute,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
