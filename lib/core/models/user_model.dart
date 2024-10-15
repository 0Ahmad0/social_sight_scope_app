
import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

import '../../translations/locale_keys.g.dart';
import '../utils/app_constant.dart';

class UserModel {
  String? id;
  String? uid;
  String? name;
  String? userName;
  String? photoUrl;
  String? phoneNumber;
  String? email;
  String? password;
  String? typeUser;
  String? gender;
  String? status;
  DateTime? lastSeen;
  bool isAdd = false;

  bool get isAdmin=>typeUser?.toLowerCase().contains(AppConstants.collectionAdmin.toLowerCase())??false;

  UserModel({
    this.id,
    this.uid,
    this.name,
    this.userName,
    this.email,
    this.photoUrl,
    this.phoneNumber,
    this.password,
    this.typeUser,
    this.gender,
    this.status,
    this.lastSeen,
  });

  factory UserModel.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
    String name =
        data["name"] ?? '${data["firstName"] ?? ''} ${data["lastName"] ?? ''}';
    return UserModel(
      id: json['id'],
      uid: json["uid"],
      name: json["name"],
      // phoneNumber: json["phoneNumber"],
      // userName: json["userName"],
      email: json["email"],
      photoUrl: json["photoUrl"],
      typeUser: json["typeUser"],
      // gender: data["gender"],
       password:data['password'],
    status:data['status'],
      lastSeen: data["last_seen"]?.toDate(),
    );
  }
  String getStatus() {
    DateTime now = DateTime.now();

    // إذا كان المستخدم أونلاين وحالته الحالية "online" وكان آخر نشاطه قبل أقل من دقيقة
    if (status != 'offline' && lastSeen != null && now.difference(lastSeen!).inMinutes < 1) {
      return tr(LocaleKeys.chat_online);
    }

    // إذا كانت الحالة غير معروفة أو كان أكثر من دقيقة على آخر نشاط
     if (lastSeen == null) {
      return tr(LocaleKeys.chat_offline);
    }

    // التحقق إذا كان اليوم نفسه
    if (now.day == lastSeen!.day && now.month == lastSeen!.month && now.year == lastSeen!.year) {
      // إذا كان اليوم، أعد آخر ظهور مع الساعة والدقيقة فقط
      return tr(LocaleKeys.chat_last_seen_today_at)+' ${DateFormat.jm().format(lastSeen!)}';
      // return 'Last seen today at ${DateFormat.jm().format(lastSeen!)}';
      // return 'Last seen today at ${lastSeen!.hour}:${lastSeen!.minute.toString().padLeft(2, '0')}';
    } else {
      // إذا لم يكن اليوم، أعد التاريخ مع الساعة والدقيقة
      return tr(LocaleKeys.chat_last_seen_on)+' ${DateFormat.yMd().format(lastSeen!)} ${tr(LocaleKeys.chat_at)} ${DateFormat.jm().format(lastSeen!)}';
      // return 'Last seen on ${DateFormat.yMd().format(lastSeen!)} at ${DateFormat.jm().format(lastSeen!)}';
      // return 'Last seen on ${lastSeen!.day}/${lastSeen.month}/${lastSeen.year} at ${lastSeen.hour}:${lastSeen.minute.toString().padLeft(2, '0')}';
    }
  }


  factory UserModel.init() {
    return UserModel(
      id: "",
      uid: '',
      name: '',
      email: '',
      typeUser: '',
    //  password: ''
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'name': name,
        'email': email,
        // 'userName': userName,
        // 'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
        'typeUser': typeUser,
        // 'gender': gender,
    'password': password==null?null:BCrypt.hashpw(password!, BCrypt.gensalt()),
    // 'password': password,
    'status': status,
    'last_seen': lastSeen==null?null:Timestamp.fromDate(lastSeen!),
      };
  /// Function to check if the password matches the hashed password
  bool checkPassword(String plainPassword) {
    return BCrypt.checkpw(plainPassword, password??'');
  }
}

//users
class Users {
  List<UserModel> users;

  //DateTime date;

  Users({required this.users});

  factory Users.fromJson(json) {
    List<UserModel> tempUsers = [];

    for (int i = 0; i < json.length; i++) {
      UserModel tempUser = UserModel.fromJson(json[i]);
      tempUser.id = json[i].id;
      tempUsers.add(tempUser);
    }
    return Users(users: tempUsers);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> tempUsers = [];
    for (UserModel user in users) {
      tempUsers.add(user.toJson());
    }
    return {
      'users': tempUsers,
    };
  }
}
