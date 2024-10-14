import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

import '../../core/utils/string_manager.dart';
import '../controllers/person_controller.dart';
import '../widgets/picture/cach_picture_widget.dart';

class AddNewPersonScreen extends StatefulWidget {
  const AddNewPersonScreen({super.key});

  @override
  State<AddNewPersonScreen> createState() => _AddNewPersonScreenState();
}

class _AddNewPersonScreenState extends State<AddNewPersonScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _image;

  late PersonController controller;
  _pickPhoto(ImageSource source) async {
    final result = await _imagePicker.pickImage(source: source);
    if (result != null) {
      _image = XFile(result.path);
      setState(() {});
      context.pop();
    }
  }
  @override
  void initState() {
    controller = Get.put(PersonController());
    controller.onInit();
    super.initState();
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
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatefulBuilder(builder: (context, personSetState) {
                      return

                        _image != null ||  controller.person?.imagePath!=null
                          ? Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),

                                  child:
                                  _image != null?
                                  Image.file(
                                    File(
                                      _image!.path,
                                    ),
                                    width: getWidth(context),
                                    height: getWidth(context) / 2,
                                    fit: BoxFit.cover,
                                  ):
                                  CachedNetworkImage(
                                    imageUrl:  // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
                                    // 'https://th.bing.com/th/id/OIP.T9JAjD62Bdbaqn5nyyPjwAHaHa?rs=1&pid=ImgDetMain',
                                    '${ controller.person!.imagePath!}',
                                    width: getWidth(context),
                                    height: getWidth(context) / 2,
                                    fit: BoxFit.cover,
                                    errorWidget: (context,_,__)=>
                                        CircleAvatar(
                                          // backgroundColor: ColorManager.errorColor,
                                          child: Icon(
                                            Icons.info_outline,
                                            color: ColorManager.whiteColor,
                                          ),
                                        ),
                                  )
                                  ,
                                ),
                                IconButton(
                                  onPressed: () {
                                    personSetState(() {
                                      _image = null;
                                      controller.person?.imagePath=null;
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
                            ):
                         Container(
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
                                                  _pickPhoto(ImageSource.gallery);
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
                      controller: controller.nameController,
                      decoration: InputDecoration(
                          labelText: tr(LocaleKeys.add_person_name_text)),
                        validator:  (String? val) {
                          if (val!.trim().isEmpty) return StringManager.requiredField;
                          return null;
                        }
                    ),
                    verticalSpace(10.h),
                    TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                          labelText: tr(LocaleKeys.add_person_email_text)),
                        validator:  (String? val) {
                          if (val!.trim().isEmpty) return StringManager.requiredField;
                          return null;
                        }
                    ),
                    verticalSpace(10.h),
                    TextFormField(
                      controller: controller.phoneNumberController,
                      decoration: InputDecoration(
                          labelText: tr(LocaleKeys.add_person_phone_text)),
                        keyboardType:TextInputType.phone,
                        validator:  (String? val) {

                          if (val!.trim().isEmpty) return StringManager.requiredField;
                          else if (!val.isPhoneNumber) {
                            // return 'الرقم المدخل ليس صحيحا';
                            return  tr(LocaleKeys.message_invalid_number);
                          }
                          return null;
                        }
                    ),
                    verticalSpace(30.h),
                    Text(tr(LocaleKeys.add_person_other_data_text)),
                    verticalSpace(10.h),
                    AppTextField(
                      controller: controller.descriptionController,
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
              controller.person == null
                  ? AppButton(
                  onPressed: () {
                    if(controller.formKey.currentState!.validate())
                    controller.addPerson(context,
                        image: _image,withUserId: true);
                  },
                  text: tr(LocaleKeys.add_person_add_person_text))
                  : AppButton(
                  onPressed: () {
                    if(controller.formKey.currentState!.validate())
                    controller.updatePerson(context,
                        image: _image);
                  },
                  text: tr(LocaleKeys.update))
              // AppButton(
              //   onPressed: () {},
              //   text: tr(LocaleKeys.add_person_add_person_text),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
