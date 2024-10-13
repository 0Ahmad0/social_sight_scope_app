import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_sight_scope/app/controllers/person_controller.dart';
import 'package:social_sight_scope/app/widgets/picture/circle_user_picture_widget.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/helpers/spacing.dart';
import 'package:social_sight_scope/core/models/person_model.dart';
import 'package:social_sight_scope/core/routing/routes.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/const_value_manager.dart';
import '../../core/utils/style_manager.dart';

class SearchUserWidget extends StatelessWidget {
  const SearchUserWidget({
    super.key,
    // required this.currentIndex,
    required this.index,
    required this.person,
  });

  // final int currentIndex;
  final int index;
  final PersonModel person;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.whiteColor,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: ColorManager.blackColor.withOpacity(.05),
            offset: Offset(2.sp, 2.sp),
            blurRadius: 8.sp,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        leading: CircleUserPictureWidget(
          path: person.imagePath,
          name: person.name,
          radius: 45.sp,
        ),
        title: Text(
          person.name ?? '',
          maxLines: 1,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: StyleManager.font14Medium(
            color: ColorManager.blackColor,
          ),
        ),
        subtitle: Text(
          person.description ?? '',
          maxLines: 2,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: StyleManager.font12Medium(
            color: ColorManager.blackColor,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.message, color: ColorManager.primaryColor),
              onPressed: () {
                context.pushNamed(Routes.sendMessageRoute, arguments: {
                  'index': index.toString(),
                });
              },
            ),
            // if (currentIndex == index)
            //   Container(
            //     width: 4.w,
            //     height: 50.h,
            //     color: ColorManager.primaryColor,
            //   ),
          ],
        ),
        onTap: () {
          Get.put(PersonController()).person = person;
          Get.toNamed(Routes.addNewPersonRoute, arguments: {'person': person});
        },
      ),
    );
  }
}
