// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning/Enterprise%20Services/EnterpriseHomePage.dart';
import 'package:learning/Enterprise%20Services/EnterpriseInfo.dart';
import 'package:learning/User%20Services/userHomepage.dart';
import 'package:learning/User%20Services/UserInfoPage.dart';
import 'package:learning/Common%20Services/Uihelper.dart';

class Firebase{

  void removeAllPages({required BuildContext context,required String collection}){
    Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>collection=="Household"?userHomepage(collection: collection):EnterpriseHomePage(collection: collection)));
  }
  
 Future<Map<String, dynamic>?>  UserInfo({
   required String collection,
   required String Uid
 })async{
    final FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String,dynamic> ans;
    var snapShot = await db.collection(collection).doc(Uid).get();
    if(snapShot.exists){
      ans = snapShot.data()!;
      return ans;
    }else{
      print("Data does not exist");
      return null;
    }
}

login({
  required String collection,
  required String email,
  required String password,
  required BuildContext context})async{
     if(email=="" && password==""){
       return Uihelper.MyCustomdialogueBox(context, "Enter email and password");
     }
     else{
       try{
         await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => removeAllPages(context: context, collection: collection));
       }
       on FirebaseAuthException catch(ex){
         return Uihelper.MyCustomdialogueBox(context , ex.code.toString());
       }
     }
     
   }

   signup(
      {required BuildContext context,
      required String email,
      required String password,
      required String whouser})async{
    if(email=="" && password==""){
      return Uihelper.MyCustomdialogueBox(context, "Enter Email and Password");
    }
    else{
      UserCredential? usercredential;
      try{
        usercredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        final user=usercredential.user;
        if(user != null){

         String Uid=user.uid;
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>whouser=="Household"?userInfoPage(Uid: Uid,collection: whouser,):enterpriseInfo(Uid: Uid,collection: whouser,)));
        
        }
      }
      on FirebaseAuthException catch(ex){
        return Uihelper.MyCustomdialogueBox(context, ex.code.toString());
      }
    }
  }

    checklogin({
      required BuildContext context,
      required String email,
      required String password})async{
    if(email=="" && password==""){
      return Uihelper.MyCustomdialogueBox(context, "Enter Email and Password");
    }
    else{
      try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => forgetpassword(context: context,email: email)).then((value) =>signoutUser());
      }
      on FirebaseAuthException catch(ex){
        return Uihelper.MyCustomdialogueBox(context, ex.code.toString());
      }
    }
  }

   forgetpassword({
     required BuildContext context,
     required String email})async{
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

UserData(
      {
        required BuildContext context,
      required String collection,
      required String Uid,
      required Map<String, dynamic> UserData})async{
    var db = FirebaseFirestore.instance;
  if(UserData.isEmpty){
    return Uihelper.MyCustomdialogueBox(context, "Enter data ");
  }
  else{
    try{
  await db.collection(collection).doc(Uid).set(UserData).then((value) =>removeAllPages(context: context, collection: collection));
}
on(FirebaseException,)catch(e){
  return Uihelper.MyCustomdialogueBox(context, e.toString());
}
}
      }
}