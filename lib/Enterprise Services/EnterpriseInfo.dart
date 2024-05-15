
import 'package:flutter/material.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import '../Common Services/Uihelper.dart';

class EnterpriseInfo{
  String name;
  String mobile;
  String address;
  String gst;
  String collection;

  EnterpriseInfo({
    required this.name,
    required this.mobile,
    required this.address,
    required this.gst,
    required this.collection,
    });

    Map<String,Object?> toMap(){
      return{
        'Name':name,
        'Address':address,
        'Mobile no': mobile,
        'GST no': gst,
        'collection':collection,
      };
    }

}

class EnterpriseInfoPage extends StatefulWidget {
  final String Uid;
  final String collection;
  const EnterpriseInfoPage({super.key,required this.Uid,required this.collection});

  @override
  State<EnterpriseInfoPage> createState() => _EnterpriseInfoPageState();
}

class _EnterpriseInfoPageState extends State<EnterpriseInfoPage> {
  var namecontroller=TextEditingController();
  var mobilecontroller=TextEditingController();
  var addresscontroller=TextEditingController();
  var gstcontroller=TextEditingController();
  Map<String,dynamic> userInfo={};
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fill Enterprise Information"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
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
                  Text("Organisation Name",style: TextStyle(fontSize: 20),),
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
                  Text("Contact Number",style: TextStyle(fontSize: 20),),
                  Text("*",style: TextStyle(color: Colors.red,fontSize: 20),)
                ],
              ),
              Container(
                  color: Colors.teal.shade50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: mobilecontroller,
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
                    controller: addresscontroller,
                  )
              ),
              SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text("GST no.",style: TextStyle(fontSize:20),),
                  Text("*",style: TextStyle(fontSize: 20,color: Colors.red),)
                ],
              ),
              Container(
                  color: Colors.teal.shade50,
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: gstcontroller,
                  )
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height-530,
              ),

              SizedBox(
                  width: double.maxFinite,
                  child: Uihelper.MyCustomElevatedButton(()async {
                    EnterpriseInfo enterpriseInfo=EnterpriseInfo(name: namecontroller.text.toString(), mobile: mobilecontroller.text.toString(), address: addresscontroller.text.toString(), gst: gstcontroller.text.toString(), collection: widget.collection);
                    // userInfo["Organisation Name"]=namecontroller.text.toString();
                    // userInfo["Contact no"]=mobilecontroller.text.toString();
                    // userInfo["Address"]=addresscontroller.text.toString();
                    // userInfo["GST Number"]=gstcontroller.text.toString();
                    // if(userInfo["Organisation Nmae"]=="" || userInfo["Contact no"]=="" || userInfo["Address"]=="" || userInfo["GST Number"]==""){
                    //   return Uihelper.MyCustomdialogueBox(context, "Fill Required Info");
                    // }
                 
                      Firebase().UserData(context: context, collection: widget.collection, Uid: widget.Uid, UserData: enterpriseInfo.toMap());
                    
                  }, "Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
