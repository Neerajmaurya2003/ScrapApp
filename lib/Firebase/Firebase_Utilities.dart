// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning/Common%20Services/customer_login.dart';
import 'package:learning/Enterprise%20Services/EnterpriseHomePage.dart';
import 'package:learning/Enterprise%20Services/EnterpriseInfo.dart';
import 'package:learning/User%20Services/UserNavScreen.dart';
import 'package:learning/User%20Services/UserInfoPage.dart';
import 'package:learning/Common%20Services/Uihelper.dart';

class Firebase {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void removeAllPages(
      {required BuildContext context, required String collection}) {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => collection == "Household"
                ? userNavScreen(collection: collection)
                : EnterpriseHomePage(collection: collection)));
  }

  Future<Map<String, dynamic>?> UserInfo(
      {required BuildContext context,
      required String collection,
      required String Uid}) async {
    Map<String, dynamic> ans;
    var snapShot = await db.collection(collection).doc(Uid).get();
    if (snapShot.exists) {
      ans = snapShot.data()!;
      return ans;
    } else {
      print("Data does not exist");
      signoutUser(context);
      return null;
    }
  }

  login(
      {required String collection,
      required String email,
      required String password,
      required BuildContext context}) async {
    if (email == "" && password == "") {
      return Uihelper.MyCustomdialogueBox(context, "Enter email and password");
    } else {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) =>
                removeAllPages(context: context, collection: collection));
      } on FirebaseAuthException catch (ex) {
        return Uihelper.MyCustomdialogueBox(context, ex.code.toString());
      }
    }
  }

  signup(
      {required BuildContext context,
      required String email,
      required String password,
      required String whouser}) async {
    if (email == "" && password == "") {
      return Uihelper.MyCustomdialogueBox(context, "Enter Email and Password");
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        final user = usercredential.user;
        if (user != null) {
          String Uid = user.uid;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => whouser == "Household"
                      ? userInfoPage(
                          Uid: Uid,
                          collection: whouser,
                        )
                      : EnterpriseInfoPage(
                          Uid: Uid,
                          collection: whouser,
                        )));
        }
      } on FirebaseAuthException catch (ex) {
        return Uihelper.MyCustomdialogueBox(context, ex.code.toString());
      }
    }
  }

  checklogin(
      {required BuildContext context,
      required String email,
      required String password}) async {
    if (email == "" && password == "") {
      return Uihelper.MyCustomdialogueBox(context, "Enter Email and Password");
    } else {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) => forgetpassword(context: context, email: email))
            .then((value) => signoutUser(context));
      } on FirebaseAuthException catch (ex) {
        return Uihelper.MyCustomdialogueBox(context, ex.code.toString());
      }
    }
  }

  forgetpassword({required BuildContext context, required String email}) async {
    if (email == "") {
      return Uihelper.MyCustomdialogueBox(
          context, "Enter Email to Reset password");
    } else {
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  signoutUser(BuildContext context) async {
    FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage())));
  }

  deletePickup(
      {required String Uid,
      required BuildContext context,
      required String category,
      required String docname}) async {
    try {
      await db
          .collection("ScheduledPickup")
          .doc(Uid)
          .collection(category)
          .doc(docname)
          .delete();
      return true;
    } on FirebaseException catch (e) {
      return Uihelper.MyCustomdialogueBox(context, e.message.toString());
    }
  }

  schedulePickup({
    required String Uid,
    required BuildContext context,
    required Map<String, dynamic> pickupdata,
  }) async {
    if (pickupdata.isEmpty) {
      return Uihelper.MyCustomdialogueBox(context, "Pickup Can't be sheduled");
    } else {
      String date =
          pickupdata["Time Slot"] + pickupdata["Date of Pickup"].toString();
      try {
        await db
            .collection("ScheduledPickup")
            .doc(Uid)
            .collection(pickupdata["Category"])
            .doc(date)
            .set(pickupdata);
        return true;
      } on FirebaseException catch (ex) {
        return Uihelper.MyCustomdialogueBox(context, ex.message.toString());
      }
    }
  }

  UserData(
      {required BuildContext context,
      required String collection,
      required String Uid,
      required Map<String, dynamic> UserData}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    if (UserData.isEmpty) {
      return Uihelper.MyCustomdialogueBox(context, "Enter data ");
    } else {
      try {
        await db.collection(collection).doc(Uid).set(UserData).then((value) =>
            removeAllPages(context: context, collection: collection));
      } on (FirebaseException,) catch (e) {
        return Uihelper.MyCustomdialogueBox(context, e.toString());
      }
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSchedulePickupData(
      {required String Uid}) async {
    var querySnapshot = await db
        .collection("ScheduledPickup")
        .doc(Uid)
        .collection("Sell")
        .get();
    return querySnapshot;
  }

  Future<List<Map<String, dynamic>>> getScrapData() async {
    var querySnapshot = await db.collection("ScrapItems").get();
    List<Map<String, dynamic>> ans = [];
    for (var doc in querySnapshot.docs) {
      ans.add(doc.data());
    }
    return ans;
  }
}
