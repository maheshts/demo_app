

import 'dart:async';

import 'package:demo_app/Bloc/bloc.dart';
import 'package:demo_app/DataLayer/location.dart';

class LocationBloc extends Bloc{

 Location _location;

 Location get selectedLocation => _location;

 final _locationController = StreamController<Location>();

 Stream<Location> get locationStream => _locationController.stream;

 // 3
 void selectLocation(Location location) {
   _location = location;
   _locationController.sink.add(location);
 }



  @override
  void dispose() {
    // TODO: implement dispose
    _locationController.close();
  }

}