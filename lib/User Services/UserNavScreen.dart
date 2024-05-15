import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import 'package:learning/Location%20Services/Location_Services.dart';
import 'package:learning/Notification%20services/notification_services.dart';
import 'package:learning/User%20Services/profilePage.dart';
import 'package:learning/User%20Services/schedulePickupPage.dart';
import 'package:learning/User%20Services/userHomepage.dart';
import 'package:learning/User%20Services/userSearchpage.dart';

class userNavScreen extends StatefulWidget {
  final String collection;
  const userNavScreen({super.key,required this.collection});

  @override
  State<userNavScreen> createState() => _userNavScreenState();
}

class _userNavScreenState extends State<userNavScreen>{
  int selectedIndex=0;
   static  late List<Widget> _widgetOptions;
   final Uid = FirebaseAuth.instance.currentUser!.uid;
  NotificationServices notificationServices=NotificationServices();
  var data;
  final List<String> _titleOptions=["HomePage","Schedule A PickUp","Search","User Profile"];
  List<Map<String,dynamic>> scrapData = [];
  late QuerySnapshot<Map<String,dynamic>> schedulePickupData ;
  List<Map<String,dynamic>> scheduledPickups=[];

  @override
  void initState() {
    super.initState();
    _getData();
    notificationServices.requestNotificationPermission();
    LocationService().LocationPermission();
    notificationServices.firebaseInit();
    notificationServices.onTokenRefresh();
    notificationServices.getDeviceToken();
  }


    void _getData() async {
    data = await Firebase().UserInfo(context:context,Uid: Uid,collection: widget.collection);
    scrapData=await Firebase().getScrapData();
    schedulePickupData=await Firebase().getSchedulePickupData(Uid: Uid);
    if(schedulePickupData!=null){
      for(var pickupdata in schedulePickupData.docs){
        scheduledPickups.add(pickupdata.data());
      }
      for(var temp in scheduledPickups){
        var time=temp["Date of Pickup"].toDate();
        temp["Date of Pickup"]=time;
        temp["Date of applying"]=temp["Date of applying"].toDate();
      }
      print(scheduledPickups);
    }
    setState(() {
    _widgetOptions=<Widget>[
      userHomepage(collection: widget.collection,data: data,scheduledPickups: scheduledPickups,Uid: Uid,),
      SchedulePickuppage(scrapData: scrapData,Uid: Uid,selectedIndex: selectedIndex,scheduledPickups: scheduledPickups,),
      UserSearchPage(scrapData: scrapData,Uid: Uid,),
      UserProfilePage(data: data,),
    ];
    });
  }

  void addScrapData({required Map<String,dynamic> scrap}){
    setState(() {
      scheduledPickups.add(scrap);
      selectedIndex=1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return data !=null?Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Padding(
          padding:const EdgeInsets.only(left: 40.0),
          child: Text(_titleOptions.elementAt(selectedIndex),
        ),
      ),
      ),
      body: Center(
        child:_widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 7,top: 7),
        child: GNav(
            rippleColor: Colors.grey[800]!,
            hoverColor: Colors.grey[700]!,
            haptic: true,
            tabBorderRadius: 15,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            tabBorder: Border.all(color: Colors.grey, width: 1),
            curve: Curves.easeOutExpo,
            duration:const Duration(milliseconds: 200),
            gap: 8,
            color: Colors.grey[800],
            activeColor: Colors.teal,
            iconSize: 24,
            tabBackgroundColor: Colors.teal.withOpacity(0.1),
            padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tabs: const [
               GButton(
                icon: Icons.home,
                text: 'Home',
              ),
               GButton(
                icon: Icons.fire_truck_sharp,
                text: 'Pickup',
              ),
               GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              )
            ],
          selectedIndex: selectedIndex,
          onTabChange: (index){
              setState(() {
                selectedIndex=index;
              });
          },
        ),
      ),
    ):Center(child: const CircularProgressIndicator());
  }
}
