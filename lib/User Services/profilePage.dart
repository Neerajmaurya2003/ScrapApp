import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';

class UserProfilePage extends StatefulWidget {
  final dynamic data;
  const UserProfilePage({super.key,required this.data});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
 var data;
 TextStyle style= TextStyle(fontSize: 20,);
  void initState() {
    _getdata();
    super.initState();
  }

  _getdata()async{
    data=await widget.data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:data!=null? SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 270,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors:[
                            Colors.teal.shade700,
                            Colors.teal.shade200
                          ] )
                    ),
                    // color: Colors.teal.shade400,
                  ),
                ),
                Positioned(
                  top: 115,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(75)),
                      border: Border.all(
                        width: 5,
                        color: Colors.white,
                      )
                    ),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.teal.shade100,
                      child: FaIcon(FontAwesomeIcons.user,color: Colors.black,),
                    ),
                  ),
                ),
                Positioned(
                  right: 2,
                    top: 10,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.settings,size: 30,))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,bottom: 10),
              child: Text(data["Name"],style: TextStyle(fontSize: 30),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,),
              child: Text(" ${data["Address"]}",style: TextStyle(fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,bottom: 20),
              child: Text("Contact Number - +91-${data["Mobile"]}",style: TextStyle(fontSize: 20),),
            ),

            const Expanded(
              child:SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0,left: 30,right: 30),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(onPressed: (){Firebase().signoutUser(context);}, child:const Text("Log out!"))),
            )
          ],
        ),
      ):const Center(child: CircularProgressIndicator()),
    );
  }
}