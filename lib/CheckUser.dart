import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning/HomePage.dart';
import 'package:learning/main.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  Widget _Homepage=Container();
  @override
  void initState() {
    super.initState();
    checkuser();
  }
  checkuser()async{
    final user= FirebaseAuth.instance.currentUser;
    setState(() {
      _Homepage=user!=null?const HomePage():const StartingPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _Homepage;
  }

  }

