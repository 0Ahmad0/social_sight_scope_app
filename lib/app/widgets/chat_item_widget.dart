import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_sight_scope/app/screens/add_new_person_screen.dart';
import 'package:social_sight_scope/app/widgets/picture/cach_picture_widget.dart';
import 'package:social_sight_scope/app/widgets/picture/circle_user_picture_widget.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';

import '../../core/models/chat_model.dart';
import '../../core/models/user_model.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/style_manager.dart';
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
    return ListTile(
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
