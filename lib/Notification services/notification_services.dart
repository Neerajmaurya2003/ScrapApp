import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices{
  FirebaseMessaging messaging = FirebaseMessaging.instance;
 final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

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
 
void initLocationNotifications(BuildContext context,RemoteMessage message)async{

      var androidInitializationSettings=const AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosInitializationSettings =const  DarwinInitializationSettings();
     
      var initializationSettings= InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings
      ) ;

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (payload){

        }
        );

}

  void firebaseInit(){
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }
      showNotification(message);

    });
  } 

  Future<void> showNotification(RemoteMessage message)async{

    AndroidNotificationChannel channel= AndroidNotificationChannel(
      Random.secure().nextInt(10000).toString(),
      'Hign Importance Notification', 
      importance: Importance.max  
          );

    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "Your channel description",
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker'
       );

      const DarwinNotificationDetails darwinNotificationDetails=DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,

       );

       NotificationDetails notificationDetails=NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails
       );


    Future.delayed(Duration.zero,(){
      _flutterLocalNotificationsPlugin.show(
      0,
       message.notification!.title.toString(),
        message.notification!.body.toString(),
         notificationDetails );
    }
    );
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