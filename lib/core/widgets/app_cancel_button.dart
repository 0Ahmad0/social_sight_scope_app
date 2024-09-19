import 'package:flutter/material.dart';

import '../utils/color_manager.dart';
import '../utils/style_manager.dart';
class AppCancelButton extends StatelessWidget {
  const AppCancelButton({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
         return ElevatedButton(
      style:
      ElevatedButton.styleFrom(backgroundColor: ColorManager.errorColor),
      onPressed: onPressed,
      child: Text(
        text,
        style: StyleManager.font16SemiBold(color: ColorManager.whiteColor),
      ),
    );
  }
}
