import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/routing/routes.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../widgets/chat_item_widget.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr(LocaleKeys.chat_chats_text),
        ),
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (_, __) => const Divider(
          height: 0,
          thickness: .4,
        ),
        itemBuilder: (context, index) => ChatItemWidget(
            name: 'ليلى الحربي',
            lastMessage: 'مرحبا كبف الحال...',
            index: index),
      ),
    );
  }
}
