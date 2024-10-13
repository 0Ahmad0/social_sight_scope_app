

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/models/person_model.dart';
import '../../core/widgets/constants_widgets.dart';
import 'profile_controller.dart';

import 'firebase/firebase_constants.dart';
import 'firebase/firebase_fun.dart';


class PersonController extends GetxController{
  final formKey = GlobalKey<FormState>();
  late TextEditingController nameController ;
  late TextEditingController emailController ;
  late TextEditingController phoneNumberController ;
  late TextEditingController descriptionController ;

  String? uid;
  PersonModel? person;

  @override
  void onInit() {
    person=Get.arguments?['person']??person;
    ProfileController profileController=Get.put(ProfileController());
    uid= profileController.currentUser.value?.uid;
    // uid= ProfileController.instance.currentUser.value?.uid;
    nameController=TextEditingController(text:person?.name );
    descriptionController=TextEditingController(text:person?.description );
    phoneNumberController=TextEditingController(text:person?.phoneNumber );
    emailController=TextEditingController(text:person?.email );
    super.onInit();
    }


  addPerson(context,{ XFile? image,bool withUserId=false}) async {
    ConstantsWidgets.showLoading();

    String name=nameController.value.text;
    String? imagePath;
    if(image!=null){
      imagePath=await FirebaseFun.uploadImage(image:image,folder: FirebaseConstants.collectionPerson+'/$name');
    }


    PersonModel personModel=PersonModel(
      id: name+'${Timestamp.now().microsecondsSinceEpoch}',
      name: name,
      description: descriptionController.value.text,
      imagePath: imagePath,
      dateTime: DateTime.now(),
     email:emailController.value.text ,
      phoneNumber: phoneNumberController.value.text,
      idUser: withUserId?uid:null
    );

    var
    result=await FirebaseFun.addPerson(person:personModel);

    ConstantsWidgets.closeDialog();
    if(result['status']){
      Get.back();
      Get.back();
    }

    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    return result;
  }
  updatePerson(context,{ XFile? image}) async {
    ConstantsWidgets.showLoading();

    String name=nameController.value.text;

    String? imagePath;
    if(image!=null){
      imagePath=await FirebaseFun.uploadImage(image:image,folder: FirebaseConstants.collectionPerson+'/$name');
    }

    person?.name=name;
    person?.description= descriptionController.value.text;
   person?.imagePath=imagePath??person?.imagePath;
    person?.phoneNumber=phoneNumberController.value.text;
    person?.email=emailController.value.text;
    var
    result=await FirebaseFun.updatePerson(person:person!);
    ConstantsWidgets.closeDialog();
    // if(result['status'])
    //   Get.back();
    ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
    return result;
  }



  // updateClassRoom(context,{required ClassRoomModel classRoom}) async {
  //   ConstantsWidgets.showLoading();
  //   var
  //   result=await FirebaseFun.updateClassRoom(classRoom:classRoom);
  //   Get.back();
  //   ConstantsWidgets.TOAST(context,textToast: FirebaseFun.findTextToast(result['message'].toString()),state: result['status']);
  //   return result;
  // }




  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }


}
