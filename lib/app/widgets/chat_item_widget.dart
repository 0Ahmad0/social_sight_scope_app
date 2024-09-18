import 'package:flutter/material.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';

import '../../core/routing/routes.dart';
import '../../core/utils/style_manager.dart';
import 'animation_profile_widget.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({
    super.key,
    required this.name,
    required this.lastMessage,
    required this.index,
  });

  final String name;
  final String lastMessage;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(Routes.sendMessageRoute,arguments: {
          'index':index.toString()
        });
      },
      dense: true,
      leading: Builder(builder: (context1) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                fullscreenDialog: true,
                barrierDismissible: true,
                pageBuilder: (context, _, __) => AnimationProfileWidget(
                  index: index,
                ),
              ),
            );
          },
          child: Hero(
            tag: index.toString(),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://th.bing.com/th/id/OIP.T9JAjD62Bdbaqn5nyyPjwAHaHa?rs=1&pid=ImgDetMain',
              ),
            ),
          ),
        );
      }),
      title: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: StyleManager.font18Medium(),
      ),
      subtitle: Text(
        lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
