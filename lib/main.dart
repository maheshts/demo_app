import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:demo_app/datalist.dart';
import 'package:demo_app/helpers/DatabaseHelper.dart';
import 'package:demo_app/model/data.dart';
import 'package:demo_app/model/nwservice.dart';
import 'package:demo_app/ui/GoogleMap.dart';
import 'package:demo_app/ui/MapDemo.dart';
import 'package:demo_app/ui/parking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Flutter Demo:'),
      home: ParkingForm(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _isButtonClicked = false;
  var _buttonIcon = Icons.cloud_download;
  var _buttonText = "Fetch Data";
  var _buttonColor = Colors.green;
  final Connectivity _connectivity  = new Connectivity();
  StreamSubscription<ConnectivityResult> _connectionSubscription;
  final dbHelper = DatabaseHelper.instance;

  List list = List();
  var isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectionSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      print('net $result');
    });
    print(dbHelper.getAllRecords());
    print('db data');
  }

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
  dispose() {
    super.dispose();

    _connectionSubscription.cancel();
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return  Scaffold(
      appBar: AppBar(
        title: Container(
          child: Center(
            child: Text(
              'Future Builder Widget',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  ),
          ),
         // margin: EdgeInsets.only(right: 48),
        ),
      ),
      ),

      body: Center(
        child: FutureBuilder<Data>(
          ///If future is null then API will not be called as soon as the screen
          ///loads. This can be used to make this Future Builder dependent
          ///on a button click.
          future: _isButtonClicked ? NWService().getDemoResponse() : null,
         // future: _isButtonClicked ? getData():null,
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
                  'Fetched Data:\n\n${snapshot.data.title}',
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

    );
  }



  Future<Data> getData() async {
    check().then((intenet) {
      if (intenet != null && intenet) {
        // Internet Present Case
        print('YES Net');
       return NWService().getDemoResponse();
      }else{
        print('No Net');
        //return dbHelper.getAllRecords();
      }
    });
  }



}
