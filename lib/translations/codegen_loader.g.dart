// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "ok": "نعم",
  "intro_text": "نقدم حلول مبتكرة تمكن المستخدمين من التفاعل بشكل أكثر اكتمالاً مع محيطهم",
  "get_started_text": "ابدأ",
  "app_language_text": "لغة التطبيق :",
  "login": {
    "welcome_back_text": "أهلا\nبعودتك",
    "login_text": "تسجيل الدخول",
    "email_text": "البريد الإلكتروني",
    "enter_email_text": "أدخل البريد الإلكتروني",
    "password_text": "كلمة المرور",
    "enter_password_text": "أدخل كلمة المرور",
    "forgot_password_text": "هل نسيت كلمة المرور ؟",
    "do_not_have_account_text": "لا تمتلك حساب بعد ؟ ",
    "signup_text": "إنشاء حساب"
  },
  "signup": {
    "create_new_account": "إنشاء\nحساب جديد",
    "create_account": "إنشاء حساب",
    "name_text": "الاسم",
    "enter_name_text": "أدخل الاسم",
    "email_text": "البريد الإلكتروني",
    "enter_email_text": "أدخل البريد الإلكتروني",
    "password_text": "كلمة المرور",
    "enter_password_text": "أدخل كلمة المرور",
    "confirm_password_text": "تأكيد كلمة المرور",
    "enter_confirm_password_text": "أدخل كلمة المرور مرة أخرى",
    "have_already_account_text": "تمتلك بالفعل حساب ؟ ",
    "login_text": "تسجيل الدخول"
  },
  "forgot_password": {
    "forgot_password_text": "نسيت كلمة المرور",
    "forgot_new_password_text": "نسيت\nكلمة المرور",
    "we_will_send_email_to_rest_password_text": "سنرسل إليك عبر البريد الإلكتروني رابطًا لإعادة تعيين كلمة مرورك",
    "enter_email_text": "أدخل عنوان البريد الإلكتروني المرتبط بحسابك",
    "enter_email_hint_text": "أدخل البريد الإلكتروني ",
    "send_text": "إرسال"
  },
  "navbar": {
    "home_text": "الرئيسية",
    "search_text": "البحث",
    "profile_text": "البروفايل",
    "more_text": "المزيد"
  },
  "search": {
    "search_text": "ابحث هنا..."
  },
  "home": {
    "welcome_text": "أهلاً ",
    "logout_text": "تسجيل الخروج",
    "recognize_face_text": "إضافة وجه جديد",
    "translate_language_text": "ترجمة اللغات",
    "display_real_time_text": "التحدث مع شات بوت",
    "analyze_emotion_text": "تحليل المشاعر"
  }
};
static const Map<String,dynamic> en = {
  "ok": "Ok",
  "intro_text": "We provide innovative solutions that enable users to interact more fully with their surroundings",
  "get_started_text": "Get Started",
  "app_language_text": "App Language :",
  "login": {
    "welcome_back_text": "Welcome\nBack",
    "login_text": "Login",
    "email_text": "Email",
    "enter_email_text": "Enter Email",
    "password_text": "Password",
    "enter_password_text": "Enter Password",
    "forgot_password_text": "Forgot Password ?",
    "do_not_have_account_text": "Don't Have Account ? ",
    "signup_text": "Sign Up"
  },
  "signup": {
    "create_new_account": "Create a new\nAccount",
    "create_account": "Create account",
    "name_text": "Name",
    "enter_name_text": "Enter name",
    "email_text": "Email",
    "enter_email_text": "Enter email",
    "password_text": "Password",
    "enter_password_text": "Enter password",
    "confirm_password_text": "Confirm password",
    "enter_confirm_password_text": "Enter password again",
    "have_already_account_text": "Already have an account ? ",
    "login_text": "Log in"
  },
  "forgot_password": {
    "forgot_password_text": "Forgot Password",
    "forgot_new_password_text": "Forgot\nPassword",
    "we_will_send_email_to_rest_password_text": "We will email you a link to reset your password",
    "enter_email_text": "Enter the email address associated with your account.",
    "enter_email_hint_text": "Enter the email",
    "send_text": "Send"
  },
  "navbar": {
    "home_text": "Home",
    "search_text": "Search",
    "profile_text": "Profile",
    "more_text": "More"
  },
  "search": {
    "search_text": "Search..."
  },
  "home": {
    "welcome_text": "Welcome ",
    "logout_text": "Log out",
    "recognize_face_text": "Recognize face",
    "translate_language_text": "Translate Language",
    "display_real_time_text": "Display Real Time",
    "analyze_emotion_text": "Analyze emotion"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
