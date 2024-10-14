// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:social_sight_scope/core/dialogs/general_bottom_sheet.dart';
// import 'package:social_sight_scope/core/dialogs/general_dialog.dart';
// import 'package:social_sight_scope/core/dialogs/type/loading_dialog.dart';
// import 'package:social_sight_scope/core/dialogs/type/picker_dialog.dart';
// import 'package:social_sight_scope/core/helpers/extensions.dart';
// import 'package:social_sight_scope/core/helpers/spacing.dart';
// import 'package:social_sight_scope/core/utils/color_manager.dart';
// import 'package:social_sight_scope/core/utils/style_manager.dart';
// import 'package:social_sight_scope/translations/locale_keys.g.dart';
//
// class FaceDetectedModeScreen extends StatefulWidget {
//   const FaceDetectedModeScreen({Key? key}) : super(key: key);
//
//   @override
//   _FaceDetectedModeScreenState createState() => _FaceDetectedModeScreenState();
// }
//
// class _FaceDetectedModeScreenState extends State<FaceDetectedModeScreen> {
//   String pathOfImage = "ahsdg";
//   String moodImagePath = "";
//   String moodDetail = "";
//   bool isVisible = false;
//
//   FaceDetector detector = GoogleMlKit.vision.faceDetector(
//     FaceDetectorOptions(
//       enableClassification: true,
//       enableLandmarks: true,
//       enableContours: true,
//       enableTracking: true,
//     ),
//   );
//
//   @override
//   void dispose() {
//     super.dispose();
//     detector.close();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(tr(LocaleKeys.home_analyze_emotion_text),),
//       ),
//         body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Visibility(
//           visible: isVisible,
//           child: Image.asset(
//             moodImagePath,
//             width: 200.w,
//             height: 200.h,
//           ),
//         ),
//         Visibility(
//           visible: isVisible,
//           child: Text.rich(
//             TextSpan(
//               children: [
//                 TextSpan(
//                   text: "Your Mood is ",
//                   style: StyleManager.font30SemiBold(
//                       color: ColorManager.primaryColor
//                   )
//                 ),
//                 TextSpan(
//                   text: '$moodDetail'
//                 )
//               ]
//             ),
//             style: StyleManager.font20Bold(),
//           ),
//         ),
//         verticalSpace(20.h),
//         Align(
//           alignment: Alignment.center,
//           child: TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: ColorManager.primaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.r),
//               )
//             ),
//             onPressed: () async {
//               showCustomBottomSheet(context,
//                   child: PickerDialog(
//                       galleryPicker: () => pickImage(ImageSource.gallery),
//                       cameraPicker: () => pickImage(ImageSource.camera)));
//
//               await Future.delayed(Duration(seconds: 7), () {
//                 extractData(pathOfImage);
//               });
//               context.pop();
//             },
//             child: Text(
//               tr(LocaleKeys.detected_face_pick_photo_text),
//               style: StyleManager.font18Medium(
//                 color: ColorManager.blackColor
//               ),
//             ),
//           ),
//         )
//       ],
//     ));
//   }
//
//   void pickImage(ImageSource source) async {
//     ImagePicker imagePicker = ImagePicker();
//     XFile? image = await imagePicker.pickImage(source: source);
//     setState(() {
//       pathOfImage = image!.path;
//     });
//   }
//
//   void extractData(String imagePath) async {
//     final inputImage = InputImage.fromFilePath(imagePath);
//     List<Face> faces = await detector.processImage(inputImage);
//
//     if (faces.length > 0 && faces[0].smilingProbability != null) {
//       double? prob = faces[0].smilingProbability;
//
//       if (prob! > 0.8) {
//         setState(() {
//           moodDetail = "Happy";
//           moodImagePath = "assets/icons/happy.png";
//         });
//       } else if (prob > 0.3 && prob < 0.8) {
//         setState(() {
//           moodDetail = "Normal";
//           moodImagePath = "assets/icons/meh.png";
//         });
//       } else if (prob > 0.06152385 && prob < 0.3) {
//         setState(() {
//           moodDetail = "Sad";
//           moodImagePath = "assets/icons/sad.png";
//         });
//       } else {
//         setState(() {
//           moodDetail = "Angry";
//           moodImagePath = "assets/icons/angry.png";
//         });
//       }
//       setState(() {
//         isVisible = true;
//       });
//     }
//   }
// }
