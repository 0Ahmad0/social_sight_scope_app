import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/helpers/spacing.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';

import '../../core/routing/routes.dart';
import '../../core/utils/color_manager.dart';
import 'animation_profile_button_widget.dart';

class AnimationProfileWidget extends StatelessWidget {
  const AnimationProfileWidget({super.key, required this.index});

  final int index;

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
                      child: Image.network(
                        'https://th.bing.com/th/id/OIP.T9JAjD62Bdbaqn5nyyPjwAHaHa?rs=1&pid=ImgDetMain',
                      ),
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
                                  arguments: {'index': index.toString()});
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
