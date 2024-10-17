import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_sight_scope/app/widgets/boarder_chat_widget.dart';
import 'package:social_sight_scope/core/helpers/sizer.dart';
import 'package:social_sight_scope/core/helpers/spacing.dart';
import 'package:social_sight_scope/core/models/user_model.dart';
import 'package:social_sight_scope/core/utils/assets_manager.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../../core/enums/enums.dart';
import '../../core/models/chat_model.dart';
import '../../core/models/message_model.dart';
import '../../core/widgets/constants_widgets.dart';
import '../controllers/chat_controller.dart';
import '../controllers/chat_room_controller.dart';
import '../controllers/process_controller.dart';
import '../widgets/message_widget.dart';
import '../widgets/no_messages_yet_widget.dart';
import '../widgets/picture/circle_user_picture_widget.dart';

class SendMessagesScreen extends StatefulWidget {
  const SendMessagesScreen({super.key});

  @override
  State<SendMessagesScreen> createState() => _SendMessagesScreenState();
}

class _SendMessagesScreenState extends State<SendMessagesScreen> {
  final messageController = TextEditingController();

  final List<String> _messages = [];
  late ChatRoomController controller;
  bool _isEnglishInput = false;

  void _validateInput(String input) {
    // setState(() {
    _isEnglishInput = input.contains(RegExp(r'[a-zA-Z]'));
    // });
  }
  var args;
  @override
  void initState() {
    controller = Get.put(ChatRoomController());
    super.initState();


  }
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    args=ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    controller.chat=(args['chat'] is Chat?)?args['chat']:null;
    controller.onInit();

