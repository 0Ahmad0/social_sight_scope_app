import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

class FaceDetectedModeScreen extends StatefulWidget {
  const FaceDetectedModeScreen({Key? key}) : super(key: key);

  @override
  _FaceDetectedModeScreenState createState() => _FaceDetectedModeScreenState();
}

class _FaceDetectedModeScreenState extends State<FaceDetectedModeScreen> {
  String pathOfImage = "ahsdg";
  String moodImagePath = "";
  String moodDetail = "";
  bool isVisible = false;

  FaceDetector detector = GoogleMlKit.vision.faceDetector(
    FaceDetectorOptions(
      enableClassification: true,
      enableLandmarks: true,
      enableContours: true,
      enableTracking: true,
    ),
  );

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    detector.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Visibility(
          visible: isVisible,
          child: Container(
            height: 200,
            width: 200,
            child: Image.asset(
              moodImagePath,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Text(
            "Your Girlfriend Mood is $moodDetail",
            style: const TextStyle(
              color: Colors.cyan,
              fontSize: 30,
            ),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => Material(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: (){
                          pickImage(ImageSource.camera);
                        },
                        leading: Icon(Icons.camera_alt_outlined),
                        title: Text(tr(LocaleKeys.home_pick_from_camera_text)),

                      ),
                      ListTile(
                        onTap: (){
                          pickImage(ImageSource.gallery);
                        },
                        leading: Icon(Icons.image_outlined),
                        title: Text(tr(LocaleKeys.home_pick_from_gallery_text)),

                      ),
                    ],
                  ),
                ),
              );
              Future.delayed(Duration(seconds: 7), () {
                extractData(pathOfImage);
              });
            },
            child: const Text(
              "Pick Image",
              style: TextStyle(
                color: Colors.cyan,
                fontSize: 30,
              ),
            ),
          ),
        )
      ],
    ));
  }

  void pickImage(ImageSource source) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: source);
    setState(() {
      pathOfImage = image!.path;
    });
  }

  void extractData(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    List<Face> faces = await detector.processImage(inputImage);

    if (faces.length > 0 && faces[0].smilingProbability != null) {
      double? prob = faces[0].smilingProbability;

      if (prob! > 0.8) {
        setState(() {
          moodDetail = "Happy";
          moodImagePath = "assets/happy.png";
        });
      } else if (prob > 0.3 && prob < 0.8) {
        setState(() {
          moodDetail = "Normal";
          moodImagePath = "assets/meh.png";
        });
      } else if (prob > 0.06152385 && prob < 0.3) {
        setState(() {
          moodDetail = "Sad";
          moodImagePath = "assets/sad.png";
        });
      } else {
        setState(() {
          moodDetail = "Angry";
          moodImagePath = "assets/angry.png";
        });
      }
      setState(() {
        isVisible = true;
      });
    }
  }
}
