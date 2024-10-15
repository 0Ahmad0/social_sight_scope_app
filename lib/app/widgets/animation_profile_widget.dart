import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_sight_scope/app/widgets/picture/cach_picture_widget.dart';
import 'package:social_sight_scope/app/widgets/picture/circle_user_picture_widget.dart';
import 'package:social_sight_scope/app/widgets/picture/profile_picture_widget.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/helpers/spacing.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';

import '../../core/models/chat_model.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/color_manager.dart';
import 'animation_profile_button_widget.dart';

class AnimationProfileWidget extends StatelessWidget {
  const AnimationProfileWidget({super.key, required this.index, this.photoUrl, this.name, this.chat});

  final int index;
  final String? photoUrl;
  final String? name;
  final Chat? chat;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Hero(
          tag: index.toString(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      clipBehavior: Clip.hardEdge,
                      width: 250.w,
                      height: 250.w,
                      decoration: BoxDecoration(),
                      child:


                  CacheNetworkImage(
                    withCircle: false,
                  photoUrl:   // "https://th.bing.com/th/id/R.1b3a7efcd35343f64a9ae6ad5b5f6c52?rik=HGgUvyvtG4jbAQ&riu=http%3a%2f%2fwww.riyadhpost.live%2fuploads%2f7341861f7f918c109dfc33b73d8356b2.jpg&ehk=3Z4lADOKvoivP8Tbzi2Y56dxNrCWd0r7w7CHQEvpuUg%3d&risl=&pid=ImgRaw&r=0",
                  '${ photoUrl??''}',
                  width:  250.w,
                  height:  250.w,
                  boxFit: BoxFit.fill,
                  waitWidget: WidgetProfilePicture(
                    name: name??'',
                    radius:250.w,
                    fontSize: 100.sp,
                    backgroundColor: ColorManager.whiteColor,
                    textColor: ColorManager.primaryColor,
                  ),
                  errorWidget: WidgetProfilePicture(
                    name: name??'',
                    radius: 250.w,
                    fontSize: 100.sp,
                    backgroundColor: ColorManager.whiteColor,
                    textColor: ColorManager.primaryColor,
                  ),
                )
                      // Image.network(
                      //   'https://th.bing.com/th/id/OIP.T9JAjD62Bdbaqn5nyyPjwAHaHa?rs=1&pid=ImgDetMain',
                      // ),
                    ),
                    Container(
                      width: 250.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: ColorManager.blackColor.withOpacity(.75)),
                      child: Row(

                        children: [
                          AnimationProfileButtonWidget(
                            icon: Icons.info_outlined,
                            onPressed: () {},
                          ),
                          horizontalSpace(1.w),
                          AnimationProfileButtonWidget(
                            icon: Icons.message_outlined,
                            onPressed: () {
                              context.pop();
                              context.pushNamed(Routes.sendMessageRoute,
                                  arguments: {'index': index.toString(),
                                    'chat':chat
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                width: 250.w,
                decoration: BoxDecoration(
                  color: ColorManager.blackColor.withOpacity(.5),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    'ليلى الحربي',
                    style: StyleManager.font14Regular(
                        color: ColorManager.whiteColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(
          flex: 4,
        ),
      ],
    );
  }
}
