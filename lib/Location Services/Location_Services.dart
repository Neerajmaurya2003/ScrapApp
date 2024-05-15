import 'package:location/location.dart';

class LocationService{
  Location location= Location();
  LocationData? locationData;

  LocationPermission()async{
    var hasPermission=await location.hasPermission();
    if(hasPermission != PermissionStatus.granted){
      var permissionStatus=await location.requestPermission();
      if(permissionStatus != PermissionStatus.granted){
        return null;
      }
    }
  }
}

