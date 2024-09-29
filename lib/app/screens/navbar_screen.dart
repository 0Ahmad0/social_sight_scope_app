import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/const_value_manager.dart';

import '../../translations/locale_keys.g.dart';
import 'chats_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    ConstValueManager.navbarList = [
      NavbarItem(
        icon: Icons.home,
        label: tr(LocaleKeys.navbar_home_text),
        screen: HomeScreen(),
      ),
      NavbarItem(
        icon: Icons.search,
        label: tr(LocaleKeys.navbar_search_text),
        screen: SearchScreen(),
      ),
      NavbarItem(
        icon: Icons.person,
        label: tr(LocaleKeys.navbar_profile_text),
        screen: ProfileScreen(),
      ),
      NavbarItem(
        icon: Icons.chat_outlined,
        label: tr(LocaleKeys.navbar_chat_text),
        screen: ChatsScreen(),
      ),
    ];
    return Scaffold(
      body:ConstValueManager.navbarList[_currentIndex].screen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: ConstValueManager.navbarList
            .map(
              (e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
