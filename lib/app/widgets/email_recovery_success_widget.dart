// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../core/utils/string_manager.dart';
// import '../controllers/forget_password_controller.dart';
//
//
// class EmailRecoverySuccessBottomSheetWidget extends GetView<ForgetPasswordController> {
//   const EmailRecoverySuccessBottomSheetWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultScaffoldWidget(
//       child: Padding(
//         padding:  EdgeInsets.all(12.sp),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: AppSize.s20,
//             ),
//             Center(
//               child: Text(
//                 StringManager.emailRecoverySend,
//                 style:
//                     StylesManager.textBoldStyle(color: ColorManager.primaryColor),
//               ),
//             ),
//             const SizedBox(
//               height: AppSize.s20,
//             ),
//             Text(AppString.emailRecoveryDescription(controller.emailController.value.text.substring(0,4)),style: StylesManager.textNormalStyle(
//               color: ColorManager.primaryColor,
//               size: 16.sp
//             ),),
//             const SizedBox(
//               height: AppSize.s20,
//             ),
//             Text(AppString.linkValidAt,style: StylesManager.textNormalStyle(
//                 color: ColorManager.primaryColor,
//                 size: 18.sp
//             ),),
//             const Spacer(),
//         GetBuilder<ForgetPasswordController>(
//             builder: (controller)=>
//
//             Center(child: Text(controller.getTimeDifference(),style: StylesManager.textBoldStyle(
//               color: ColorManager.primaryColor,
//               size: 40.sp
//             ),))),
//             const SizedBox(
//               height: AppSize.s10,
//             ),
//             const Spacer(),
//             TextButton(
//               onPressed: () {
//                 controller.send();
//               },
//               child: Text(AppString.resendLink,style: StylesManager.textNormalStyle(
//                   color: ColorManager.primaryColor,
//                   size: 16.sp
//               ),),
//             ),
//             const SizedBox(
//               height: AppSize.s20,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
//               child: ButtonAppWidget(onPressed: (){
//                 Get.back();
//               }, text: AppString.verify),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
