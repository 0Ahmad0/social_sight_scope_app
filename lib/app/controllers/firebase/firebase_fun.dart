import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/models/chat_model.dart';
import '../../../core/models/message_model.dart';
import '../../../core/models/person_model.dart';
import '../../../core/models/user_model.dart';
import '../../../core/utils/color_manager.dart';
import '../../../translations/locale_keys.g.dart';
import 'firebase_constants.dart';

class FirebaseFun {
  static FirebaseAuth auth = FirebaseAuth.instance;

  // static final database= FirebaseDatabase.instance.ref();

  // time for waiting request to done or show error message
  static Duration timeOut = Duration(seconds: 50);

  ///--Signup
  static Future<Map<String, dynamic>> signUp(
      {required String email, required String password}) {
    final result = auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(FirebaseHelperFun.onValueSignup)
        .catchError(FirebaseHelperFun.onError)
        .timeout(timeOut, onTimeout: FirebaseHelperFun.onTimeOut);
    return result;
  }



  static fetchUser( {required String uid,required String typeUser})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .where('uid',isEqualTo: uid)
        .get()
        .then((onValueFetchUser))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }

  static fetchUserByUserName( {required String userName})  async {
    final result=await FirebaseFirestore.instance.collection(FirebaseConstants.collectionUser)
        .where('userName',isEqualTo: userName)
        .get()
        .then((onValueFetchUserByUserName))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchUserByEmail( {required String email})  async {
    final result=await FirebaseFirestore.instance.collection(FirebaseConstants.collectionUser)
        .where('email',isEqualTo: email)
        .get()
        .then((onValueFetchUserByUserName))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchUserId( {required String id,required String typeUser})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .where('id',isEqualTo: id)
        .get()
        .then((onValueFetchUserId))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    //  print("${id} ${result}");
    return result;
  }
  static fetchUserUid( {required String uid,required String typeUser})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .where('uid',isEqualTo: uid)
        .get()
        .then((onValueFetchUserId))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }

  static fetchUserIndex( {required String index,required String typeUser})  async {
    final result=await FirebaseFirestore.instance.collection(typeUser)
        .doc(index)
        .get()
        .then((onValueFetchUserIndex))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }

  static fetchUsers()  async {
    final result=await FirebaseFirestore.instance.collection(FirebaseConstants.collectionUser)
        .get()
        .then((onValueFetchUsers))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }


  ///Person
  static addPerson( {required PersonModel person}) async {
    final result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionPerson)
        .doc(person.id)
        .set(person.toJson()).then(onValueAddPerson).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static deletePerson( {required String idLesson}) async {
    final result =await FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionPerson)
        .doc(idLesson)
        .delete().then(onValueDeleteLesson)
        .catchError(onError);
    return result;
  }
  static updatePerson( {required PersonModel person}) async {
    final result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionPerson).doc(
        person.id
    ).update(person.toJson()).then(onValueUpdatePerson).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchPersonsByIdUser({required String idUser})  async {
    final result=await FirebaseFirestore.instance.collection(FirebaseConstants.collectionPerson)
        .where('idUser',isEqualTo: idUser)
        .get()
        .then((onValueFetchPersons))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }



  ///Chat
  static addChat( {required Chat chat}) async {
    final result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionChat).add(
        chat.toJson()
    ).then(onValueAddChat).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static deleteChat( {required String idChat}) async {
    final result =await FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionChat)
        .doc(idChat)
        .delete().then(onValueDeleteChat)
        .catchError(onError);
    return result;
  }
  static updateChat( {required Chat chat}) async {
    final result= await FirebaseFirestore.instance.collection(FirebaseConstants.collectionChat).doc(
        chat.id
    ).update(chat.toJson()).then(onValueUpdateChat).catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchChatsByIdUser({required List listIdUser})  async {
    final result=await FirebaseFirestore.instance.collection(FirebaseConstants.collectionChat)
        .where('listIdUser',arrayContains: listIdUser)
        .get()
        .then((onValueFetchChats))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }
  static fetchChatsByListIdUser({required List listIdUser})  async {
    final database = await FirebaseFirestore.instance.collection(FirebaseConstants.collectionChat);
    Query<Map<String, dynamic>> ref = database;

    listIdUser.forEach( (val) => {
      ref = database.where('listIdUser' ,arrayContains: val)
    });
    final result=
    ref
        .get()
        .then((onValueFetchChats))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }

  static addMessage( {required Message message,required String idChat}) async {
    final result =await FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionChat)
        .doc(idChat)
        .collection(FirebaseConstants.collectionMessage).add(
        message.toJson()
    ).then(onValueAddMessage)
        .catchError(onError);
    return result;
  }
  static deleteMessage( {required Message message,required String idChat}) async {
    final result =await FirebaseFirestore.instance
        .collection(FirebaseConstants.collectionChat)
        .doc(idChat)
        .collection(FirebaseConstants.collectionMessage).doc(
        message.id
    ).delete().then(onValueDeleteMessage)
        .catchError(onError);
    return result;
  }
  static fetchLastMessage({required String idChat})  async {
    final result=await FirebaseFirestore.instance.collection(FirebaseConstants.collectionChat)
        .doc(idChat).collection(FirebaseConstants.collectionMessage).orderBy('sendingTime',descending: true).get()
        .then((onValueFetchLastMessage))
        .catchError(onError).timeout(timeOut,onTimeout: onTimeOut);
    return result;
  }





  static Future<Map<String,dynamic>>  onError(error) async {
    return {
      'status':false,
      'message':error,
      // 'body':null
    };
  }
  static Future<Map<String,dynamic>>  onTimeOut() async {
    return {
      'status':false,
      'message':'time out',
      //'body':""
    };
  }
  static Future<Map<String,dynamic>>  errorUser(String messageError) async {
    print(false);
    print(messageError);
    return {
      'status':false,
      'message':messageError,
      //'body':""
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUser(value) async{
    // print(true);
    print('uid ${await (value.docs.length>0)?value.docs[0]['uid']:null}');
    print("user : ${(value.docs.length>0)?UserModel.fromJson(value.docs[0]).toJson():null}");
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value.docs.length>0)?UserModel.fromJson(value.docs[0]).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUserByUserName(value) async{
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value.docs.length>0)?UserModel.fromJson(value.docs[0]).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUserId(value) async{
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value.docs.length>0)?UserModel.fromJson(value.docs[0]).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUserIndex(value) async{
    return {
      'status':true,
      'message':'Account successfully logged',
      'body':(value!=null)?UserModel.fromJson(value).toJson():null
    };
  }
  static Future<Map<String,dynamic>> onValueFetchUsers(value) async{
    print("Users count : ${value.docs.length}");

    return {
      'status':true,
      'message':'Users successfully fetch',
      'body':value.docs
    };
  }




  static Future<Map<String,dynamic>>onValueAddPerson(value) async{
    return {
      'status':true,
      'message':'Person successfully add',
      'body':{},//{'id':value.id}
    };
  }
  static Future<Map<String,dynamic>>onValueUpdatePerson(value) async{
    return {
      'status':true,
      'message':'Person successfully update',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchPersons(value) async{
    return {
      'status':true,
      'message':'Person successfully fetch',
      'body':value.docs
    };
  }
  static Future<Map<String,dynamic>>onValueDeleteLesson(value) async{
    return {
      'status':true,
      'message':'Person successfully delete',
      'body':{}
    };
  }


  static Future<Map<String,dynamic>>onValueAddChat(value) async{
    return {
      'status':true,
      'message':'Chat successfully add',
      'body':{'id':value.id}
    };
  }
  static Future<Map<String,dynamic>>onValueUpdateChat(value) async{
    return {
      'status':true,
      'message':'Chat successfully update',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchChats(value) async{
    return {
      'status':true,
      'message':'Chats successfully fetch',
      'body':value.docs
    };
  }
  static Future<Map<String,dynamic>>onValueAddMessage(value) async{
    return {
      'status':true,
      'message':'Message successfully add',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>>onValueDeleteChat(value) async{
    return {
      'status':true,
      'message':'Chat successfully delete',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>>onValueDeleteMessage(value) async{
    return {
      'status':true,
      'message':'Message successfully delete',
      'body':{}
    };
  }
  static Future<Map<String,dynamic>> onValueFetchLastMessage(value) async{
    return {
      'status':true,
      'message':'Last message successfully fetch',
      'body':value.docs
    };
  }






  static String findTextToast(String text){
    String errorMessage='';
    print("error:$text");
    switch(text.toLowerCase()){
      // login
      case "user-not-found":
        errorMessage = "No user found with this email.";
        // errorMessage = "لا يوجد مستخدم لهذا البريد.";
        errorMessage= tr(LocaleKeys.message_no_user_for_email);
        break;
      case "wrong-password":
        errorMessage = "Incorrect password.";
        // errorMessage = "كلمة السر غير صحيحة.";
        errorMessage= tr(LocaleKeys.message_incorrect_password);
        break;
      case "invalid-email":
        // errorMessage = "البريد الالكتروني البدخل غير صالح";
        errorMessage= tr(LocaleKeys.message_invalid_email);
        break;
      case "user-disabled":
        // errorMessage = "المستخدم غير مفعل.";
        errorMessage= tr(LocaleKeys.message_user_not_activated);
        break;
      case "too-many-requests":
        errorMessage =
        ".حاولت تسجيل الدخول مرات عديدة، حاول لاحقاً";
        errorMessage="Too many requests";
        errorMessage= tr(LocaleKeys.message_too_many_attempts);
        break;
      // register
      case "email-already-in-use":
        errorMessage = ".هذا البريد موجود مسبقاً";
        errorMessage="email already in use";
        errorMessage= tr(LocaleKeys.message_email_already_in_use);
        break;
      case "invalid-email":
        errorMessage = "البريد الالكتروني غير صالح.";
        errorMessage = "Invalid email";
        errorMessage= tr(LocaleKeys.message_invalid_email);
        break;
      case "weak-password":
        errorMessage = "Password is too weak. It must be at least 6 characters long, including at least one uppercase letter, one lowercase letter, and one digit.";
        // errorMessage = "كلمة المرور ضعيفة، يجب أن تحوي 6 محارف، وتتضمن حرف كبير وحرف صغير، وأيضا علامة ترقيم";
        errorMessage= tr(LocaleKeys.message_weak_password);
        break;
      case "invalid email":
        errorMessage = "البريد الالكتروني غير صالح.";
        errorMessage = "Invalid email";
        errorMessage= tr(LocaleKeys.message_invalid_email);
        break;
      case "invalid-credential":
        errorMessage = "المستخدم غير صحيح.";
        errorMessage = "Invalid credential";
        errorMessage= tr(LocaleKeys.message_incorrect_user);
        break;

      case "account successfully logged":
        errorMessage =
        "تم تسجيل الدخول بنجاح";
        errorMessage = "Account successfully logged";
        errorMessage= tr(LocaleKeys.message_successful_login);
        break;
      case "users successfully fetch":
        errorMessage =
        "تم جلب معلومات المستخدمين بنجاح";
        errorMessage = "Users successfully fetch";
        errorMessage= tr(LocaleKeys.message_users_fetched_successfully);
        break;
      case "person successfully add":
        errorMessage =
        "تمت إضافة شخص بنجاح";
        errorMessage= tr(LocaleKeys.message_face_added_successfully);
        break;
      case "person successfully update":
        errorMessage =
        "تم تحديث الدرس بنجاح";
        errorMessage= tr(LocaleKeys.message_face_updated_successfully);
        break;
      case "person successfully fetch":
        errorMessage =
        "تم جلب الدرس بنجاح";
        errorMessage= tr(LocaleKeys.message_face_fetched_successfully);
        break;
      case "account successfully created":
        errorMessage =
        "تم انشاء الحساب بنجاح";
        errorMessage= tr(LocaleKeys.message_account_created_successfully);
        break;
      case "Lesson successfully delete":
        errorMessage =
        "تم حذف الجلسة بنجاح";
        errorMessage= tr(LocaleKeys.message_session_deleted_successfully);
        break;
      case "person successfully delete":
        errorMessage =
        "";
        errorMessage= tr(LocaleKeys.message_person_deleted_successfully);
        break;
      case "":
        errorMessage =
        "";
        break;
      case "":
        errorMessage =
        "";
        break;
      default:
        errorMessage = "An unexpected error occurred. Please try again later.";
        errorMessage = "حصل خطأ، الرجاء المحاولة لاحقاً";
        errorMessage = text;
        errorMessage= tr(LocaleKeys.message_error_try_again_later);
    }
    print("error trans: $errorMessage");

    // if(text.contains("Password should be at least 6 characters")){
    //   return tr(LocaleKeys.toast_short_password);
    // }else if(text.contains("The email address is already in use by another account")){
    //   return tr(LocaleKeys.toast_email_already_use);
    // }
    // else if(text.contains("Account Unsuccessfully created")){
    //   return tr(LocaleKeys.toast_Unsuccessfully_created);
    // }
    // else if(text.contains("Account successfully created")){
    //    return tr(LocaleKeys.toast_successfully_created);
    // }
    // else if(text.contains("The password is invalid or the user does not have a password")){
    //    return tr(LocaleKeys.toast_password_invalid);
    // }
    // else if(text.contains("There is no user record corresponding to this identifier")){
    //    return tr(LocaleKeys.toast_email_invalid);
    // }
    // else if(text.contains("The email address is badly formatted")){
    //   return tr(LocaleKeys.toast_email_invalid);
    // }
    // else if(text.contains("Account successfully logged")){
    //     return tr(LocaleKeys.toast_successfully_logged);
    // }
    // else if(text.contains("A network error")){
    //    return tr(LocaleKeys.toast_network_error);
    // }
    // else if(text.contains("An internal error has occurred")){
    //   return tr(LocaleKeys.toast_network_error);
    // }else if(text.contains("field does not exist within the DocumentSnapshotPlatform")){
    //   return tr(LocaleKeys.toast_Bad_data_fetch);
    // }else if(text.contains("Given String is empty or null")){
    //   return tr(LocaleKeys.toast_given_empty);
    // }
    // else if(text.contains("time out")){
    //   return tr(LocaleKeys.toast_time_out);
    // }
    // else if(text.contains("Account successfully logged")){
    //   return tr(LocaleKeys.toast);
    // }
    // else if(text.contains("Account not Active")){
    //   return tr(LocaleKeys.toast_account_not_active);
    // }

    return errorMessage;
  }

  static Future uploadImage({required XFile image,  String folder='images'}) async {

    try{
      String path = image.name;
      File file =File(image.path);
      Reference storage = FirebaseStorage.instance.ref().child("${folder}/${path}");
      UploadTask storageUploadTask = storage.putFile(file);
      TaskSnapshot taskSnapshot = await storageUploadTask;
      String url = await taskSnapshot.ref.getDownloadURL();
      return url;
    }catch(e){
      String errorMessage;
      errorMessage = "An unexpected error occurred. Please try again later.";
      Get.back();
      Get.snackbar(
          "خطأ",
          errorMessage,
          backgroundColor: ColorManager.errorColor
      );
    }
  }

}

class FirebaseHelperFun {
  static Future<Map<String, dynamic>> onValueSignup(value) async {
    print(true);
    print("uid : ${value.user?.uid}");
    return {
      'status': true,
      'message': 'Account successfully created',
      'body': value.user
    };
  }

  static Future<Map<String, dynamic>> onTimeOut() async {
    print(false);
    return {
      'status': false,
      'message': 'time out',
      //'body':""
    };
  }

  static Future<Map<String, dynamic>> onError(error) async {
    print(false);
    print(error);
    var errorMessage;
    if (error is FirebaseAuthException) {
      errorMessage = error.message ?? "Firebase Authentication Error";
    } else if (error is FirebaseException) {
      errorMessage = error.message ?? "Firebase Error";
    } else {
      errorMessage = error;
    }

    return {
      'status': false,
      'message': errorMessage,
      //'body':""
    };
  }
}
