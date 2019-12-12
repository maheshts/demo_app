
import 'package:flutter/material.dart';
import 'package:demo_app/design/design_course_app_theme.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';

class ParkingForm extends StatefulWidget {
  @override
  _ParkingFormState createState() => _ParkingFormState();
}

_ParkingFormState _globalState = new _ParkingFormState();

class _ParkingFormState extends State<ParkingForm> {
  double topBarOpacity = 0.0;
  List<bool> isSelected = [true, false, false];
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  bool pressAttention = false;

  Color color;
  bool changeColor = false;
  static const String mAvailableText = "Available 133";
  static const String mCapacityText = "Capacity 33";
  static const String mLocationText = "2.5 km from location";
  static const String mHeaderAddressText = "Lodha Supreme,Nehru marg,Mumbai";

  String mFromTime = "12.00";
  String mToTime = "12.30";
  String mCloseTime = "12.50";


  var todayDate;

  List vehicleDetails = [
    {"vehicle_name": "CAR", "image_url": "assets/images/bike.png"},
    {"vehicle_name": "BIKE", "image_url": "assets/images/map.jpeg"},
  ];

  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  var now = new DateTime.now();
  //print(now.millisecondsSinceEpoch);

  @override
  void initState() {
    super.initState();
    isSelected = [true, false, false];
    todayDate = now.day;
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    return Container(
      color: Colors.grey,
      //

      child: Scaffold(
        body:SingleChildScrollView(
          child:  Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 34),
          decoration: new BoxDecoration(
              color: DesignCourseAppTheme.notWhite,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(40.0),
                  topRight: const Radius.circular(40.0))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 12, right: 12, top: 24),
                  padding: EdgeInsets.only(
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    color: DesignCourseAppTheme.nearlyWhite,
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: DesignCourseAppTheme.grey.withOpacity(0.2),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Container(
                    //padding: ,
                    height: 50,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[
                        //FlutterLogo(),
                        Container(
                          height: 50,
                          width: 50,
                          child: Image.asset("assets/images/map.jpeg"),
                        ),

                        SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            mHeaderAddressText,
                            softWrap: true,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              letterSpacing: 0.17,
                              //color: DesignCourseAppTheme.darkerText,
                            ),
                          ),
                        ),

                        SizedBox(width: 10.0),
                        Container(
                          padding: EdgeInsets.only(bottom: 4),
                          child: Transform.rotate(
                            angle: -math.pi / 4,
                            child: Icon(Icons.send),
                          ),
                        )
                      ],
                    ),
                  ),
                ), //first part complete
                SizedBox(height: 8.0),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  //padding: EdgeInsets.only(left: 10,right: 10),
                  child: new Row(
                    //mainAxisSize: MainAxisSize.min,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Expanded(
                        child: Text(mLocationText,
                            maxLines: 1,
                            softWrap: false,
                            textAlign: TextAlign.start,
                            style: DesignCourseAppTheme.caption),
                      ),
                      SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          mCapacityText,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 0.15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          mAvailableText,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            letterSpacing: 0.15,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(
                  height: 5,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 15.0,
                ),
                new Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'PARKING TIME',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        letterSpacing: 0.17,
                        color: DesignCourseAppTheme.darkerText,
                      ),
                    ),
                  ),
                ),

                new Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10),
                  child: timeWidget(),
                ),
                new Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'PARKING DATE',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        letterSpacing: 0.27,
                        color: DesignCourseAppTheme.darkerText,
                      ),
                    ),
                  ),
                ),

                Column(
                  children: <Widget>[
                    SizedBox(
                        //height: MediaQuery.of(context).padding.top,
                        height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new Material(
                          child: SizedBox(
                            height: 48,
                            width: 68,
                            child: InkWell(
                              highlightColor: Colors.grey,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              onTap: () {},
                              child: Center(
                                child: Icon(
                                  Icons.keyboard_arrow_left,
                                  // color: DesignCourseAppTheme.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 48,
                          width: screenWidth - 200,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 18,
                              right: 8,
                            ),
                            child: Row(
                              children: <Widget>[
                                new Text("Today is " + formatDate(),
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(fontSize: 16.0)),
                              ],
                            ),
                          ),
                        ),
                        new Material(
                          child: SizedBox(
                            height: 48,
                            width: 68,
                            child: InkWell(

                              highlightColor: Colors.grey,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8.0)),
                              onTap: () {},
                              child: Center(
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  // color: DesignCourseAppTheme.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                new Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'VEHICLE TYPE',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        letterSpacing: 0.27,
                        color: DesignCourseAppTheme.darkerText,
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                new Row(
                  children: <Widget>[
                    Container(
                      //padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                      margin: EdgeInsets.only(left: 10, right: 5),
                      height: 150,
                      width: screenWidth - 130,

                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: vehicleDetails.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 105,
                              child: Card(
                                child: InkWell(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: _selectedIndex != null &&
                                                _selectedIndex == index
                                            ? DesignCourseAppTheme.grey
                                                .withOpacity(0.1)
                                            : Colors.white,
                                        //borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.white,
                                              //offset: const Offset(1.1, 1.1),
                                              blurRadius: 16.0),
                                        ],
                                      ),
                                      child: Center(
                                        child: Stack(
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                //Image.asset(vehicleDetails[index]['image_url'],
                                                Image.asset(
                                                    "assets/images/bike.png",
                                                    height: 50,
                                                    fit: BoxFit.fill),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(vehicleDetails[index]
                                                    ['vehicle_name']),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                      // Center(child: Text(numbers[index].toString(), style: TextStyle(color: Colors.white, fontSize: 16.0),)),
                                      ),
                                  onTap: () {
                                    setState(() {
                                      _onSelected(index);
                                    });
                                  },
                                ),
                              ),
                            );
                          }),
                    ),
                    _buildRight(),
                  ],
                ),
              ]),
        ),
        ),
