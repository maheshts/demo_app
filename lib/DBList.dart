import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:demo_app/datalist.dart';
import 'package:demo_app/model/listdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'helpers/ListDatabaseHelper.dart';

class DBDataList extends StatefulWidget {
  @override
  _DBDataListState createState() => _DBDataListState();
}

class _DBDataListState extends State<DBDataList> {

  bool _isButtonClicked = false;
  var _buttonIcon = Icons.cloud_download;
  var _buttonText = "Retrive Data";
  var _buttonColor = Colors.green;
  final Connectivity _connectivity = new Connectivity();
  StreamSubscription<ConnectivityResult> _connectionSubscription;

  final dbHelper = ListDatabaseHelper.instance;

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text(
            'Fetching data from DB',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          // margin: EdgeInsets.only(right: 48),
        ),
      ),

      body: FutureBuilder<List<ListData>>(
        //future: dbHelper.getUserModelData(),
        future: getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data
                .map((user) =>
                ListTile(
                  title: Text(user.title),
                  subtitle: Text(user.thumbnailUrl),
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,

                  ),
                ))
                .toList(),
          );



        },
      ),
    );
  }

  Future<List<ListData>> getData() async {
    print('inside get Data');
    check().then((intenet) {
      if (intenet != null && intenet) {
        // Internet Present Case
       // print('YES DBLIST t $dbHelper.getUserModelData()');


        return getUserData();
        //return NWService().getDemoResponse();
      } else {
        print('No Net DBLIST');
        return dbHelper.getUserModelData();
      }
    });
  }


  Future<List<ListData>> getUserData() async {
    final response =
    await http.get("https://jsonplaceholder.typicode.com/photos");
    if (response.statusCode == 200) {
      //list = json.decode(response.body) as List;
      List<ListData> list = ListData.fromJson(json.decode(response.body)) as List;
      final result = json.decode(response.body);
      print('result from server: $result');

     // print('length $list.length');

     /* List<ListData> list = result.map((item) {
        //print('item in DB:  $item');

        return ListData.fromJson(item);
      }).toList();*/

      return list;
    }
  }

}

