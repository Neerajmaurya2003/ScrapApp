import 'package:flutter/material.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import 'package:learning/Uihelper.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Forget Password"),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10,right: 10),
        height: 400,
        width: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Uihelper.MyCustomtextfield(emailcontroller, "Enter Email"),
            SizedBox(
              height: 30,
            ),
            Uihelper.MyCustomtextfield(passwordcontroller, "Enter Old Password"),
            SizedBox(
              height: 30,
            ),
            Uihelper.MyCustomElevatedButton(() {
              Firebase().forgetpassword(context, emailcontroller.text.toString());
            }, "Reset Password"),
          ],
        ),
      ),
    );
  }
}
