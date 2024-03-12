import 'package:flutter/material.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import 'package:learning/Common%20Services/Uihelper.dart';

class userInfoPage extends StatefulWidget {

final String Uid;
final String collection;

 const userInfoPage({super.key, required this.Uid,required this.collection});


  @override
  State<userInfoPage> createState() => _userInfoPageState();
}

class _userInfoPageState extends State<userInfoPage> {

  var namecontroller=TextEditingController();
  var mobilenocontroller=TextEditingController();
  var addesscontroller=TextEditingController();
  Map<String,dynamic> UserInfo={};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:const Text("Fill Required Information"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
             const Row(
                children: [
                  Text("Name",style: TextStyle(fontSize: 20),),
                  Text("*",style: TextStyle(color: Colors.red,fontSize: 20),)
                ],
              ),
              Container(
                color: Colors.teal.shade50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: namecontroller,
                  )
              ),
              const SizedBox(height: 30,),
             const Row(
                children: [
                  Text("Mobile Number",style: TextStyle(fontSize: 20),),
                  Text("*",style: TextStyle(color: Colors.red,fontSize: 20),)
                ],
              ),
              Container(
                color: Colors.teal.shade50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: mobilenocontroller,
                    decoration:const InputDecoration(
                      prefix: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text("+91"),
                      )
                    ),
                  )
              ),
             const SizedBox(
                height: 20,
              ),
             const Row(
                children: [
                  Text("Address With Pin code",style: TextStyle(fontSize: 20),),
                  Text("*",style: TextStyle(color: Colors.red,fontSize: 20),)
                ],
              ),
              Container(
                  color: Colors.teal.shade50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: addesscontroller,
                  )
              ),
          
              SizedBox(
                height: MediaQuery.of(context).size.height-450,
              ),
          
              SizedBox(
                width: double.infinity,
                  child: Uihelper.MyCustomElevatedButton(()async {
                    UserInfo["Name"]=namecontroller.text.toString();
                    UserInfo["Mobile no"]=mobilenocontroller.text.toString();
                    UserInfo["Address"]=addesscontroller.text.toString();
                    if(UserInfo["Name"]=="" || UserInfo["Mobile no"]=="" || UserInfo["Address"]==""){
                      return Uihelper.MyCustomdialogueBox(context, "Enter Required Fields");
                    }
                    else{
                      Firebase().UserData(Uid: widget.Uid,context: context,collection: widget.collection,UserData: UserInfo);
                    }
                   }, "Submit"))
            ],
          ),
        ),
      ),
    );
 
  }
}

