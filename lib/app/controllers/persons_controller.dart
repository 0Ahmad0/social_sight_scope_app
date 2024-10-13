

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_sight_scope/app/controllers/profile_controller.dart';
import '../../core/models/person_model.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';


class PersonsController extends GetxController{

  final searchController = TextEditingController();
  PersonsModel persons=PersonsModel(items: []);
  PersonsModel personsWithFilter=PersonsModel(items: []);
  var getPersons;
  String? uid;
  @override
  void onInit() {
    ProfileController profileController=Get.put(ProfileController());
    uid= profileController.currentUser.value?.uid;
    searchController.clear();
    getLessonsFun();
    super.onInit();
    }

  getLessonsFun() async {
    getPersons =_fetchPersonsStream();
    return getPersons;
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // deleteLesson(context,{required String? idLesson}) async{
  //   var result;
  //    Get.dialog(DialogWidget(
  //        title: 'حذف الدرس',
  //    text: 'هل أنت متأكد أنك تريد حذف الدرس؟',
  //        onPressed:() async {
  //          Get.back();
  //          ConstantsWidgets.showLoading();
  //          result=await FirebaseFun
  //              .deleteLesson(idLesson: idLesson??'',);
  //          Get.back();
  //          ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
  //
  //          update();
  //        }
  //    ));
  //
  //   return result;
  //
  // }
  _fetchPersonsStream() {
    final result= FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionPerson)
        .where('idUser',isEqualTo: uid)
        .snapshots();
    return result;
  }
  filterPersons({required String term}) async {
    personsWithFilter.items=[];
    persons.items.forEach((element) {

      if((element.name?.toLowerCase().contains(term.toLowerCase())??false))
        personsWithFilter.items.add(element);
    });
     update();
  }

}
