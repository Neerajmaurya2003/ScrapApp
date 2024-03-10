import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import 'package:learning/Notification%20services/notification_services.dart';
import 'package:learning/Common%20Services/customer_login.dart';

class userHomepage extends StatefulWidget {
  final String collection;
  const userHomepage({super.key,required this.collection});

  @override
  State<userHomepage> createState() => _userHomepageState();
}

class _userHomepageState extends State<userHomepage> {
  var myIconList=[Icon(Icons.map),Icon(Icons.fire_truck),Icon(Icons.add),Icon(Icons.add_a_photo),Icon(Icons.map),Icon(Icons.fire_truck),Icon(Icons.add),Icon(Icons.add_a_photo),];
  var Username;
  late final data;
  final Uid = FirebaseAuth.instance.currentUser!.uid;
  var temp;
  NotificationServices notificationServices=NotificationServices();

  logout()async{
    FirebaseAuth.instance.signOut().then((value) =>
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage())));
  }

  @override
  void initState() {
    _getData();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.onTokenRefresh(); 
    notificationServices.getDeviceToken().then((value) => {
      print("Device token is:"),
      print(value),
    });
    super.initState();
  }
  

    void _getData() async {
    data = await Firebase().UserInfo(Uid: Uid,collection: widget.collection);
    temp=data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log out"),
              onTap: (){
                logout();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:const Text("HomePage"),
      ),
      body:Container(
        child:temp!=null
        ?
         SingleChildScrollView(
           child: Column(
             children: [
               Padding(
                 padding: const EdgeInsets.only(top: 30.0,bottom: 30,right: 20,left: 10),
                 child: RichText(
                   textAlign: TextAlign.start,
                   text:TextSpan(children: [
                     TextSpan(
                       text: "Hello, ",
                       style: TextStyle(fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.black)
                     ),
                     TextSpan(
                       text: temp["Name"],
                       style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.black26)
                     ),
                     TextSpan(
                       text: "\n\nWhat you want to sell Today?",
                       style: TextStyle(fontSize: 20,color: Colors.black,fontStyle: FontStyle.italic)
                     )
                   ]) ,),
               ),
              Container(
               width: double.infinity,
               height: 200,
                child: Card(
                 elevation: 5,
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: GridView.count(
                     mainAxisSpacing: 10,
                     crossAxisSpacing: 10,
                     crossAxisCount: 4,
                     children: myIconList.map((e) {
                       return Container(
                         height: 10,
                         width: 10,
                         decoration: BoxDecoration(
                           border: Border.all(
                             width: 1,
                             color: Colors.black
                           ),
                           borderRadius: BorderRadius.circular(5)
                         ),
                         child: IconButton(onPressed: (){}, icon: e)) ;
                     }).toList(),
         
                   ),
                 ),
                ),
              ),
               Container(
                 height: 250,
                 color: Colors.yellowAccent,
               )
             ],
           ),
         ):
     const Center(child: CircularProgressIndicator()),
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
          tabs:const [
            GButton(
        icon: Icons.home,
        text: 'Home',
            ),
             GButton(
        icon: Icons.heart_broken,
        text: 'Likes',
            ),
             GButton(
        icon: Icons.search,
        text: 'Search',
            ),
             GButton(
        icon: Icons.person,
        text: 'Profile',
            )
          ]
        ),
      ),
    ) ;
  }


}