import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:social_sight_scope/app/widgets/picture/profile_picture_widget.dart';
import '../../../core/utils/color_manager.dart';
import '../../controllers/profile_controller.dart';
import 'cach_picture_widget.dart';

class CircleUserPictureWidget extends StatelessWidget {
  const CircleUserPictureWidget({
    super.key,
    this.radius,
    required this.path,
    required this.name,
  });

  final double? radius;
  final String? path;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return Container(

        width: radius?.sp,
        height: radius?.sp,

      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(shape: BoxShape.circle,
        border: Border.all(
        color: ColorManager.primaryColor,
        width: 1.5,
      )),
      child:

      // controller.profileImage== null? Image.network(
      //   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRS37JAC_YF1l4Nih5_FG15JI_EuFVRvVsveZKTGBNsmfqyeLGzTKMWY-prH8CGsLkxbb4&usqp=CAU',
      //   width: radius.sp,
      //   height: radius.sp,
      //   fit: BoxFit.cover,
      // )

      path==null||true? CacheNetworkImage(
        photoUrl:   // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
        '${ path}',
        width: radius?.sp,
        height: radius?.sp,
        boxFit: BoxFit.cover,
        waitWidget: WidgetProfilePicture(
          name: name??'',
          radius: radius?.sp,
          backgroundColor: ColorManager.whiteColor,
          textColor: ColorManager.primaryColor,
        ),
        errorWidget: WidgetProfilePicture(
          name: name??'',
          radius: radius?.sp,

          backgroundColor: ColorManager.whiteColor,
          textColor: ColorManager.primaryColor,
        ),
      )
          :
      Image.network(
        width: radius?.sp,
        height: radius?.sp,
        'https://news.griffith.edu.au/wp-content/uploads/2014/09/GriffithGC-5745-682x1024.jpg',
      )
      // Image.file(
      //   File(path!),
      //   width: radius?.sp,
      //   height: radius?.sp,
      //   fit: BoxFit.cover,
      // ),
    );
  }
}
