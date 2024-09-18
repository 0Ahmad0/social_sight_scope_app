import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/helpers/spacing.dart';
import 'package:social_sight_scope/core/routing/routes.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/const_value_manager.dart';
import '../../core/utils/style_manager.dart';

class HomeUserWidget extends StatelessWidget {
  const HomeUserWidget({
    super.key,
    required this.currentIndex,
    required this.index,
  });

  final int currentIndex;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              color: ColorManager.whiteColor,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.blackColor.withOpacity(.15),
                  offset: Offset(2.sp, 2.sp),
                  blurRadius: 8.sp,
                )
              ]
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: 80.w,
                  height: 80.h,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Image.network(
                    width: 80.w,
                    height: 80.h,
                    'https://news.griffith.edu.au/wp-content/uploads/2014/09/GriffithGC-5745-682x1024.jpg',
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: ColorManager.primaryColor,

                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(14.r),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'محمد عبد الله ',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font14Medium(
                            color: ColorManager.whiteColor
                        ),
                      ),
                    ),
                    Text(

                      'الوصف الوصف الوصف',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font12Medium(
                          color: ColorManager.whiteColor
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (currentIndex == index) ...[
          Positioned.fill(
            child: FadeIn(
              child: AnimatedContainer(
                duration:
                Duration(milliseconds: ConstValueManager.animationDuration),
                decoration: BoxDecoration(
                    color: ColorManager.blackColor.withOpacity(.4),
                    borderRadius: BorderRadius.circular(
                        14.r
                    ),
                    border: Border.all(
                        color: ColorManager.primaryColor
                    )
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInUp(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Text(
                          tr(LocaleKeys.home_show_information_text),
                          style: StyleManager.font12Regular(
                              color: ColorManager.blackColor),
                        ),
                      ),
                    ),
                    verticalSpace(10.h),
                    FadeInDown(
                      child: InkWell(
                        onTap: (){
                          context.pushNamed(Routes.sendMessageRoute,arguments: {
                            'index':index.toString()
                          });
                        },
                        child: Hero(
                          tag: index.toString(),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: ColorManager.whiteColor,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Text(
                              tr(LocaleKeys.home_send_message_text),
                              style: StyleManager.font12Regular(
                                  color: ColorManager.blackColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
