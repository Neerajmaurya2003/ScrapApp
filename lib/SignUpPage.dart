import 'package:flutter/material.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import 'package:learning/Uihelper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  var confirmpasswordcontroller=TextEditingController();
  bool isobsecure=true;

      
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:const Text("New User"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                width: 380,
                height: 450,
                child: Card(
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2,
                                color: Colors.black
                            )
                        ),
                        child: Icon(Icons.lock,size: 50,),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Container(

                          child: Uihelper.MyCustomtextfield(emailcontroller, "Enter Username or Email"),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Container(

                          child: TextField(
                            controller: passwordcontroller,
                            obscureText: isobsecure,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                                labelText: "Enter Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(
                                      width: 2,
                                    )
                                ),
                                enabledBorder: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.teal,
                                    ),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                disabledBorder:OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.black54,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye,color: Colors.black,),
                                  onPressed: (){
                                    if(isobsecure==true){
                                      isobsecure=false;
                                    }
                                    else{
                                      isobsecure=true;
                                    }
                                    setState((){});
                                  },
                                )

                            ),

                          ),
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Uihelper.MyCustomObsecureTextfield(confirmpasswordcontroller, "Confirm Password", true),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      ElevatedButton(
                        onPressed: (){
                          if(passwordcontroller.text.toString()==confirmpasswordcontroller.text.toString() && passwordcontroller.text.toString()!=""){
                            Firebase().signup(context,emailcontroller.text.toString(), passwordcontroller.text.toString());
                          }
                          else{
                            Uihelper.MyCustomdialogueBox(context, "Password doesn't match");
                          }
                        },
                        child: Text("Submit"),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );

  }
}
