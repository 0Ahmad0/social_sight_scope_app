import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/helpers/spacing.dart';
import 'package:social_sight_scope/core/models/person_model.dart';
import 'package:social_sight_scope/core/models/user_model.dart';
import 'package:social_sight_scope/core/routing/routes.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';
import 'package:social_sight_scope/core/widgets/app_button.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:social_sight_scope/core/widgets/app_textfield.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../../core/utils/app_constant.dart';
import '../../core/widgets/constants_widgets.dart';
import '../../core/widgets/container_with_shadow_widget.dart';
import '../controllers/auth_controller.dart';
import '../controllers/firebase/firebase_constants.dart';
import '../controllers/firebase/firebase_fun.dart';
import '../controllers/person_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
          child:  Form(
            key: authController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(80.h),
                Text(
                  tr(LocaleKeys.login_welcome_back_text),
                  style: StyleManager.font40Bold(color: ColorManager.whiteColor),
                ),
                verticalSpace(20.h),
                ContainerWidthShadowWidget(
                  verticalPadding: 20.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          tr(LocaleKeys.login_login_text),
                          textAlign: TextAlign.center,
                          style: StyleManager.font20Bold(
                              color: ColorManager.primaryColor),
                        ),
                      ),
                      verticalSpace(30.h),
                      Text(
                        tr(LocaleKeys.login_email_text),
                      ),
                      verticalSpace(10.h),
                      AppTextField(
                        controller:  authController.emailController,
                        validator: (value)=>authController.validateEmail(value??''),
                        hintText: tr(LocaleKeys.login_enter_email_text),
                      ),
                      verticalSpace(20.h),
                      Text(
                        tr(LocaleKeys.login_password_text),
                      ),
                      verticalSpace(10.h),
                      AppTextField(
                        obscureText: true,
                        suffixIcon: true,
                        hintText: tr(LocaleKeys.login_enter_password_text),
                        controller: authController.passwordController,
                        validator: (value)=>authController.validatePassword(value??''),
                      ),
                      verticalSpace(10.h),
                      TextButton(
                          onPressed: () {
                            context.pushNamed(Routes.forgotPasswordRoute);
                          },
                          child: Text(tr(LocaleKeys.login_forgot_password_text))),
                      verticalSpace(30.h),
                      AppButton(
                        onPressed: () {

                          // context.pushReplacement(Routes.navbarRoute);
                          if (authController.formKey.currentState!.validate()) {
                            authController.login(context);
                          }
                        },
                        text: tr(LocaleKeys.login_login_text),
                      ),
                      verticalSpace(20.h),
                      Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(children: [
                            TextSpan(
                                text: tr(
                                    LocaleKeys.login_do_not_have_account_text)),
                            TextSpan(
                                text: tr(LocaleKeys.login_signup_text),
                                style: StyleManager.font16SemiBold(
                                    color: ColorManager.primaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    context.pushReplacement(Routes.signUpRoute);

                                    List<String> listImages=[
                                      "https://firebasestorage.googleapis.com/v0/b/social-sight-scope.appspot.com/o/images%2F300181343_528527872362089_5620504120524295269_n.jpg?alt=media&token=0134c892-6129-490a-af6c-e465f7e967e7",
                                      "https://firebasestorage.googleapis.com/v0/b/social-sight-scope.appspot.com/o/images%2Fphoto_2023-02-24_02-36-38.jpg?alt=media&token=7888bb67-4eea-4e0f-ba8d-98d5448bd354",
                                      "https://firebasestorage.googleapis.com/v0/b/social-sight-scope.appspot.com/o/images%2F11-BYBB-S-DARK-Techwear-Cotton-Jacket-Coat-Splicing-Sticker-Zipper-Hooded-Jackets-Men-Harajuku-Autumn.jpg_Q90.jpg_.webp?alt=media&token=ceb2188b-338a-4e44-9846-787cce4688c0",
                                      "https://firebasestorage.googleapis.com/v0/b/social-sight-scope.appspot.com/o/images%2Fartbreeder-mixer-2024-02-19T15_04_32.131Z.jpeg?alt=media&token=86f89b77-3f87-4127-ba0a-84b29d4ab4db",
                                      "https://firebasestorage.googleapis.com/v0/b/social-sight-scope.appspot.com/o/images%2Fphoto_2023-02-28_01-21-59.jpg?alt=media&token=2cb144d3-c820-4705-a051-c6062c0607bb",
                                      "https://firebasestorage.googleapis.com/v0/b/social-sight-scope.appspot.com/o/images%2Fartbreeder-mixer-2024-02-19T15_04_18.240Z.jpeg?alt=media&token=8e51f40b-9d0f-48cc-b8d0-0412e56fb93d",
                                      "https://firebasestorage.googleapis.com/v0/b/social-sight-scope.appspot.com/o/images%2Fphoto_2024-10-14_12-20-38.jpg?alt=media&token=20673af6-67cd-4363-a07c-b95cb1ee1686",
                                      "https://firebasestorage.googleapis.com/v0/b/social-sight-scope.appspot.com/o/images%2Fwp4272908.webp?alt=media&token=1536b848-23ad-4534-a8dd-0059e983bcc0",
                                      "https://firebasestorage.googleapis.com/v0/b/social-sight-scope.appspot.com/o/images%2F300181343_528527872362089_5620504120524295269_n.jpg?alt=media&token=0134c892-6129-490a-af6c-e465f7e967e7",
                                    ];
                                    List<UserModel> list=[
                                      UserModel(name: "مستخدم تجريبي",email:"user@gmail.com" ,password: "12345678",photoUrl:"https://firebasestorage.googleapis.com/v0/b/social-sight-scope.appspot.com/o/images%2F300181343_528527872362089_5620504120524295269_n.jpg?alt=media&token=0134c892-6129-490a-af6c-e465f7e967e7" ),
                                      UserModel(name: "مستخدم تجريبي1",email:"user1@gmail.com" ,password: "12345678",photoUrl: listImages[1]),
                                      UserModel(name: "مستخدم تجريب2",email:"user2@gmail.com" ,password: "12345678",photoUrl:listImages[2] ),
                                      UserModel(name: "مستخدم تجريبي3",email:"user3@gmail.com" ,password: "12345678",photoUrl:listImages[3] ),
                                      UserModel(name: "مستخدم تجريبي4",email:"user4@gmail.com" ,password: "12345678",photoUrl: listImages[4]),
                                      UserModel(name: "مستخدم تجريبي5",email:"user5@gmail.com" ,password: "12345678",photoUrl: listImages[5]),
                                      UserModel(name: "مستخدم تجريبي6",email:"user6@gmail.com" ,password: "12345678",photoUrl: listImages[6]),
                                      UserModel(name: "مستخدم تجريبي7",email:"user7@gmail.com" ,password: "12345678",photoUrl: listImages[7]),
                                      UserModel(name: "مستخدم تجريبي8",email:"user8@gmail.com" ,password: "12345678",photoUrl: listImages[8]),
                                      UserModel(name: "مستخدم تجريبي9",email:"user9@gmail.com" ,password: "12345678",photoUrl: listImages[Random.secure().nextInt(listImages.length-1)]),
                                      UserModel(name: "مستخدم تجريبي10",email:"user10@gmail.com" ,password: "12345678",photoUrl:listImages[Random.secure().nextInt(listImages.length-1)] ),
                                    ];
                                    // ConstantsWidgets.showLoading();
                                    // for(UserModel element in list){
                                    //   try{
                                    //
                                    //     UserCredential userCredential = await FirebaseAuth.instance
                                    //         .createUserWithEmailAndPassword(email: element.email!, password: element.password!)
                                    //         .timeout(FirebaseFun.timeOut);
                                    //     final user = UserModel(
                                    //         uid: userCredential.user!.uid,
                                    //         email: element.email,
                                    //         name:element.name,
                                    //         phoneNumber: element.phoneNumber,
                                    //         // userName: userName,
                                    //         password: element.password,
                                    //         typeUser: AppConstants.collectionUser,
                                    //         photoUrl: element.photoUrl);
                                    //     await FirebaseFirestore.instance
                                    //         .collection(FirebaseConstants.collectionUser)
                                    //         .doc(user.uid)
                                    //         .set(user.toJson());
                                    //   }catch(e){}
                                    // }
                                    //
                                    // ConstantsWidgets.closeDialog();
                                    List<PersonModel> listPerson=[
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath: listImages[0],name: "شخص تجريبي1",email:"user1@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[0] ,name: "شخص تجريبي2",email:"user1@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[1] ,name: "شخص تجريبي3",email:"user2@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[2] ,name: "شخص تجريبي4",email:"user2@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[3] ,name: "شخص تجريبي5",email:"user3@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[4] ,name: "شخص تجريبي6",email:"user4@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[5] ,name: "شخص تجريبي7",email:"user5@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[6] ,name: "شخص تجريبي8",email:"user6@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[Random.secure().nextInt(listImages.length-1)] ,name: "شخص تجريبي9",email:"user7@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[Random.secure().nextInt(listImages.length-1)] ,name: "شخص تجريبي10",email:"use11@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[Random.secure().nextInt(listImages.length-1)] ,name: "شخص تجريبي11",email:"user12@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[Random.secure().nextInt(listImages.length-1)] ,name: "شخص تجريبي12",email:"user13@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[Random.secure().nextInt(listImages.length-1)] ,name: "شخص تجريبي12",email:"user14@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[Random.secure().nextInt(listImages.length-1)] ,name: "شخص تجريبي14",email:"user16@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[Random.secure().nextInt(listImages.length-1)] ,name: "شخص تجريبي13",email:"user15@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[Random.secure().nextInt(listImages.length-1)] ,name: "شخص تجريبي15",email:"user17@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[Random.secure().nextInt(listImages.length-1)] ,name: "شخص تجريبي16",email:"user8@gmail.com" ,phoneNumber: "999666333"),
                                      PersonModel(idUser: 'JmFuQmdmzSOGMtEVsEwthwWA6oH2',imagePath:listImages[Random.secure().nextInt(listImages.length-1)] ,name: "شخص تجريبي17",email:"user19@gmail.com" ,phoneNumber: "999666333"),
                                     ];
                                    // ConstantsWidgets.showLoading();
                                    // for(PersonModel element in listPerson){
                                    //   try{
                                    //
                                    //     PersonModel personModel=PersonModel(
                                    //         id: element.name!+'${Timestamp.now().microsecondsSinceEpoch}',
                                    //         name: element.name,
                                    //         description: "وصف تجريبي",
                                    //         imagePath: element.imagePath,
                                    //         dateTime: DateTime.now(),
                                    //         email:element.email ,
                                    //         phoneNumber: element.phoneNumber,
                                    //         idUser: element.idUser
                                    //     );
                                    //
                                    //     var
                                    //     result=await FirebaseFun.addPerson(person:personModel);
                                    //
                                    //   }catch(e){}
                                    // }
                                    //
                                    // ConstantsWidgets.closeDialog();
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
