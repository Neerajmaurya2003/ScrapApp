import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learning/Common%20Services/CheckUser.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),(){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CheckUser()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to the ",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 60),),
            Text("Application",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 60,color:Colors.red ),)
          ],
        ),
      )
    );
  }
}
