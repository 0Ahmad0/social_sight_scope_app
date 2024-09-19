import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/color_manager.dart';

showCustomBottomSheet(
  BuildContext context, {
  required Widget child,
  Color color = ColorManager.whiteColor,
  bool isScrollControlled = true,
  bool enableDrag = true,
  bool isDismissible = false,
}) {
  showModalBottomSheet(
    backgroundColor: color,
    isScrollControlled: isScrollControlled,
    enableDrag: enableDrag,
    isDismissible: isDismissible,
    context: context,
    builder: (context) => child,
  );
}