    Get.lazyPut(() => ProcessController());
    ProcessController.instance.fetchUser(context,idUser: controller.recId??'');
    // final args =
    // ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        elevation: 2.sp,
        titleSpacing: -20.w,
        title:
        GetBuilder<ProcessController>(
          builder: (ProcessController processController)=>
        ListTile(
          dense: true,
          leading: InkWell(
            onTap: () {},
            child: Hero(
              tag: args['index'].toString(),
              child:
              ClipOval(
                  child: CircleUserPictureWidget(
                    name: '${processController.fetchLocalUser(idUser: controller.recId ?? 'ALL Chat')?.name ?? ''}',
                    path:       '${processController.fetchLocalUser(idUser: controller.recId ?? '')?.photoUrl ?? ''}',
                    // width: 30,
                    // height: 30
                    radius: 50,
                    boxFit: BoxFit.fill,
                    waitWidget: CircleAvatar(),
                    // errorWidget: CircleAvatar(),
                  )),
              // CircleAvatar(
              //   backgroundImage: NetworkImage(
              //     'https://th.bing.com/th/id/OIP.T9JAjD62Bdbaqn5nyyPjwAHaHa?rs=1&pid=ImgDetMain',
              //   ),
              // ),
            ),
          ),
          title: Text(
            '${processController.fetchLocalUser(idUser: controller.recId ?? 'ALL Chat')?.name ?? tr(LocaleKeys.deleted_account)}'
            // 'لين الحربي',
          ),
          subtitle:
          buildLastSeen(context),
          // Text(
          //     processController.fetchLocalUser(idUser: controller.recId ?? 'ALL Chat')?.getStatus()??"Offline"
          //   // 'online',
          // ),
        ),
      )),
      body: Column(
        children: [
          Expanded(
            child:
            StreamBuilder<QuerySnapshot>(
                stream: controller.getChat,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return    ConstantsWidgets.circularProgress();
                  } else if (snapshot.connectionState ==
                      ConnectionState.active) {
                    if (snapshot.hasError) {
                      return  Text(tr(LocaleKeys.empty_data));
                    } else if (snapshot.hasData) {

                      ConstantsWidgets.circularProgress();
                      controller.chat?.messages.clear();
                      if (snapshot.data!.docs!.length > 1) {
                        controller.chat?.messages =
                            Messages.fromJson(snapshot.data!.docs!).listMessage;
                      }

                      return GetBuilder<ChatRoomController>(
                      init: controller,
                          builder: (ChatRoomController chatRoomController){
                        Message? message=controller.waitMessage.lastOrNull;
                        message?.checkSend=false;
                        if(message!=null)
                          controller.chat?.messages.add( message);

                        return
                          buildChat(context,controller.chat?.messages ?? []);
                          });

                    } else {
                      return  Text(tr(LocaleKeys.empty_data));
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                }),
            //
            // _messages.isEmpty
            //     ? NoMessagesYetWidget()
            //     : ListView.builder(
            //         itemCount: _messages.length,
            //         itemBuilder: (context, index) => index.isEven
            //             ? Align(
            //                 alignment: AlignmentDirectional.centerStart,
            //                 child: Container(
            //                   constraints: BoxConstraints(
            //                       maxWidth: getWidth(context) / 1.5),
            //                   padding: EdgeInsets.all(10.sp),
            //                   margin: EdgeInsets.symmetric(
            //                       horizontal: 10.w, vertical: 10.h),
            //                   decoration: BoxDecoration(
            //                     color:
            //                         ColorManager.primaryColor.withOpacity(.5),
            //                     borderRadius: BorderRadiusDirectional.only(
            //                         topStart: Radius.circular(12.r),
            //                         topEnd: Radius.circular(12.r),
            //                         bottomEnd: Radius.circular(12.r)),
            //                   ),
            //                   child: Text('${_messages[index]}'),
            //                 ),
            //               )
            //             : Align(
            //                 alignment: AlignmentDirectional.centerEnd,
            //                 child: Container(
            //                   constraints: BoxConstraints(
            //                     maxWidth: getWidth(context) / 1.5,
            //                   ),
            //                   padding: EdgeInsets.all(10.sp),
            //                   decoration: BoxDecoration(
            //                       color: ColorManager.grayColor,
            //                       borderRadius: BorderRadiusDirectional.only(
            //                           topStart: Radius.circular(12.r),
            //                           topEnd: Radius.circular(12.r),
            //                           bottomStart: Radius.circular(12.r))),
            //                   margin: EdgeInsets.symmetric(
            //                       horizontal: 10.w, vertical: 10.h),
            //                   child: Text('${_messages[index]}'),
            //                 ),
            //               ),
            //       ),
          ),
          BoarderChatWidget()
        ],
      ),
    );
  }

  Widget buildChat(BuildContext context, List<Message> messages) {
    controller.chatList = messages;

    return controller.chatList.isEmpty
        ? NoMessagesYetWidget()
        : ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) =>
      // index.isEven


      MessageWidget(

        isCurrentUser:
        controller.chatList[index].senderId ==
            controller.currentUserId,
        index: index,
        message: '',)

    );

    //     : Expanded(
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: List.generate(
    //           controller.chatList.length,
    //               (index) => MessageWidget(
    //
    //             isCurrentUser:
    //             controller.chatList[index].senderId ==
    //                 controller.currentUserId,
    //             index: index,
    //             message: '',)
    //
    //       ),
    //     ),
    //   ),
    // );
  }
  buildLastSeen(BuildContext context){
    return   StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.getLastSeen,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return    Text(tr(LocaleKeys.chat_connecting)+' ...');
            // return    Text("Connection ..");
          } else if (snapshot.connectionState ==
              ConnectionState.active) {
            if (snapshot.hasError) {
              return Text(tr(LocaleKeys.chat_connecting)+' ...');
            } else if (snapshot.hasData) {

              UserModel? user;
              if (snapshot.data?.data()!=null) {


                 user =
                    UserModel.fromJson(snapshot.data?.data());
              }
              return
                Text(user?.getStatus()??tr(LocaleKeys.chat_offline));
                // Text(user?.getStatus()??"Offline");
            } else {
              return  Text(tr(LocaleKeys.chat_connecting)+' ...');;
            }
          } else {
            return Text(tr(LocaleKeys.chat_connecting)+' ...');;
          }
        });
  }
}
