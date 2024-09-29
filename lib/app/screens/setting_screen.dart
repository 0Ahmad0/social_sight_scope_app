import 'package:country_flags/country_flags.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_sight_scope/core/dialogs/general_bottom_sheet.dart';
import 'package:social_sight_scope/core/dialogs/type/delete_account_dialog.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/routing/routes.dart';
import 'package:social_sight_scope/core/utils/const_value_manager.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:social_sight_scope/core/widgets/container_with_shadow_widget.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr(LocaleKeys.home_setting_text),
        ),
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerWidthShadowWidget(
                horizontalPadding: 0,
                verticalPadding: 8,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    dense: true,
                    title: Text(
                      tr(LocaleKeys.app_language_text),
                    ),
                    children: ConstValueManager.languageList
                        .map((e) => ListTile(
                              onTap: () {
                                context.setLocale(Locale(e.languageCode));
                              },
                              dense: true,
                              leading: SvgPicture.asset(e.icon),
                              title: Text(e.text),
                            ))
                        .toList(),
                  ),
                ),
              ),
              verticalSpace(20.h),
              ContainerWidthShadowWidget(
                horizontalPadding: 0,
                verticalPadding: 8,
                child: ListTile(
                  onTap: () {
                    showCustomBottomSheet(context,
                        child: DeleteAccountDialog());
                  },
                  dense: true,
                  trailing: Icon(
                    Icons.delete_outline,
                    color: ColorManager.errorColor,
                  ),
                  title: Text(
                    tr(LocaleKeys.home_delete_account_text),
                    style: StyleManager.font14Medium(
                        color: ColorManager.errorColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
