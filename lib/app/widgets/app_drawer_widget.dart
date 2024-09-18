import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/helpers/sizer.dart';
import 'package:social_sight_scope/core/routing/routes.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import 'drawer_item_widget.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: getWidth(context) - 40.w,
      child: Column(
        children: [
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
                      text: 'ليلى',
                      style: StyleManager.font14Regular().copyWith(),
                    ),
                  ],
                ),
              ),
            ),
            accountEmail: Text(
              'laila@gmail.com',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: StyleManager.font16Regular(),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://th.bing.com/th/id/OIP.T9JAjD62Bdbaqn5nyyPjwAHaHa?rs=1&pid=ImgDetMain'),
            ),
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
          ),
          DrawerItemWidget(
            text: tr(LocaleKeys.home_logout_text),
            icon: Icons.logout,
            onTap: () {},
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
    );
  }
}
