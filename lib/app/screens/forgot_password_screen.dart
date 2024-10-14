import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/widgets/container_with_shadow_widget.dart';

import '../../translations/locale_keys.g.dart';
import '../controllers/auth_controller.dart';
import '../controllers/forget_password_controller.dart';
import '../widgets/email_recovery_success_widget.dart';
import '/core/helpers/extensions.dart';
import '/core/routing/routes.dart';
import '/core/widgets/app_button.dart';
import '/core/widgets/app_padding.dart';
import '/core/widgets/app_textfield.dart';
import '/core/widgets/custome_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helpers/spacing.dart';
import '../../core/utils/string_manager.dart';
import '../../core/utils/style_manager.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late ForgetPasswordController controller;
  @override
  void initState() {
     controller = Get.put(ForgetPasswordController());
     controller.emailController.clear();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorManager.scaffoldBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child:  Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr(LocaleKeys.forgot_password_forgot_new_password_text),
                  style: StyleManager.font40Bold(color: ColorManager.whiteColor),
                ),
                verticalSpace(10.h),
                ContainerWidthShadowWidget(
                  verticalPadding: 20.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          tr(LocaleKeys.forgot_password_forgot_password_text),
                          textAlign: TextAlign.center,
                          style: StyleManager.font20Bold(
                              color: ColorManager.primaryColor),
                        ),
                      ),
                      verticalSpace(10.h),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          tr(LocaleKeys.forgot_password_enter_email_text),
                          textAlign: TextAlign.center,
                          style: StyleManager.font16Regular(),
                        ),
                      ),
                      verticalSpace(10.h),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          tr(LocaleKeys
                              .forgot_password_we_will_send_email_to_rest_password_text),
                          textAlign: TextAlign.center,
                          style: StyleManager.font14Regular(
                              color: ColorManager.hintTextColor),
                        ),
                      ),
                      verticalSpace(40.h),
                      AppTextField(
                        hintText:
                            tr(LocaleKeys.forgot_password_enter_email_hint_text),
                        controller: controller.emailController,
                        validator:(value)=> AuthController.instance.validateEmail(value!),
                        iconData: Icons.email,
                      ),
                      verticalSpace(40.h),
                      AppButton(
                        onPressed: () async {
                          if (controller.formKey.currentState!.validate()) {

                            bool? isSend= await controller.send();
                            // if(isSend??false)
                            //   showModalBottomSheet(
                            //
                            //       clipBehavior: Clip.hardEdge,
                            //       context: context,
                            //       builder: (_) =>
                            //           EmailRecoverySuccessBottomSheetWidget());
                          }
                          // context.pushReplacement(
                          //   Routes.checkYourInboxRoute,
                          // );
                        },
                        text: tr(LocaleKeys.forgot_password_send_text),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
