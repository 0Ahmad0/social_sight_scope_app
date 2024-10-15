import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/models/chat_model.dart';
import 'package:social_sight_scope/core/routing/routes.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../../core/widgets/constants_widgets.dart';
import '../controllers/chat_controller.dart';
import '../widgets/chat_item_widget.dart';
import '../widgets/empty_widget.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  late ChatController chatController;
  @override
  void initState() {
    chatController = Get.put(ChatController());
    chatController.onInit();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr(LocaleKeys.chat_chats_text),
        ),
      ),
      body:
      StreamBuilder<QuerySnapshot>(
          stream: chatController.getChats,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return    ConstantsWidgets.circularProgress();
            } else if (snapshot.connectionState ==
                ConnectionState.active) {
              if (snapshot.hasError) {
                return  Text(tr(LocaleKeys.empty_data));
              } else if (snapshot.hasData) {
                ConstantsWidgets.circularProgress();
                chatController.chats.listChat.clear();
                if (snapshot.data!.docs!.length > 0) {
                  chatController.chats = Chats.fromJson(snapshot.data!.docs!);
                }
                return

                      (chatController.chats.listChat.isEmpty)
                          ? EmptyWidget(
                          text: tr(LocaleKeys.chat_no_chats_yet))
                          // text: "No Chats Yet!")
                          :

                      buildChats(context, chatController.chats.listChat ?? []);
              } else {
                return  Text(tr(LocaleKeys.empty_data));
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          }),
      // ListView.separated(
      //   itemCount: 10,
      //   separatorBuilder: (_, __) => const Divider(
      //     height: 0,
      //     thickness: .4,
      //   ),
      //   itemBuilder: (context, index) => ChatItemWidget(
      //       name: 'ليلى الحربي',
      //       lastMessage: 'مرحبا كبف الحال...',
      //       index: index),
      // ),
    );
  }
  Widget buildChats(BuildContext context,List<Chat> items){
    return
      GetBuilder<ChatController>(
        builder: (ChatController controller)=>
      ListView.separated(
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(
          height: 0,
          thickness: .4,
        ), // لتحديد المسافة بين العناصر
        itemBuilder: (context, index) => ChatItemWidget( // استخدم الويجيت الجديدة ListTile
          name: (controller.currentUserId.contains(controller.chats.listChat[index].listIdUser[0]))
              ?controller.chats.listChat[index].listIdUser[1]
              :controller.chats.listChat[index].listIdUser[0],
          // name: 'ليلى الحربي',
          lastMessage:controller.chats.listChat[index].id,
          // lastMessage: 'مرحبا كبف الحال...',
          index: index,
            chat:controller.chats.listChat[index]

          // currentIndex: 0,
        ),
      ));

  }
}
