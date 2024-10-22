import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_sight_scope/app/screens/add_new_person_screen.dart';
import 'package:social_sight_scope/app/widgets/picture/cach_picture_widget.dart';
import 'package:social_sight_scope/app/widgets/picture/circle_user_picture_widget.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';

import '../../core/models/chat_model.dart';
import '../../core/models/user_model.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/style_manager.dart';
import '../../translations/locale_keys.g.dart';
import '../controllers/chat_controller.dart';
import '../controllers/process_controller.dart';
import 'animation_profile_widget.dart';

class ChatItemWidget extends StatelessWidget {
   ChatItemWidget({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.index,
    required this.chat,
  });

  final String name;
  final String lastMessage;
  final int index;
  final Chat chat;
  final ProcessController _processController = Get.put(ProcessController());


  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(index.toString()),
      direction: Localizations.localeOf(context).languageCode == 'ar'
          ? DismissDirection.startToEnd
          : DismissDirection.endToStart,
      background: Container(
        color: ColorManager.errorColor,
        alignment: Localizations.localeOf(context).languageCode == 'ar'
            ? Alignment.centerLeft
            : Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
       return( await  Get.defaultDialog(
         confirm: Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             TextButton(
                 style: TextButton.styleFrom(
                     backgroundColor:
                     Theme.of(context).primaryColor),
                 onPressed: () async {
                   Navigator.pop(context);
                   var result=  await Get.put(ChatController()).deleteChat(context, idChat: chat.id);
                   return result['status'];
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
         // onConfirm:() {
         //   Get.put(ChatController()).deleteChat(context, idChat: chat.id);
         // },
         // onCancel: (){
         //   print('false');
         // },
          titleStyle:
          StyleManager.font20Bold(),
          title:tr(LocaleKeys.home_confirm_delete),
          content: Text(
            tr(LocaleKeys.home_are_you_sure_delete_chat_text),
            style: StyleManager.font16Regular()
          ),
          radius: 14.sp,
        ))??false;
      },
      onDismissed: (direction) {
        print("Item $index dismissed");
      },
      child: ListTile(
        onTap: () {

          context.pushNamed(Routes.sendMessageRoute,arguments: {
            'index':index.toString(),
            'chat':chat
          });

          //TODO for check if not chat
          // ConstantsWidgets.showLoading();
          // await controller.fetchChatByListIdUser(
          //     listIdUser: controller.chat.listIdUser);
          // Get.back();

        },
        dense: true,
        leading: Builder(builder: (context1) {
          return

            GetBuilder<ProcessController>(
                builder: (ProcessController processController) {
                  processController.fetchUserAsync(context, idUser: name);
                  UserModel? user = processController.fetchLocalUser(idUser: name);
                  return
            InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  fullscreenDialog: true,
                  barrierDismissible: true,
                  pageBuilder: (context, _, __) => AnimationProfileWidget(
                    index: index,
                    photoUrl: user?.photoUrl,
                    name: name,
                    chat: chat,
                  ),
                ),
              );
            },
            child:
            Hero(
              tag: index.toString(),
              child:


                    user?.photoUrl != null||true
                      ? ClipOval(
                      child: CircleUserPictureWidget(
                        name:name,
                        path: user?.photoUrl ?? '',
                        // width: 30,
                        // height: 30
                        radius: 50,
                        boxFit: BoxFit.fill,
                        waitWidget: CircleAvatar(),
                        // errorWidget: CircleAvatar(),
                      ))
                      : CircleAvatar()


              // CircleAvatar(
              //   backgroundImage: NetworkImage(
              //     'https://th.bing.com/th/id/OIP.T9JAjD62Bdbaqn5nyyPjwAHaHa?rs=1&pid=ImgDetMain',
              //   ),
              // ),
            ),
          );  },
            );
        }),
        title:
        fetchName(context,name),
        // Text(
        //
        //   name,
        //   maxLines: 1,
        //   overflow: TextOverflow.ellipsis,
        //   style: StyleManager.font18Medium(),
        // ),
        subtitle:
        fetchLastMessage(context,lastMessage)
        // Text(
        //   lastMessage,
        //   maxLines: 1,
        //   overflow: TextOverflow.ellipsis,
        // ),
      ),
    );
  }
   fetchName(BuildContext context,String idUser){
     return _processController.widgetNameUser(context, idUser: idUser);
   }
   fetchLocalUser(BuildContext context,String idUser){
     return _processController.fetchUser(context, idUser: idUser);
   }
   fetchLastMessage(BuildContext context,String idChat){
     return Get.put(ChatController()).widgetLastMessage(context, idChat: idChat);
   }
}
