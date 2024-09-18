import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_sight_scope/app/widgets/app_drawer_widget.dart';
import 'package:social_sight_scope/core/helpers/launcher_helper.dart';
import 'package:social_sight_scope/core/utils/const_value_manager.dart';
import 'package:social_sight_scope/core/widgets/app_button.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:social_sight_scope/core/widgets/container_with_shadow_widget.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.home_contact_us_text)),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20.h),
              ContainerWidthShadowWidget(
                  horizontalPadding: 0,
                  verticalPadding: 0,
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      dense: true,
                      childrenPadding: EdgeInsets.zero,
                      title: Text(tr(LocaleKeys.home_contact_us_text)),
                      children: [
                        verticalSpace(10.h),
                        AppPaddingWidget(
                          child: TextField(
                            controller: messageController,
                            minLines: 1,
                            maxLines: 8,
                            decoration: InputDecoration(
                              labelText:
                                  tr(LocaleKeys.home_write_your_message_text),
                            ),
                          ),
                        ),
                        AppPaddingWidget(
                            child: AppButton(
                          onPressed: () {
                            if (messageController.value.text
                                .trim()
                                .isNotEmpty) {
                              LauncherHelper.launchEmail(
                                  'SocialSightScope@gmail.com',
                                  text: messageController.value.text);
                              messageController.clear();
                            }
                          },
                          text: tr(LocaleKeys.home_send_message_text),
                        ))
                      ],
                    ),
                  )),
              verticalSpace(30.h),
              ContainerWidthShadowWidget(
                  horizontalPadding: 0,
                  verticalPadding: 0,
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      dense: true,
                      childrenPadding: EdgeInsets.zero,
                      title: Text(tr(LocaleKeys.home_social_media_account)),
                      children: ConstValueManager.socialMediaList
                          .map(
                            (e) => ListTile(
                              leading: SvgPicture.asset(
                                e.icon,
                                width: 34.sp,
                                height: 34.sp,
                                fit: BoxFit.cover,
                              ),
                              title: Text(e.name),
                            ),
                          )
                          .toList(),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
