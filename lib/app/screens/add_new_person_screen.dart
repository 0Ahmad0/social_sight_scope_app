import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_sight_scope/core/dialogs/general_bottom_sheet.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/helpers/sizer.dart';
import 'package:social_sight_scope/core/helpers/spacing.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';
import 'package:social_sight_scope/core/widgets/app_button.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:social_sight_scope/core/widgets/app_textfield.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

class AddNewPersonScreen extends StatefulWidget {
  const AddNewPersonScreen({super.key});

  @override
  State<AddNewPersonScreen> createState() => _AddNewPersonScreenState();
}

class _AddNewPersonScreenState extends State<AddNewPersonScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _image;

  _pickPhoto(ImageSource source) async {
    final result = await _imagePicker.pickImage(source: source);
    if (result != null) {
      _image = XFile(result.path);
      setState(() {});
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr(LocaleKeys.add_person_add_person_text),
        ),
      ),
      body: AppPaddingWidget(
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatefulBuilder(builder: (context, personSetState) {
                    return _image != null
                        ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.file(
                                  File(
                                    _image!.path,
                                  ),
                                  width: getWidth(context),
                                  height: getWidth(context) / 2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  personSetState(() {
                                    _image = null;
                                  });
                                },
                                icon: CircleAvatar(
                                  backgroundColor: ColorManager.errorColor,
                                  child: Icon(
                                    Icons.delete_forever_outlined,
                                    color: ColorManager.whiteColor,
                                  ),
                                ),
                              )
                            ],
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 10.h),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: ColorManager.primaryColor,
                                width: .5,
                              ),
                            ),
                            child: TextButton.icon(
                              onPressed: () {
                                showCustomBottomSheet(context,
                                    isDismissible: true,
                                    child: AppPaddingWidget(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: TextButton.icon(
                                              onPressed: () {
                                                personSetState(() {
                                                  _pickPhoto(
                                                      ImageSource.camera);
                                                });
                                              },
                                              label: Text(
                                                tr(LocaleKeys
                                                    .home_pick_from_camera_text),
                                                style: StyleManager
                                                    .font14Regular(),
                                              ),
                                              icon: Icon(
                                                Icons.camera_alt_outlined,
                                                  color: ColorManager.primaryColor
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                            child: TextButton.icon(
                                              onPressed: () {
                                                _pickPhoto(ImageSource.camera);
                                              },
                                              label: Text(
                                                tr(LocaleKeys
                                                    .home_pick_from_gallery_text),
                                                style: StyleManager
                                                    .font14Regular(),
                                              ),
                                              icon: Icon(
                                                Icons.photo_camera_back,
                                                color:
                                                    ColorManager.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                              icon: Icon(
                                Icons.photo_camera_back_outlined,
                                color: ColorManager.primaryColor,
                              ),
                              label: Text(
                                tr(
                                  LocaleKeys.add_person_pick_photo_text,
                                ),
                                style: StyleManager.font16Regular().copyWith(
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorManager.primaryColor),
                              ),
                            ),
                          );
                  }),
                  verticalSpace(20.h),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: tr(LocaleKeys.add_person_name_text)),
                  ),
                  verticalSpace(10.h),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: tr(LocaleKeys.add_person_email_text)),
                  ),
                  verticalSpace(10.h),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: tr(LocaleKeys.add_person_phone_text)),
                  ),
                  verticalSpace(30.h),
                  Text(tr(LocaleKeys.add_person_other_data_text)),
                  verticalSpace(10.h),
                  AppTextField(
                    maxLine: 8,
                    minLine: 1,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    hintText: tr(LocaleKeys.add_person_please_type_line_text),
                  ),
                ],
              ),
            )),
            verticalSpace(10.h),
            AppButton(
              onPressed: () {},
              text: tr(LocaleKeys.add_person_add_person_text),
            )
          ],
        ),
      ),
    );
  }
}
