import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';


class myMap extends StatefulWidget {
   const myMap({super.key});

  @override
  State<myMap> createState() => _myMapState();
}

class _myMapState extends State<myMap> {
    Location location= Location();
    double? latitude;
    double? longitude;
  LocationData? locationData;

  @override
  void initState(){
    super.initState();
    LocationInIt();
  }

  LocationInIt()async{
    LocationData locationData=await location.getLocation();
    latitude=locationData.latitude;
    longitude=locationData.longitude;
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:latitude!=null?FlutterMap(options: MapOptions(
      initialCenter: LatLng(latitude!,longitude!)
    ), 
    mapController: MapController(),
    children: [
        TileLayer(
               urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
               userAgentPackageName: 'com.example.learning',
                    ),
        MarkerLayer(markers: [
          Marker(
            point: LatLng(latitude! , longitude! ), 
            child:const Icon(Icons.location_on,color: Colors.red,))
        ])
                    ]):const Center(child: CircularProgressIndicator())
                    );
  }
}