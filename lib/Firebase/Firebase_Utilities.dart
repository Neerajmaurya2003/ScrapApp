import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning/User%20Services/userHomepage.dart';
import 'package:learning/Common%20Services/NewCustomerInfoPage.dart';
import 'package:learning/Common%20Services/Uihelper.dart';

class Firebase{
  
 Future<Map<String, dynamic>?>  User_data(String Uid)async{
    final FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String,dynamic> ans;
    var snapShot = await db.collection(Uid).doc(Uid).get();
    if(snapShot.exists){
      ans = snapShot.data()!;
      return ans;
    }else{
      print("Data does not exist");
      return null;
    }
}

login(String email,String password,BuildContext context)async{
     if(email=="" && password==""){
       return Uihelper.MyCustomdialogueBox(context, "Enter email and password");
     }
     else{
       try{
         await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => 
         Navigator.pushReplacement(context , MaterialPageRoute(builder: (context)=>const userHomepage())));
       }
       on FirebaseAuthException catch(ex){
         return Uihelper.MyCustomdialogueBox(context , ex.code.toString());
       }
     }
     
   }

   signup(BuildContext context,String email,String password)async{
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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NewCustomerInfoPage(Uid: Uid,)));
        }
      }
      on FirebaseAuthException catch(ex){
        return Uihelper.MyCustomdialogueBox(context, ex.code.toString());
      }
    }
  }

    checklogin(BuildContext context,String email,String password)async{
    if(email=="" && password==""){
      return Uihelper.MyCustomdialogueBox(context, "Enter Email and Password");
    }
    else{
      try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) => forgetpassword(context,email)).then((value) =>signoutUser());
      }
      on FirebaseAuthException catch(ex){
        return Uihelper.MyCustomdialogueBox(context, ex.code.toString());
      }
    }
  }

   forgetpassword(BuildContext context,String email)async{
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

}