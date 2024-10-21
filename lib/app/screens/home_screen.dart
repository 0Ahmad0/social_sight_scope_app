import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/routing/routes.dart';
import 'package:social_sight_scope/core/utils/assets_manager.dart';
import 'package:social_sight_scope/core/utils/color_manager.dart';
import 'package:social_sight_scope/core/utils/const_value_manager.dart';
import 'package:social_sight_scope/core/utils/string_manager.dart';
import 'package:social_sight_scope/core/utils/style_manager.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../../core/models/person_model.dart';
import '../../core/widgets/constants_widgets.dart';
import '../controllers/home_persons_controller.dart';
import '../controllers/persons_controller.dart';
import '../widgets/app_drawer_widget.dart';
import '../widgets/empty_widget.dart';
import '../widgets/home_user_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = -1;
  late HomePersonsController controller;
  void initState() {
    controller = Get.put(HomePersonsController());
    controller.onInit();
    super.initState();
  }
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
      body:   StreamBuilder<QuerySnapshot>(
          stream: controller.getPersons,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return    ConstantsWidgets.circularProgress();
            } else if (snapshot.connectionState ==
                ConnectionState.active) {
              if (snapshot.hasError) {
                return  Text(tr(LocaleKeys.error));
              } else if (snapshot.hasData) {
                ConstantsWidgets.circularProgress();
                controller.persons.items.clear();
                if (snapshot.data!.docs.length > 0) {
                  controller.persons.items =
                      PersonsModel.fromJson(snapshot.data!.docs).items;
                }
                controller.filterPersons(term: controller.searchController.value.text);
                return
                  GetBuilder<HomePersonsController>(
                      builder: (HomePersonsController HomePersonsController)=>
                      (HomePersonsController.personsWithFilter.items.isEmpty ?? true)
                          ?Center(
                        child: TextButton.icon(
                            onPressed: (){
                              context.pushNamed(
                                  Routes.addNewPersonRoute
                              );
                            },
                            icon: Icon(Icons.add),
                            label: Text(
                                tr(LocaleKeys.add_person)
                            )
                        ),
                      )
                      // EmptyWidget(
                      //     text: tr(LocaleKeys.home_no_faces_available))
                          // text: StringManager.infoNotFacesYet)
                          :

                      buildPersons(context, controller.personsWithFilter.items ?? []));
              } else {
                return  Text( tr(LocaleKeys.empty_data));
                // return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          }),
    );
  }
  Widget buildPersons(BuildContext context,List<PersonModel> items){
    return
      StatefulBuilder(builder: (context, homeSetState) {
        return GridView.builder(
            itemCount:items.length,
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
              person: items[index],
              index: index,
              currentIndex: _currentIndex,
            ),
          ),
        );
      });

  }
}


