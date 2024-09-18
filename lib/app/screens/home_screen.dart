import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_sight_scope/core/utils/assets_manager.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/const_value_manager.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../widgets/app_drawer_widget.dart';
import '../widgets/home_user_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawerWidget(),
      appBar: AppBar(
        title: Text(tr(LocaleKeys.navbar_home_text)),
        actions: [
          Image.asset(
            AssetsManager.logoIMG,
            fit: BoxFit.cover,
          )
        ],
      ),
      body: StatefulBuilder(builder: (context, homeSetState) {
        return GridView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 12.h
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w
          ),
          itemBuilder: (context, index) => InkWell(
            borderRadius: BorderRadius.circular(14.r),
            onTap: () {
              homeSetState(() {
                _currentIndex = index;
              });
            },
            child: HomeUserWidget(
              index: index,
              currentIndex: _currentIndex,
            ),
          ),
        );
      }),
    );
  }
}


