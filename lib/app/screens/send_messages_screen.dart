import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_sight_scope/core/helpers/sizer.dart';
import 'package:social_sight_scope/core/helpers/spacing.dart';
import 'package:social_sight_scope/core/utils/assets_manager.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../widgets/no_messages_yet_widget.dart';

class SendMessagesScreen extends StatefulWidget {
  const SendMessagesScreen({super.key});

  @override
  State<SendMessagesScreen> createState() => _SendMessagesScreenState();
}

class _SendMessagesScreenState extends State<SendMessagesScreen> {
  final messageController = TextEditingController();

  final List<String> _messages = [];

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        elevation: 2.sp,
        titleSpacing: -20.w,
        title: ListTile(
          dense: true,
          leading: InkWell(
            onTap: () {},
            child: Hero(
              tag: args['index'].toString(),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://th.bing.com/th/id/OIP.T9JAjD62Bdbaqn5nyyPjwAHaHa?rs=1&pid=ImgDetMain',
                ),
              ),
            ),
          ),
          title: Text(
            'لين الحربي',
          ),
          subtitle: Text(
            'online',
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? NoMessagesYetWidget()
                : ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) => index.isEven
                        ? Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: getWidth(context) / 1.5),
                              padding: EdgeInsets.all(10.sp),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color:
                                    ColorManager.primaryColor.withOpacity(.5),
                                borderRadius: BorderRadiusDirectional.only(
                                    topStart: Radius.circular(12.r),
                                    topEnd: Radius.circular(12.r),
                                    bottomEnd: Radius.circular(12.r)),
                              ),
                              child: Text('${_messages[index]}'),
                            ),
                          )
                        : Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Container(
                              constraints: BoxConstraints(
                                maxWidth: getWidth(context) / 1.5,
                              ),
                              padding: EdgeInsets.all(10.sp),
                              decoration: BoxDecoration(
                                  color: ColorManager.grayColor,
                                  borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(12.r),
                                      topEnd: Radius.circular(12.r),
                                      bottomStart: Radius.circular(12.r))),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              child: Text('${_messages[index]}'),
                            ),
                          ),
                  ),
          ),
          AppPaddingWidget(
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    minLines: 1,
                    maxLines: 4,
                    controller: messageController,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _messages.add(messageController.text);
                          });
                          messageController.clear();
                        },
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(8.sp),
                          padding: EdgeInsets.all(8.sp),
                          decoration: BoxDecoration(
                            color: ColorManager.primaryColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: SvgPicture.asset(
                            AssetsManager.sendMessageIcon,
                            color: ColorManager.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                horizontalSpace(10.w),
                Container(
                  width: 50.w,
                  height: 50.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ColorManager.primaryColor, shape: BoxShape.circle),
                  child: Icon(
                    Icons.keyboard_voice_outlined,
                    color: ColorManager.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
