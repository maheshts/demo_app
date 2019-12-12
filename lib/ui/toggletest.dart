import 'package:flutter/material.dart';

class ToggleTest extends StatefulWidget {
  @override
  _ToggleTestState createState() => _ToggleTestState();
}

class _ToggleTestState extends State<ToggleTest> {
  final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];
  @override
  Widget build(BuildContext context) {
    return new Material(


     // padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
     // height: MediaQuery.of(context).size.height * 0.35,
      child:Container(
         padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
         height: MediaQuery.of(context).size.height * 0.25,
      color: Colors.green,
      child:/*ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          //var post = numbers[index];

          return ListTile(
            //title: Text(numbers),
            subtitle: Text('My new post'),
            onTap: () => onTapped(),
          );
        },
        itemCount: numbers.length,
      ),*/


      ListView.builder(
          scrollDirection: Axis.horizontal,

          itemCount: numbers.length, itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Card(
            color: Colors.blue,

            child:ListTile(
              //title: Text(numbers),
              subtitle: Text('My new post'),
              onTap: () => onTapped(),
            ), /*Container(
              child: Center(child: Text(numbers[index].toString(), style: TextStyle(color: Colors.white, fontSize: 36.0),)),
            ),*/
          ),
          /*ListTile(
            //title: Text(numbers),
            subtitle: Text('My new post'),
            onTap: () => onTapped(),
          ),*/
        );
      }),
      ),
    );
  }

  void onTapped() {
    // navigate to the next screen.
  }
}
