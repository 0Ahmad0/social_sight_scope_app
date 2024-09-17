import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';

import '../../core/utils/color_manager.dart';
import '../../core/utils/style_manager.dart';
import '../../translations/locale_keys.g.dart';

class DrawerItemWidget extends StatelessWidget {
  const DrawerItemWidget(
      {super.key,
      required this.text,
      required this.icon,
      this.onTap,
      this.isColored = false,
      this.route});

  final String text;
  final String? route;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isColored;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap ?? ()=>context.pushNamed(route!),
      leading: Icon(
        icon,
        color: isColored ? ColorManager.primaryColor : null,
      ),
      title: Text(
        text,
        style: StyleManager.font14Regular()
            .copyWith(color: isColored ? ColorManager.primaryColor : null),
      ),
    );
  }
}
