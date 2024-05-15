import 'package:flutter/material.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import 'package:learning/Common%20Services/Uihelper.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:const Text("Forget Password"),
      ),
      body: Container(
        margin:const EdgeInsets.only(left: 10,right: 10),
        height: 400,
        width: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Uihelper.MyCustomtextfield(emailcontroller, "Enter Email"),
            const SizedBox(
              height: 30,
            ),
            Uihelper.MyCustomElevatedButton(() {
              Firebase().forgetpassword(context: context,email: emailcontroller.text.toString());
            }, "Reset Password"),
          ],
        ),
      ),
    );
  }
}
