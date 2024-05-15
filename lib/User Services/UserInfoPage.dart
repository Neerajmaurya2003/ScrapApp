import 'package:flutter/material.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import 'package:learning/Common%20Services/Uihelper.dart';


class userInfo{
   String name;
   String address;
   String mobile;
   String collection;

  userInfo({
    required this.name,
    required this.address,
    required this.mobile,
    required this.collection});

    Map<String,Object?> toMap(){
      return {
        "Name":name,
        "Address":address,
        "Mobile":mobile,
        "collection":collection,
      };
    }

}

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
                    var UserInfo=userInfo(name: namecontroller.text.toString(), address: addesscontroller.text.toString(), mobile: mobilenocontroller.text.toString(), collection: widget.collection);
                      Firebase().UserData(Uid: widget.Uid,context: context,collection: widget.collection,UserData: UserInfo.toMap());
                   }, "Submit"))
            ],
          ),
        ),
      ),
    );
 
  }
}

