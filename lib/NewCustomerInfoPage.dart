
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learning/HomePage.dart';
import 'package:learning/Uihelper.dart';

class NewCustomerInfoPage extends StatefulWidget {

final String Uid;

 const NewCustomerInfoPage({Key? key, required this.Uid}):super(key: key);


  @override
  State<NewCustomerInfoPage> createState() => _NewCustomerInfoPageState();
}

class _NewCustomerInfoPageState extends State<NewCustomerInfoPage> {
  var namecontroller=TextEditingController();
  var mobilenocontroller=TextEditingController();
  var addesscontroller=TextEditingController();
  bool? ishousehold=null;
  var homeiconcolor=Colors.grey;
  var enterpriseiconcolor=Colors.grey;
  var db = FirebaseFirestore.instance;
  Map<String,dynamic> UserInfo={};

UserData(Map<String,dynamic> UserData)async{
  if(UserData.isEmpty){
    return Uihelper.MyCustomdialogueBox(context, "Enter data ");
  }
  else{
    try{
  await db.collection(widget.Uid).doc(widget.Uid).set(UserData).then((value) => 
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomePage())));
    }
    on FirebaseException catch(e){
      return Uihelper.MyCustomdialogueBox(context, e.code.toString());
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:const Text("Fill Required Information"),
      ),
      body: SingleChildScrollView(
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
           const SizedBox(
              height: 20,
            ),
          const  Text("Category that best Describe You?",style: TextStyle(fontSize: 20),),

            Padding(
              padding: const EdgeInsets.only(top: 30.0,bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){
                          setState(() {
                            ishousehold=true;
                            homeiconcolor=Colors.teal;
                            if(enterpriseiconcolor==Colors.teal){
                              enterpriseiconcolor=Colors.grey;
                            }

                          });
                        },
                          icon: Icon(Icons.home_outlined,size: 100,color: homeiconcolor,)),
                      Text("HouseHold",style: TextStyle(fontSize: 15,color: homeiconcolor),),
                    ],
                  ),
                 const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){
                          setState(() {
                            ishousehold=false;
                            enterpriseiconcolor=Colors.teal;
                            if(homeiconcolor==Colors.teal){
                              homeiconcolor=Colors.grey;
                            }
                          });
                        },
                          icon: Icon(Icons.warehouse_outlined,size: 100,color:enterpriseiconcolor)),
                      Text("Enterprise",style: TextStyle(fontSize: 15,color:enterpriseiconcolor),)
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              width: double.infinity,
                child: Uihelper.MyCustomElevatedButton(() {
                  UserInfo["Name"]=namecontroller.text.toString();
                  UserInfo["Mobile no"]=mobilenocontroller.text.toString();
                  UserInfo["Address"]=addesscontroller.text.toString();
                  UserInfo["Ishousehold"]=ishousehold;
                  UserData(UserInfo);
                 }, "Submit"))
          ],
        ),
      ),
    );
  }
}

