

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:social_sight_scope/app/controllers/profile_controller.dart';
import 'package:social_sight_scope/core/helpers/extensions.dart';
import 'package:social_sight_scope/core/models/chat_model.dart';
import 'package:social_sight_scope/core/models/user_model.dart';
import '../../core/helpers/launcher_helper.dart';
import '../../core/models/person_model.dart';
import '../../core/routing/routes.dart';
import '../../core/widgets/constants_widgets.dart';
import '../../translations/locale_keys.g.dart';
import 'chat_controller.dart';
import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';
import 'package:get/get_core/src/get_main.dart';

class PersonsController extends GetxController{

  final searchController = TextEditingController();
  PersonsModel persons=PersonsModel(items: []);
  PersonsModel personsWithFilter=PersonsModel(items: []);
  var getPersons;
  String? uid;
  String? email;
  @override
  void onInit() {
    ProfileController profileController=Get.put(ProfileController());
    uid= profileController.currentUser.value?.uid;
    email= profileController.currentUser.value?.email;
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
  connectionPerson(BuildContext context ,PersonModel person,int index) async {
    var result;
    ConstantsWidgets.showLoading();
    if(person.email==email){
      await LauncherHelper.launchWebsite(context,'https://wa.me/+966${person.phoneNumber?.replaceAll('+966', '')}');
      ConstantsWidgets.closeDialog();
    }
    else if(person.idChat!=null){
      ConstantsWidgets.closeDialog();
      context.pushNamed(Routes.sendMessageRoute,
          arguments: {
        "index":index.toString(),
        'chat':Chat(id:person.idChat??'',messages: [], listIdUser: [uid??'',person.uid??''], date: DateTime.now())
      }
    );

    }
    else{
      /// check email found  in user
      result=await FirebaseFun.fetchUserByEmail(email: person.email??'');
      if(result['status']&&result['body']!=null){
        UserModel user=UserModel.fromJson(result['body']);
        result = await Get.put(ChatController()).createChat(
            listIdUser: [uid??'', user.uid ?? '']);
        /// bind person with user
        if(result['status']){
          person.uid=user.uid;
          person.idChat=result['body']['id'];
          await FirebaseFun.updatePerson(person:person!);
        }

        //TODO dd notification
        // if(result['status'])
        //   context.read<NotificationProvider>().addNotification(context, notification: models.Notification(idUser: users[index].uid, subtitle: AppConstants.notificationSubTitleNewChat+' '+(profileProvider?.user?.firstName??''), dateTime: DateTime.now(), title: AppConstants.notificationTitleNewChat, message: ''));

        result =  await Get.put(ChatController()).fetchChatByListIdUser(
            listIdUser: [uid??'', user.uid ?? '']);

        if(result['status']){
        ConstantsWidgets.closeDialog();
          // if(result['status'])
          //    Get.to(ChatPage(), arguments: {'chat': controller.chat});
          context.pushNamed(Routes.sendMessageRoute, arguments: {
            'chat':Get.put(ChatController()).chat
          });
        }else{
          ConstantsWidgets.closeDialog();
          ConstantsWidgets.TOAST(null,
              textToast:  tr(LocaleKeys.message_error_try_again_later), state: false);
        }
      }
      else{
        await LauncherHelper.launchWebsite(context,'https://wa.me/+966${person.phoneNumber?.replaceAll('+966', '')}');
        ConstantsWidgets.closeDialog();
      }

    }

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
