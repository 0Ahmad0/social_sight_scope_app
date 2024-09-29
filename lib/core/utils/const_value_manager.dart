import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_sight_scope/app/screens/home_screen.dart';
import 'package:social_sight_scope/app/screens/chats_screen.dart';
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

  static const String geminiApi = "AIzaSyCDePmxP17rWSPSa_o-420-53dpMxYyZa8";

  /// Button Size
  static const double heightButtonSize = 56;

  /// Length  Appointments TabBar
  static const int lengthAppointmentsTabBar = 3;

  /// Locale Language Code

  static const String arLanguageCode = 'ar';
  static const String enLanguageCode = 'en';

  ///Social Media icons
  static List<SocialMediaModel> socialMediaList = [
    SocialMediaModel(
        icon: AssetsManager.whatsappIcon,
        name: tr(LocaleKeys.contactUs_whatsapp_text)),
    SocialMediaModel(
        icon: AssetsManager.linkedinIcon,
        name: tr(LocaleKeys.contactUs_linkedin_text)),
    SocialMediaModel(
        icon: AssetsManager.facebookIcon,
        name: tr(LocaleKeys.contactUs_facebook_text)),
    SocialMediaModel(
        icon: AssetsManager.xIcon, name: tr(LocaleKeys.contactUs_x_text)),
    SocialMediaModel(
        icon: AssetsManager.instagramIcon,
        name: tr(LocaleKeys.contactUs_instagram_text)),
    SocialMediaModel(
        icon: AssetsManager.telegramIcon,
        name: tr(LocaleKeys.contactUs_telegram_text)),
  ];
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

  ];
}

class NavbarItem {
  final IconData icon;
  final String label;
  final Widget screen;

  NavbarItem({required this.icon, required this.label, required this.screen});
}

class LocalLanguageModel {
  final String text;
  final String languageCode;
  final String icon;

  LocalLanguageModel(
      {required this.text, required this.languageCode, required this.icon});
}

class SocialMediaModel {
  final String icon;
  final String? launchText;
  final String name;

  SocialMediaModel({
    required this.icon,
    required this.name,
    this.launchText,
  });
}
