import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_sight_scope/app/controllers/home_persons_controller.dart';
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
import '../controllers/persons_controller.dart';

class HomeUserWidget extends StatelessWidget {
  const HomeUserWidget({
    super.key,
    required this.currentIndex,
    required this.index, required this.person,
  });

  final int currentIndex;
  final int index;
  final PersonModel person;

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
                  child:
    CircleUserPictureWidget(
    path:person.imagePath,
    name:person.name,

    radius:80.sp ,
    )
                  // Image.network(
                  //   width: 80.w,
                  //   height: 80.h,
                  //   'https://news.griffith.edu.au/wp-content/uploads/2014/09/GriffithGC-5745-682x1024.jpg',
                  // ),
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
                        person.name??'',
                        // 'محمد عبد الله ',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font14Medium(
                            color: ColorManager.whiteColor
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          person.description??'',
                          // 'الوصف الوصف الوصف',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: StyleManager.font12Medium(
                              color: ColorManager.whiteColor
                          ),
                        ),
                        InkWell(onTap: (){
                          Get.defaultDialog(
                            confirm: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor:
                                        Theme.of(context).primaryColor),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await Get.put(HomePersonsController()).deletePerson(context,idPerson: person.id);
                                      // chatProvider.deleteUserInGroup(context, idUser: idUser);
                                    },
                                    child: Text(
                                      tr(LocaleKeys.ok),
                                      style: StyleManager.font12Light(),
                                    )),
                                // SizedBox(
                                //   width: 8.w,
                                // ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor: ColorManager.errorColor,
                                        backgroundColor: ColorManager.errorColor),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      tr(LocaleKeys.cancel),
                                      style: StyleManager.font12Light(),
                                    )),
                              ],
                            ),
                            titleStyle:
                            StyleManager.font20Bold(),
                            title:tr(LocaleKeys.home_confirm_delete),
                            content: Text(
                                tr(LocaleKeys.home_are_you_sure_delete_person_text),
                                style: StyleManager.font16Regular()
                            ),
                            radius: 14.sp,
                          );

                        }, child: CircleAvatar(
                          backgroundColor: ColorManager.whiteColor.withOpacity(0.4),
                          radius: 14.sp,
                          child: Icon(Icons.delete_outline,color: ColorManager.errorColor
                            ,size: 20.sp,),
                        ))
                      ],
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
                      child: InkWell(
                        onTap: (){
                          // context.pushNamed(Routes.showPersonDetailsRoute);
                          Get.put(PersonController()).person=person;
                          Get.toNamed(Routes.addNewPersonRoute,arguments: {'person':person});
                        },
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
                    ),
                    verticalSpace(10.h),
                    FadeInDown(
                      child: InkWell(
                        onTap: (){
                          // context.pushNamed(Routes.sendMessageRoute,arguments: {
                          //   'index':index.toString()
                          // });
                          Get.put(PersonsController()).connectionPerson(context, person,index);
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
