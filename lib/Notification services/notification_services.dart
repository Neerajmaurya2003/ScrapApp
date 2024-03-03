import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestNotificationPermission()async{
    NotificationSettings settings;
    if(Platform.isAndroid){
     settings=await messaging.requestPermission(
      alert: true,
      announcement: true,
      sound: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
    );
    }
    else if(Platform.isIOS || Platform.isMacOS || Platform.isWindows){
      settings=await messaging.requestPermission(
        provisional: true,
        announcement: true,
      );
    }
    else{
      print("Platform not supported");
      return ;
    }
    switch(settings.authorizationStatus){
      case AuthorizationStatus.authorized:
      print("User granted permission");
      break;
      case AuthorizationStatus.provisional:
      print("user granted provisionally");
      break;
      case AuthorizationStatus.denied:
      print("user denied the permission");
      break;
      default:
      print("Default Option");
    } 
  }
 
  void firebaseInit(){
    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification!.title.toString());
      print(event.notification!.body.toString());
    });
  } 

 Future<String> getDeviceToken()async{
  String? token=await messaging.getToken();
  return token!;
 }

 void onTokenRefresh()async{
  messaging.onTokenRefresh.listen((event) {
    event.toString();
    print("refresh");
  });
 }
}