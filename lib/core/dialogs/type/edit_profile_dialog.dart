
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:social_sight_scope/core/widgets/app_textfield.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../../../app/controllers/profile_controller.dart';
import '../../../app/widgets/picture/circle_profile_widget.dart';
import '../../helpers/spacing.dart';
import '../../utils/assets_manager.dart';
import '../../utils/color_manager.dart';
import '../../utils/string_manager.dart';
import '../../utils/style_manager.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_cancel_button.dart';
import 'picker_dialog.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({super.key});

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {

  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController ;
  late TextEditingController firstNameController ;
  late TextEditingController lastNameController ;
  late ProfileController profileController;
  @override
  void initState() {
    emailController=TextEditingController(text: '096655555555' );
    firstNameController=TextEditingController(text:'ليلى' );
    lastNameController=TextEditingController(text:'الحربي' );
     profileController = Get.put(ProfileController());
    profileController.refresh();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AppPaddingWidget(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                trailing: GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.close,
                  ),
                ),
              ),
              verticalSpace(30.h),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                    color: ColorManager.whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: ColorManager.blackColor.withOpacity(.04),
                          offset: Offset(0, 4.sp),
                          blurRadius: 20.sp)
                    ]),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                  GetBuilder<ProfileController>(
                  init: profileController,
                  // init: profileController,
                  builder: (controller) =>
                      CircleProfilePictureWidget(
                        path: controller.profileImage?.path,

                        radius:120.sp ,
                      )
                  ),
                    // Container(
                    //   clipBehavior: Clip.hardEdge,
                    //   width: 120.w,
                    //   height: 120.h,
                    //   decoration: BoxDecoration(
                    //       color: ColorManager.primaryColor,
                    //       shape: BoxShape.circle),
                    //   child:
                    //
                    //   Image.asset(
                    //     'assets/images/logo.png',
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    PositionedDirectional(
                      bottom: 0,
                      end: (MediaQuery.sizeOf(context).width) / 2,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: ColorManager.whiteColor,
                            isScrollControlled: true,
                            enableDrag: true,
                            context: context,
                            isDismissible: false,
                            builder: (context) => PickerDialog(
                              deletePicker:
                              profileController.profileImage==null?null:
                                  () async {
                                profileController.deletePhoto();
                                setState(() {});

                                // onChange?.call();

                              },
                              galleryPicker: () async {
                                await profileController.pickPhoto(ImageSource.gallery);
                                // print('result ${profileController.profileImage}');
                                setState(() {

                                });
                                // onChange?.call();

                              },
                              cameraPicker: () async {
                                await profileController.pickPhoto(ImageSource.camera);
                                setState(() {

                                });
                              },
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: ColorManager.hintTextColor,
                          child: Icon(Icons.add_a_photo_outlined,color: ColorManager.whiteColor,),
                        ),
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
              AppTextField(
                // controller:firstNameController,
                controller:profileController.nameController,
                hintText: tr(LocaleKeys.login_enter_email_text),
                validator:  (String? val) {
                  if (val!.trim().isEmpty) return StringManager.requiredField;
                  return null;
                },
              ),
              verticalSpace(30.h),
              Text(
                tr(LocaleKeys.home_email_text),
                style: StyleManager.font14Medium(),
              ),
              verticalSpace(10.h),
              AppTextField(
                controller:profileController.emailController,
                // controller:emailController ,
                hintText: tr(LocaleKeys.login_enter_email_text),
                validator: (String? val) {
                  if (val!.trim().isEmpty) return StringManager.requiredField;
                  return null;
                },
              ),
              verticalSpace(40.h),
              Row(
                children: [
                  Flexible(
                      child: AppButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            profileController.updateUser();
                          }
                        },
                        text: tr(LocaleKeys.save_text),
                      )),
                  horizontalSpace(12.w),
                  Flexible(
                    child: AppCancelButton(
                      onPressed: () {

                         context.pop();
                      },
                      text: tr(LocaleKeys.cancel),
                    ),
                  ),
                ],
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}
