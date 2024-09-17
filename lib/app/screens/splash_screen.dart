import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/helpers/spacing.dart';
import 'package:social_sight_scope/core/routing/routes.dart';
import 'package:social_sight_scope/core/utils/assets_manager.dart';
import 'package:animate_do/animate_do.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/const_value_manager.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';
import 'package:social_sight_scope/core/widgets/app_button.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          FlipInX(
            child: Image.asset(
              AssetsManager.logoIMG,
            ),
          ),
          FadeInUp(
            child: AppPaddingWidget(
              child: Text(
                tr(LocaleKeys.intro_text),
                textAlign: TextAlign.center,
                style: StyleManager.font18Medium().copyWith(height: 1.75),
              ),
            ),
          ),
          verticalSpace(10.h),
          FadeInUp(
            child: Text(
              tr(LocaleKeys.app_language_text),
              textAlign: TextAlign.center,
              style: StyleManager.font18Medium(),
            ),
          ),
          verticalSpace(10.h),
          FadeInUp(
            child: Align(
              alignment: Alignment.center,
              child: DropdownButton(
                underline: SizedBox.shrink(),
                value: context.locale.languageCode ==
                        ConstValueManager.enLanguageCode
                    ? ConstValueManager.languageList.last.text
                    : ConstValueManager.languageList.first.text,
                isDense: true,
                icon: Icon(Icons.keyboard_arrow_down),
                items: ConstValueManager.languageList
                    .map((e) => DropdownMenuItem(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e.text),
                              SvgPicture.asset(e.icon)
                            ],
                          ),
                          value: e.text,
                          onTap: () {
                            context.setLocale(Locale(e.languageCode));
                          },
                        ))
                    .toList(),
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
          ),
          const Spacer(),
          FadeInUp(
            child: AppPaddingWidget(
              child: AppButton(
                onPressed: () {
                  context.pushReplacement(Routes.loginRoute);
                },
                text: tr(LocaleKeys.get_started_text),
              ),
            ),
          )
        ],
      ),
    );
  }
}
