import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import 'package:learning/Notification%20services/notification_services.dart';
import 'package:learning/customer_login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    data = await Firebase().User_data(Uid);
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
         Stack(
          children: [
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
            ),
            Positioned(
              left: 30,
              right: 30,
              bottom: 0,
              child: Container(
                height: 150,
                width: 300,
                child: Stack(
                  children:[
                   Center(
                     child: Container(
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.tealAccent,
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(onPressed: (){}, icon: Icon(Icons.currency_rupee),),
                            IconButton(onPressed: (){}, icon: Icon(Icons.sell))
                          ],
                        ),
                      ),
                      ),
                   ),
                    Center(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            width: 2
                          )
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.teal.shade200,
                          child: IconButton(onPressed: (){},icon: Icon(Icons.add),iconSize: 50,),
                        ),
                      ),
                    ),
                 ]
                ),
              ),
            ),
          ]
        ):
     const Center(child: CircularProgressIndicator()),
      ),
    ) ;
  }


}