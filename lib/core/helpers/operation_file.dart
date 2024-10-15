


import 'package:easy_localization/easy_localization.dart';

import '../../translations/locale_keys.g.dart';

String formatFileSize(int fileSize) {
  double b = fileSize / 1;
  double kb = fileSize / 1024;
  double mb = kb / 1024;
  double gb = mb / 1024;

  if (gb >= 1) {
    return '${gb.toStringAsFixed(2)} ${tr(LocaleKeys.GB)}';//GB';
  } else if (mb >= 1) {
    return '${mb.toStringAsFixed(2)} ${tr(LocaleKeys.MB)}';//MB';
  } else if (kb >= 1) {
    return '${kb.toStringAsFixed(2)} ${tr(LocaleKeys.KB)}';//KB';
  } else {
    return '${b.toString()} ${tr(LocaleKeys.B)}';//B';
  }
}


// void openUrl({required String path}) async {
//   // Replace the URL with your own PDF file URL
//   final url = Uri.parse(path);
//   if (await canLaunchUrl(url) ) {
//     await launchUrl(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
//
// void openPdf({required String path}) async {
//   // Replace the URL with your own PDF file URL
//   final url = Uri.parse(path);
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

