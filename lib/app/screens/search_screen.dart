import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:social_sight_scope/core/widgets/app_padding.dart';
import 'package:social_sight_scope/translations/locale_keys.g.dart';

import '../../core/models/person_model.dart';
import '../../core/utils/string_manager.dart';
import '../../core/widgets/constants_widgets.dart';
import '../controllers/persons_controller.dart';
import '../widgets/empty_widget.dart';
import '../widgets/search_user_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  late PersonsController controller;

  @override
  void initState() {
    controller = Get.put(PersonsController());
    controller.onInit();
    super.initState();
    _searchController.addListener(() {
      setState(() {}); // Update the UI when the text changes
    });
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.navbar_search_text)),
      ),
      body: AppPaddingWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(

              // controller: _searchController,
              controller: controller.searchController,
              onChanged: (_)=>controller.filterPersons(term: controller.searchController.value.text),

              decoration: InputDecoration(
                hintText: tr(LocaleKeys.search_search_text),
                suffixIcon: _searchController.value.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                        },
                        icon: Icon(Icons.highlight_remove),
                      )
                    : null,
                prefixIcon: IconButton(
                  onPressed: () {
                    // Handle search icon press
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(child:

            StreamBuilder<QuerySnapshot>(
                stream: controller.getPersons,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return    ConstantsWidgets.circularProgress();
                  } else if (snapshot.connectionState ==
                      ConnectionState.active) {
                    if (snapshot.hasError) {
                      return  Text(tr(LocaleKeys.empty_data));
                    } else if (snapshot.hasData) {
                      ConstantsWidgets.circularProgress();
                      controller.persons.items.clear();

                      if (snapshot.data!.docs.length > 0) {
                        controller.persons.items =
                            PersonsModel.fromJson(snapshot.data!.docs).items;
                      }
                      controller.filterPersons(term: controller.searchController.value.text);
                      return
                        GetBuilder<PersonsController>(
                            builder: (PersonsController HomePersonsController)=>
                            (HomePersonsController.personsWithFilter.items.isEmpty ?? true)
                                ? EmptyWidget(
                                text: tr(LocaleKeys.home_no_faces_available))
                                // text: StringManager.infoNotFacesYet)
                                :

                            buildPersons(context, controller.personsWithFilter.items ?? []));
                    } else {
                      return  Text(tr(LocaleKeys.empty_data));
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                })
            )

          ],
        ),
      ),
    );
  }
  Widget buildPersons(BuildContext context,List<PersonModel> items){
    return
      ListView.separated(
        itemCount: items.length,
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 12.h),
        separatorBuilder: (context, index) => SizedBox(height: 12.h), // لتحديد المسافة بين العناصر
        itemBuilder: (context, index) => SearchUserWidget( // استخدم الويجيت الجديدة ListTile
          person: items[index],
          index: index,
          // currentIndex: 0,
        ),
      );

  }
}
