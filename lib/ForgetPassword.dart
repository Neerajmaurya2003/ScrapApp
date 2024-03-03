import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning/Uihelper.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController passwordcontroller=TextEditingController();

  checklogin(String email,String password)async{
    if(email=="" && password==""){
      return Uihelper.MyCustomdialogueBox(context, "Enter Email and Password");
    }
    else{
      UserCredential? usercredential;
      try{
        usercredential= await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => forgetpassword(email)).then((value) =>signoutUser());
      }
      on FirebaseAuthException catch(ex){
        return Uihelper.MyCustomdialogueBox(context, ex.code.toString());
      }
    }
  }

  forgetpassword(String email)async{
    if(email==""){
      return Uihelper.MyCustomdialogueBox(context, "Enter Email to Reset password");
    }
    else{
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      }
  }
  signoutUser()async{
     FirebaseAuth.instance.signOut();
  }

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
              forgetpassword(emailcontroller.text.toString());
            }, "Reset Password"),
          ],
        ),
      ),
    );
  }
}