//
      ),
    );
  }
}

formatDate() {
  //return (DateTime.now().day +1).toString() ;
  var now = new DateTime.now();
  var now1 = new DateFormat.MMMMd("en_US");
  //var ss = now.m;
  return (DateTime.now().day).toString();
}

Widget timeWidget() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const SizedBox(
        height: 6,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getTimeBoxUI('From ', _globalState.mFromTime, 'am'),
          getTimeBoxUI(' To', _globalState.mToTime, 'pm'),
          getTimeBoxUI('Closes at ', _globalState.mCloseTime, 'pm'),
        ],
      ),
      const SizedBox(
        height: 6,
      ),
    ],
  );
}

Widget _buildRight() {
  return Container(
    child: new Container(
      padding: new EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.amber,
        // borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.white,
              offset: const Offset(1.1, 1.1),
              blurRadius: 16.0),
        ],
      ),
      width: 95,
      height: 140,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //Image.asset(vehicleDetails[index]['image_url'],
              new Icon(Icons.navigate_next, size: 30.0),
              SizedBox(
                height: 1,
              ),
              Text('Next'),
            ],
          ),
        ],
      ),
    ),
  );
}

void onTapped() {
  // navigate to the next screen.
}

Widget getTimeBoxUI(String text1, String txt2, String txt3) {
  return Container(
    height: 75,
    width: 80,
    decoration: BoxDecoration(
      color: DesignCourseAppTheme.nearlyWhite,
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: DesignCourseAppTheme.grey.withOpacity(0.2),
            offset: const Offset(1.1, 1.1),
            blurRadius: 16.0),
      ],
    ),
    child: Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            text1,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 10,
              letterSpacing: 0.17,
              color: DesignCourseAppTheme.grey,
            ),
          ),
          Text(
            txt2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w200,
              fontSize: 14,
              letterSpacing: 0.17,
              color: DesignCourseAppTheme.nearlyBlack,
            ),
          ),
          Text(
            txt3,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10,
              letterSpacing: 0.17,
              color: DesignCourseAppTheme.dark_grey,
            ),
          ),
        ],
      ),
    ),
  );
}
