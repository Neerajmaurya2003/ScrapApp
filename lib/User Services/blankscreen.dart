import 'package:flutter/material.dart';

class BlankScreen extends StatelessWidget {

  const BlankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset("assets/images/2.png",),
           SizedBox(
            height: 20,
           ),
           Text("\"This Page is Under Development",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: Colors.black45),),
           Text("Due to Exams\"",style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: Colors.black45),)
          ],
        ),
       ),
    );
  }
}