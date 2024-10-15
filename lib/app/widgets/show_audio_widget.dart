import 'dart:async';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;

import '../../core/models/message_model.dart';
import '../../core/utils/color_manager.dart';
import '../../core/utils/string_manager.dart';

class ShowAudioWidget extends StatefulWidget {
  const ShowAudioWidget({Key? key, required this.message}) : super(key: key);
  final Message message;
  @override
  State<ShowAudioWidget> createState() => _ShowAudioWidgetState();
}

class _ShowAudioWidgetState extends State<ShowAudioWidget> {
  String? musicFile;
  // String? path;
  @override
  void initState() {
   // path=Get.parameters['path'];
    if(widget.message.url!=null||widget.message.url!.isNotEmpty);
    super.initState();
    _loadAudioFile();
  }

  void _loadAudioFile() async {
    // نسخ ملف الصوت من assets إلى مجلد مؤقت
    final byteData = await rootBundle.load('assets/sounds/enter_full_name.mp3');
    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/audio1.mp3');
    await tempFile.writeAsBytes(byteData.buffer.asUint8List(), flush: true);

    setState(() {
      musicFile = tempFile.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const SizedBox(height: 4),
        // const SizedBox(height: 20),
        if (widget.message.url != null)
          WaveBubble(
            path: widget.message.url,
            isSender: true,
          ),
      ],
    );
  }
}

class WaveBubble extends StatefulWidget {
  final bool isSender;
  final String? path;

  const WaveBubble({
    Key? key,
    this.isSender = false,
    this.path,
  }) : super(key: key);

  @override
  State<WaveBubble> createState() => _WaveBubbleState();
}

class _WaveBubbleState extends State<WaveBubble> {
  late PlayerController controller;
  late StreamSubscription<PlayerState> playerStateSubscription;

  final playerWaveStyle = PlayerWaveStyle(
    fixedWaveColor: ColorManager.primaryColor.withOpacity(.5),
    liveWaveColor: ColorManager.primaryColor,
    spacing: 6,
  );

  bool isCompleted = false;
  File? file;
  @override
  void initState() {
    super.initState();
    controller = PlayerController();
    _preparePlayer();


    playerStateSubscription = controller.onPlayerStateChanged.listen((state) {
       if (state == PlayerState.stopped) {
        setState(() {
          isCompleted = true;
        });
      } else {
        setState(() {
          isCompleted = false;
        });
      }
    });
  }

  void _preparePlayer() async {
    if (widget.path == null) {
      return;
    }
    ///ToDo local
    // await controller.preparePlayer(
    //   path: widget.path!,
    //   shouldExtractWaveform: true,
    // );
    ///ToDo url
    file ??= await _downloadFile(widget.path!);
    setState(() {});
    if (file != null) {
      await controller.preparePlayer(
        path: file!.path,
        shouldExtractWaveform: true,
      );
    }
  }

  Future<File?> _downloadFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/temp_audio.wav');
        await file.writeAsBytes(response.bodyBytes);
        return file;
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
    return null;
  }



  @override
  void dispose() {
    playerStateSubscription.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.path==null)
      return SizedBox.shrink();
    else if(file==null)
      return Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Spacer(),
          // SizedBox(height: 20),
          Text("جاري التحميل"),
          Spacer()
        ],
      );
      return Row(
      children: [
        IconButton(
          onPressed: () async {


            if (controller.playerState.isPlaying ) {
              await controller.pausePlayer();
            } else {
              if (isCompleted) {
                await controller.seekTo(0);
                setState(() {
                  isCompleted = false;
                });
                await controller.startPlayer(finishMode:FinishMode.pause);
              }else{
                // controller.setRefresh(true);
                await controller.startPlayer(finishMode:FinishMode.pause);
              }

            }
          },
          icon: Icon(
            isCompleted
                ? Icons.replay
                : (controller.playerState.isPlaying ? Icons.pause : Icons.play_arrow),
            size: 40.sp,
          ),
          color: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        Expanded(
          child: AudioFileWaveforms(
            padding:EdgeInsets.zero,
            continuousWaveform: true,
            size: Size(MediaQuery.of(context).size.width - 20, 20),
            // size: Size(MediaQuery.of(context).size.width - 20, 60),
            playerController: controller,
            waveformType: WaveformType.long,
            playerWaveStyle: playerWaveStyle,
            enableSeekGesture: false,
            animationCurve: Curves.bounceIn,
          ),
        ),

      ],
    );
  }
}
