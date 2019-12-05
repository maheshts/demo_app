import 'dart:convert';

import 'package:demo_app/helpers/DatabaseHelper.dart';
import 'package:demo_app/model/nwservice.dart';


ListData responseFromJson(String jsonString) {

  final jsonData = json.decode(jsonString);
  print('jsonData : $jsonData');

  return ListData.fromJson(jsonData);
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


class ListData {
  int userId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  ListData({
    this.userId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });


  factory ListData.fromJson(Map<String, dynamic> json) => new ListData(
    userId: json["albumId"],
    id: json["id"],
    title: json["title"],
    url: json["url"],
    thumbnailUrl: json["thumbnailUrl"],
  );



  Map<String, dynamic> toMap() => {
    "albumId": userId == null ? null : userId,
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "url": url == null ? null : url,
    "thumbnailUrl": thumbnailUrl == null ? null : thumbnailUrl,

  };
}