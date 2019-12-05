import 'dart:convert';

import 'package:demo_app/helpers/DatabaseHelper.dart';
import 'package:demo_app/model/nwservice.dart';


Data responseFromJson(String jsonString) {

  final jsonData = json.decode(jsonString);
  print('jsonData : $jsonData');

  return Data.fromJson(jsonData);
}

//Future<void> _insert() async {
////{userId: 1, id: 1, title: sunt aut facere repellat providenrit, body: quia et suscipit
//  Map<String,dynamic> row={
//    DatabaseHelper.columnId:'Mahesh',
//    DatabaseHelper.columnName  : 23,
//    DatabaseHelper.columnBody  : 23,
//
//  };
//  final id =await dbHelper.insert(row);
//  print('inserted row id: $id');
//}


class Data {
  int userId;
  int id;
  String title;
  String body;

  Data({
    this.userId,
    this.id,
    this.title,
    this.body,
  });


  factory Data.fromJson(Map<String, dynamic> json) => new Data(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );
}