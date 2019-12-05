import 'dart:convert';

import 'package:demo_app/helpers/DatabaseHelper.dart';
import 'package:demo_app/model/data.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';



class NWService{
  String url = 'https://jsonplaceholder.typicode.com/posts';
  String listurl = 'https://jsonplaceholder.typicode.com/photos';
  final dbHelper = DatabaseHelper.instance;

  Future<String> _loadRecordsAsset() async {
    return await rootBundle.loadString('assets/data/records.json');
  }



  Future<Data> getDemoResponse() async{

   // getData();

    final response = await http.get('$url/1');
    final result = json.decode(response.body);
    print('result : $result');
    //_insertDB(result);
    _insertDB(result);

    return responseFromJson(response.body);
  }




  Future<void> _insertDB(result) async {
//{userId: 1, id: 1, title: sunt aut facere repellat providenrit, body: quia et suscipit

    print('_insert : $result');
    Map<String,dynamic> row={
      DatabaseHelper.columnId: result['id'],
      DatabaseHelper.columnName  : result['title'],
      DatabaseHelper.columnBody  :  result['body'],

    };
    final id =await dbHelper.insert(row);
    print('inserted row id: $id');
      }


}