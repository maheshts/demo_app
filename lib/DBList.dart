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
        future: dbHelper.getUserModelData(),
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


          /* Center(
        child: FutureBuilder<ListData>(
          ///If future is null then API will not be called as soon as the screen
          ///loads. This can be used to make this Future Builder dependent
          ///on a button click.
          //future: _isButtonClicked ? NWService().getDemoResponse() : null,
           future: _isButtonClicked ? getData():null,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {

            ///when the future is null
              case ConnectionState.none:
                return Text(
                  'Press the button to retrive data',
                  textAlign: TextAlign.center,
                );

              case ConnectionState.active:

              ///when data is being fetched
              case ConnectionState.waiting:
                return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue));

              case ConnectionState.done:
              ///task is complete with an error (eg. When you
              ///are offline)
                if (snapshot.hasError)
                  return Text(
                    'Error:\n\n${snapshot.error}',
                    textAlign: TextAlign.center,
                  );
                ///task is complete with some data
                return Text(
                  'Retrive Data:\n\n${snapshot.data.title}',
                  textAlign: TextAlign.center,
                );

            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _buttonColor,
        onPressed: () {
          ///Calling method to fetch data from the server
          //NWService().getDemoResponse();
          getData();

          ///You need to reset UI by calling setState.
          setState(() {
            _isButtonClicked == false
                ? _isButtonClicked = true
                : _isButtonClicked = false;

            if (!_isButtonClicked) {
              _buttonIcon = Icons.cloud_download;
              _buttonColor = Colors.green;
              _buttonText = "Fetch Data";
            } else {

              _buttonIcon = Icons.replay;
              _buttonColor = Colors.deepOrange;
              _buttonText = "Reset";
            }
          });
        },
        icon: Icon(
          _buttonIcon,
          color: Colors.white,
        ),
        label: Text(
          _buttonText,
          style: TextStyle(color: Colors.white),
        ),
      ),
*/
        },
      ),
    );
  }

  Future<ListData> getData() async {
    check().then((intenet) {
      if (intenet != null && intenet) {
        // Internet Present Case
        print('YES DBLIST t $dbHelper.getUserModelData()');
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
      List<ListData> list = ListData.fromJson(
          json.decode(response.body)) as List;
      final result = json.decode(response.body);
      print('result from server: $result');

//    List<ListData> list = result.map((item) {
//      //print('item in DB:  $item');
//
//      return ListData.fromJson(item);
//    }).toList();
//
//    print(result);
//    print('list $list');
      return list;
    }
  }

}

