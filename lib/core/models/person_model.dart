import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class PersonModel {
  String? id;
  String? idUser;
  String? uid;
  String? name;
  String? email;
  String? description;
  String? phoneNumber;
  String? imagePath;
  DateTime? dateTime;




  PersonModel({
    this.id,
    this.name,
    this.description,
    this.email,
    this.phoneNumber,
    this.uid,
    this.imagePath,
    this.idUser,
    this.dateTime,
  });

  factory PersonModel.fromJson(json) {
    var data = json.runtimeType.toString()=='_JsonQueryDocumentSnapshot'?json.data():json;

    return PersonModel(
      id: json['id'],
      name: json["name"],
      description: json["description"],
      email: json["email"],
      imagePath: data["imagePath"],
      phoneNumber: json["phoneNumber"],
      uid: data["uid"],
      idUser: data["idUser"],
      dateTime: data["dateTime"]?.toDate(),
    );
  }

  factory PersonModel.init() {
    return PersonModel(
      id: "",
      name: '',
      dateTime: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
 return  {
      'id': id,
      'name': name,
      'description': description,
      'imagePath': imagePath,
      'email': email,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'idUser': idUser,
      'dateTime': dateTime==null?null:Timestamp.fromDate(dateTime!),
    };
  }
}

//PersonModel
class PersonsModel {
  List<PersonModel> items;

  PersonsModel({required this.items});

  factory PersonsModel.fromJson(json) {

    List<PersonModel> itemList = [];

    for (int i = 0; i < json.length; i++) {
      PersonModel temp = PersonModel.fromJson(json[i]);
      temp.id = json[i].id;
      itemList.add(temp);
    }
    return PersonsModel(items: itemList);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemList = [];
    for (PersonModel item in items) {
      itemList.add(item.toJson());
    }
    return {
      'items': itemList,
    };
  }
}
