import 'package:flutter/material.dart';

import '../../core/utils/color_manager.dart';

class AnimationProfileButtonWidget extends StatelessWidget {
  const AnimationProfileButtonWidget({
    super.key,
    required this.icon,
    this.onPressed,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: IconButton.filled(
      style: IconButton.styleFrom(
        backgroundColor: ColorManager.primaryColor.withOpacity(.90),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: ColorManager.whiteColor,
      ),
    ));
  }
}
