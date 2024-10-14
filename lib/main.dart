import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:social_sight_scope/social_sight_scope_app.dart';

import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';
import 'core/utils/const_value_manager.dart';
import 'translations/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// To Init Firebase
  await Firebase.initializeApp();

  await GetStorage.init();
  ///Gemini.init(apiKey: ConstValueManager.geminiApi);

  await EasyLocalization.ensureInitialized();
  /// To Fix Bug In Text Showing In Release Mode
  await ScreenUtil.ensureScreenSize();

  runApp(
    EasyLocalization(
      child: SocialSightScopeApp(
        appRouter: AppRouter(),
      ),
      fallbackLocale: Locale(ConstValueManager.arLanguageCode),
      assetLoader: CodegenLoader(),
      supportedLocales: [
        Locale(ConstValueManager.arLanguageCode),
        Locale(ConstValueManager.enLanguageCode),
      ],
      path: 'assets/translations',
    ),
  );
}
