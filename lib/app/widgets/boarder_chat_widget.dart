
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';

import '../../core/enums/enums.dart';
import '../../core/helpers/spacing.dart';
import '../../core/models/message_model.dart';
import '../../core/utils/assets_manager.dart';
import '../../core/utils/color_manager.dart';
import '../controllers/chat_controller.dart';
import '../controllers/chat_room_controller.dart';

class BoarderChatWidget extends StatefulWidget {
  @override
  _BoarderChatWidgetState createState() => _BoarderChatWidgetState();
}

class _BoarderChatWidgetState extends State<BoarderChatWidget> {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  File? _audioFile;
  late ChatRoomController controller;
  bool _isRecorderInitialized=false;

  @override
  void initState() {
    controller = Get.put(ChatRoomController());
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      await _recorder.openRecorder(); // تأكد من أن المسجل يتم فتحه هنا
      setState(() {
        _isRecorderInitialized = true; // علامة لإعلام أن المسجل مفتوح
      });
    } else {
      // التعامل مع حالة رفض الإذن
      print('Permission for microphone is denied');
    }
  }

  Future<void> _startRecording() async {
    if (!_isRecorderInitialized) {
      // إذا لم يكن المسجل مفتوحًا
      print("Recorder is not initialized");
      return;
    }

    Directory tempDir = await getTemporaryDirectory();
    String path = '${tempDir.path}/audio.aac';

    await _recorder.startRecorder(toFile: path);
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    if (!_isRecorderInitialized) {
      // إذا لم يكن المسجل مفتوحًا
      print("Recorder is not initialized");
      return;
    }

    String? path = await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
      _audioFile = File(path!);
    });
  }


  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }
  Future<void> _sendAudioMessage() async {
    if (_audioFile != null) {
      print('object');
      // هنا يتم إرسال ملف الصوت باستخدام الرسالة
      await controller.sendMessage(
        context,
        idChat: controller.chat?.id ?? '',
        message: Message(
          // textMessage: 'Audio message',
          textMessage: XFile(_audioFile!.path).name+'-${Timestamp.now().microsecondsSinceEpoch}',
          sizeFile: (await _audioFile?.length())??0,
          typeMessage: TypeMessage.audio.name,
          senderId: controller.currentUserId,
          receiveId: controller.recId ?? '',
          sendingTime: DateTime.now(),
          localUrl: _audioFile!.path, // مسار الملف الصوتي
        ),
      );
      Get.put(ChatController()).update();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppPaddingWidget(
      child: Row(
        children: [
          Flexible(
            child: TextField(
              minLines: 1,
              maxLines: 4,
              controller: controller.messageController,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () async {
                    if (controller.messageController.text.trim().isNotEmpty) {
                      String message = controller.messageController.value.text;
                      controller.messageController.clear();
                      await controller.sendMessage(
                        context,
                        idChat: controller.chat?.id ?? '',
                        message: Message(
                          textMessage: message,
                          typeMessage: TypeMessage.text.name,
                          senderId: controller.currentUserId,
                          receiveId: controller.recId ?? '',
                          sendingTime: DateTime.now(),
                        ),
                      );
                      Get.put(ChatController()).update();
                    }
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
          GestureDetector(
            onLongPress: _startRecording,
            onLongPressUp: () async {
              await _stopRecording();
              await _sendAudioMessage();
            },
            child: Container(
              width: 50.w,
              height: 50.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorManager.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isRecording ? Icons.stop : Icons.keyboard_voice_outlined,
                color: ColorManager.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//AppPaddingWidget(
//             child: Row(
//               children: [
//                 Flexible(
//                   child: TextField(
//                     minLines: 1,
//                     maxLines: 4,
//                     controller: controller.messageController,
//                     decoration: InputDecoration(
//                       suffixIcon: InkWell(
//                         onTap: () async {
//                           // setState(() {
//                           //   _messages.add(messageController.text);
//                           // });
//                           // messageController.clear();
//
//
//                           if (controller.messageController.text
//                               .trim()
//                               .isNotEmpty) {
//                             String message =
//                                 controller.messageController.value.text;
//                             controller.messageController.clear();
//                             await controller.sendMessage(context,
//                                 idChat: controller.chat?.id ?? '',
//                                 message: Message(
//                                   textMessage: '${message}',
//                                   typeMessage: TypeMessage.text.name,
//                                   senderId: controller.currentUserId,
//                                   receiveId: controller.recId ?? '',
//                                   sendingTime: DateTime.now(),
//                                 ));
//
//                             Get.put(ChatController()).update();
//                           }
//                         },
//                         child: Container(
//                           width: 40.w,
//                           height: 40.w,
//                           alignment: Alignment.center,
//                           margin: EdgeInsets.all(8.sp),
//                           padding: EdgeInsets.all(8.sp),
//                           decoration: BoxDecoration(
//                             color: ColorManager.primaryColor,
//                             borderRadius: BorderRadius.circular(8.r),
//                           ),
//                           child: SvgPicture.asset(
//                             AssetsManager.sendMessageIcon,
//                             color: ColorManager.whiteColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 horizontalSpace(10.w),
//                 Container(
//                   width: 50.w,
//                   height: 50.w,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                       color: ColorManager.primaryColor, shape: BoxShape.circle),
//                   child: Icon(
//                     Icons.keyboard_voice_outlined,
//                     color: ColorManager.whiteColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),