
import 'package:demo_app/helpers/ListDatabaseHelper.dart';
import 'package:demo_app/model/listdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sqflite/sqflite.dart';

import 'DBList.dart';

class DataList extends StatefulWidget {
  @override
  _DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList> {
  List list = List();
  var isLoading = false;
  final dbHelper = ListDatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fetch Data JSON"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child:new Row(
            children: <Widget>[
              RaisedButton(
                child: new Text("Fetch Data"),
                onPressed: _fetchData,
              ),
              RaisedButton(
                child: new Text("DB Data"),
                onPressed: _dbData,
              ),
            ],
          ) 
        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: new Text(list[index]['title']),
                trailing: new Image.network(
                  list[index]['thumbnailUrl'],
                  fit: BoxFit.cover,
                  height: 40.0,
                  width: 40.0,
                ),
              );
            }));
  }

  _fetchData() async {


    setState(() {
      isLoading = true;
    });
    final response =
    await http.get("https://jsonplaceholder.typicode.com/photos");
    if (response.statusCode == 200) {
      list = json.decode(response.body) as List;
      final result = json.decode(response.body);
      print('result from server: $result');
      _insert(result);
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }


  }
  
  _dbData(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DBDataList()),
    );
  }


  Future<void> _insert(result) async {
//{userId: 1, id: 1, title: sunt aut facere repellat providenrit, body: quia et suscipit
    Database db = await ListDatabaseHelper.instance.database;
    Batch batch = db.batch();
    list.forEach((val) {
      //assuming you have 'Cities' class defined
      ListData city = ListData.fromJson(val);
      batch.insert(ListDatabaseHelper.listTable, city.toMap());
    });

    batch.commit();
    //final id =await dbHelper.inserts(row);
    //print('inserted list row id: $id');
    _query();


  }


  void _query() async {
    final allRows = await dbHelper.queryRowCountData();
    print('query count rows:  $allRows');
    //allRows.forEach((row) => print(row));
  }

//  Future<void> allData() async {
//    final allRows = await dbHelper.getAllRecords()();
//    print('query count rows:  $allRows');
//  }
}



