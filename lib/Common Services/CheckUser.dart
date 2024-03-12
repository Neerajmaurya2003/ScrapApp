import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning/Enterprise%20Services/EnterpriseHomePage.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import 'package:learning/User%20Services/userHomepage.dart';
import 'package:learning/User%20Services/UserInfoPage.dart';
import 'package:learning/main.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  final user= FirebaseAuth.instance.currentUser;
  Widget _Homepage=Container(
    color: Colors.white,
     child:const Center(child: CircularProgressIndicator()));


  @override
  void initState() {
    super.initState();
    checkuser();
  }
  checkuser()async{
    if(user == null){
      _Homepage=const StartingPage();
    }
    else{
     String Uid= user!.uid;
  var data =await Firebase().UserInfo(collection: "Household",Uid: Uid);
    // ignore: prefer_const_constructors
    _Homepage=EnterpriseHomePage(collection: "Enterprise");

    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return _Homepage;
  }

  }

