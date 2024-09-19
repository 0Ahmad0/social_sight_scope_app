import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import '../dialogs/type/loading_dialog.dart';

class LauncherHelper {
  static void launchPhone(String number) async {
    final Uri phoneLaunchUri = Uri.parse("tel:$number");

    if (await canLaunchUrl(phoneLaunchUri)) {
     await launchUrl(
        phoneLaunchUri,
      );
    }
  }
  static void launchEmail(String email,{String text = ''}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=App Feedback&body=$text', //add subject and body here
    );

    if (await canLaunchUrl(emailLaunchUri)) {
     await launchUrl(
       emailLaunchUri,
      );
    }
  }
  static Future<void> launchWebsite(BuildContext context,String url) async {
    try {
      final Uri websiteLaunchUri = Uri.parse(url);
      if (await canLaunchUrl(websiteLaunchUri)) {

        await launchUrl(
          websiteLaunchUri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        // LoadingDialog.hide(context);
        throw 'Could not launch $url';
      }
    } catch (e) {
      // LoadingDialog.hide(context);
      print('Error launching URL: $e');
      rethrow;
    }
  }


}
