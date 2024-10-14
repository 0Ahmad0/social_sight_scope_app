import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_sight_scope/core/utils/assets_manager.dart';

import '../../core/helpers/sizer.dart';
import '../../core/helpers/spacing.dart';
import '../../core/utils/color_manager.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_padding.dart';
import '../../core/widgets/app_textfield.dart';
import '../../translations/locale_keys.g.dart';

class ShowPersonDetailsScreen extends StatelessWidget {
  const ShowPersonDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppPaddingWidget(
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      AssetsManager.logoIMG,
                      width: getWidth(context),
                      height: getWidth(context) / 2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  verticalSpace(20.h),
                  TextFormField(
                    controller: TextEditingController(text: 'ليلى'),
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: tr(LocaleKeys.add_person_name_text)),
                  ),
                  verticalSpace(10.h),
                  TextFormField(
                    controller:
                        TextEditingController(text: 'laila2000@gmail.com'),
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: tr(LocaleKeys.add_person_email_text)),
                  ),
                  verticalSpace(10.h),
                  TextFormField(
                    controller: TextEditingController(text: '05123456789'),
                    readOnly: true,
                    decoration: InputDecoration(
                        labelText: tr(LocaleKeys.add_person_phone_text)),
                  ),
                  verticalSpace(30.h),
                  Text(tr(LocaleKeys.add_person_other_data_text)),
                  verticalSpace(10.h),
                  AppTextField(
                    controller: TextEditingController(
                      text: 'hello my name is laila\n'
                          'hello my name is laila\n'
                          'hello my name is laila\n'
                          'hello my name is laila\n'
                          'hello my name is laila\n'
                          'hello my name is laila\n'
                          'hello my name is laila\n'
                          'hello my name is laila\n'
                          'hello my name is laila\n'
                          'hello my name is laila\n'
                          'hello my name is laila\n'
                          'hello my name is laila\n'
                          'hello my name is laila\n'
                          'hello my name is laila\n',
                    ),
                    readOnly: true,
                    maxLine: 8,
                    minLine: 1,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    hintText: tr(LocaleKeys.add_person_please_type_line_text),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
