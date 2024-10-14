import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/helpers/spacing.dart';
import 'package:social_sight_scope/core/routing/routes.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';
import 'package:social_sight_scope/core/widgets/app_button.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:social_sight_scope/core/widgets/app_textfield.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../../core/widgets/container_with_shadow_widget.dart';
import '../controllers/auth_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late AuthController authController;
  @override
  void initState() {
    authController= Get.put(AuthController());
    authController.init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: AppPaddingWidget(
          child: Form(
            key: authController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(80.h),
                Text(
                  tr(LocaleKeys.signup_create_new_account),
                  style: StyleManager.font40Bold(color: ColorManager.whiteColor),
                ),
                verticalSpace(20.h),
                ContainerWidthShadowWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          tr(LocaleKeys.signup_create_account),
                          textAlign: TextAlign.center,
                          style: StyleManager.font20Bold(
                              color: ColorManager.primaryColor),
                        ),
                      ),
                      verticalSpace(30.h),
                      Text(
                        tr(LocaleKeys.signup_name_text),
                      ),
                      verticalSpace(10.h),
                      AppTextField(
                        controller:  authController.nameController,
                        validator: (value)=>authController.validateFullName(value??''),
                        hintText: tr(LocaleKeys.signup_enter_name_text),

                      ),
                      verticalSpace(20.h),
                      Text(
                        tr(LocaleKeys.signup_email_text),
                      ),
                      verticalSpace(10.h),
                      AppTextField(
                        controller:  authController.emailController,
                        validator: (value)=>authController.validateEmail(value??''),
                        hintText: tr(LocaleKeys.signup_enter_email_text),
                      ),
                      verticalSpace(20.h),
                      Text(
                        tr(LocaleKeys.signup_password_text),
                      ),
                      verticalSpace(10.h),
                      AppTextField(
                        obscureText: true,
                        suffixIcon: true,
                        controller:  authController.passwordController,
                        validator: (value)=>authController.validatePassword(value??''),
                        hintText: tr(LocaleKeys.signup_enter_password_text),
                      ),
                      verticalSpace(20.h),
                      Text(
                        tr(LocaleKeys.signup_confirm_password_text),
                      ),
                      verticalSpace(10.h),
                      AppTextField(
                        obscureText: true,
                        suffixIcon: true,
                        controller: authController.confirmPasswordController,
                        validator: (value) =>
                            authController.validateConfirmPassword(value ?? '', authController.passwordController.value.text),

                        hintText: tr(LocaleKeys.signup_enter_confirm_password_text),
                      ),
                      verticalSpace(30.h),
                      AppButton(
                        onPressed: () {
                          if (authController.formKey.currentState!.validate()) {
                            authController.signUp(context);
                          }
                        },
                        text: tr(LocaleKeys.signup_create_account),
                      ),
                      verticalSpace(20.h),
                      Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            TextSpan(
                                text: tr(
                                    LocaleKeys.signup_have_already_account_text)),
                            TextSpan(
                                text: tr(LocaleKeys.signup_login_text),
                                style: StyleManager.font16SemiBold(
                                    color: ColorManager.primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.pushReplacement(Routes.loginRoute);
                                  }),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
