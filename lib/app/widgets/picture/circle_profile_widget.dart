import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_sight_scope/app/widgets/picture/profile_picture_widget.dart';
import '../../../core/utils/color_manager.dart';
import '../../controllers/profile_controller.dart';
import 'cach_picture_widget.dart';

class CircleProfilePictureWidget extends GetView<ProfileController> {
  const CircleProfilePictureWidget({
    super.key,
    this.radius = 60.0,
    required this.path,
  });

  final double radius;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.primaryColor,
            width: 1.5,
          ),
          shape: BoxShape.circle),
      child: Container(
        width: radius.sp,
        height: radius.sp,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child:

        // controller.profileImage== null? Image.network(
        //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS37JAC_YF1l4Nih5_FG15JI_EuFVRvVsveZKTGBNsmfqyeLGzTKMWY-prH8CGsLkxbb4&usqp=CAU',
        //   width: radius.sp,
        //   height: radius.sp,
        //   fit: BoxFit.cover,
        // )

        controller.profileImage== null||path==null? CacheNetworkImage(
          photoUrl:   // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
          '${ controller.currentUser.value?.photoUrl??''}',
          width: radius.sp,
          height: radius.sp,
          boxFit: BoxFit.cover,
          waitWidget: WidgetProfilePicture(
            name: controller.currentUser.value?.name??'',
            radius: radius.sp,
            backgroundColor: ColorManager.whiteColor,
            textColor: ColorManager.primaryColor,
          ),
          errorWidget: WidgetProfilePicture(
            name: controller.currentUser.value?.name??'',
            radius: radius.sp,

            backgroundColor: ColorManager.whiteColor,
            textColor: ColorManager.primaryColor,
          ),
        )
            :Image.file(
          File(path!),
          width: radius.sp,
          height: radius.sp,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
