import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_sight_scope/app/screens/home_screen.dart';
import 'package:social_sight_scope/app/screens/more_screen.dart';
import 'package:social_sight_scope/app/screens/profile_screen.dart';
import 'package:social_sight_scope/app/screens/search_screen.dart';
import 'package:social_sight_scope/core/utils/assets_manager.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

class ConstValueManager {
  /// Design Size
  static const double widthSize = 393.0;
  static const double heightSize = 852.0;

  static const int animationDuration = 600;

  /// Duration Delayed Second
  static const int delayedSplash = 3;

  /// Button Size
  static const double heightButtonSize = 56;

  /// Length  Appointments TabBar
  static const int lengthAppointmentsTabBar = 3;

  /// Locale Language Code

  static const String arLanguageCode = 'ar';
  static const String enLanguageCode = 'en';

  static List<LocalLanguageModel> languageList = [
    LocalLanguageModel(
        text: 'العربية',
        languageCode: arLanguageCode,
        icon: AssetsManager.arFlagIcon),
    LocalLanguageModel(
        text: 'English',
        languageCode: enLanguageCode,
        icon: AssetsManager.enFlagIcon),
  ];
  static List<NavbarItem> navbarList = [
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
      icon: Icons.more_horiz,
      label: tr(LocaleKeys.navbar_more_text),
      screen: MoreScreen(),
    ),
  ];
}

class NavbarItem {
  final IconData icon;
  final String label;
  final Widget screen;

  NavbarItem(
      {required this.icon,
      required this.label,
      required this.screen});
}

class LocalLanguageModel {
  final String text;
  final String languageCode;
  final String icon;

  LocalLanguageModel(
      {required this.text, required this.languageCode, required this.icon});
}
