import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';


class MapDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container();
  }
  //GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();
  //GoogleMapController mapController;


  /*openMapsSheet(context) async {
    try {
      final title = "Shanghai Tower";
      final description = "Asia's tallest building";
      final coords = Coords(31.233568, 121.505504);
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () =>
                            map.showMarker(
                              coords: coords,
                              title: title,
                              description: description,
                            ),
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }



    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Map Launcher Demo'),
          ),
          body: Center(child: Builder(
            builder: (context) {
              return MaterialButton(
                onPressed: () => openMapsSheet(context),
                child: Text('Show Maps'),
              );
            },
          )),
        ),
      );
    }*/
  }
