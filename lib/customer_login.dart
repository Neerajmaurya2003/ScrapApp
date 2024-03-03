import 'package:flutter/material.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import 'package:learning/ForgetPassword.dart';
import 'package:learning/SignUpPage.dart';


class LoginPage extends StatelessWidget {
   LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:const Text("Already Have an Account"),) ,
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 380) {
              // Display a wide layout
              return WideUserLogin();
            } else {
              // Display a narrow layout
              return NarrowLayoutDesign();
            }
          },
        )

      ),
    );
  }
}

class WideUserLogin extends StatefulWidget {
  const WideUserLogin({super.key});

  @override
  State<WideUserLogin> createState() => _WideUserLoginState();
}

class _WideUserLoginState extends State<WideUserLogin> {
  var emailcontroller=TextEditingController();
  var Passwordcontroller=TextEditingController();
  bool isobsecure=true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 40,
          ),
          Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                height: 350,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.black38,
                                  width: 2
                              )
                          ),
                          child:const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            child: Icon(Icons.face),
                          )
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                    Container(
                      child: TextField(
                        controller:emailcontroller,
                        decoration: InputDecoration(
                            labelText: "User Name or Phone Number ",
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.teal
                                ),
                                borderRadius: BorderRadius.circular(11)
                            ),
                            enabledBorder : OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(11)
                            )
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                    ),
                    Container(
                      child: TextField(
                        controller:Passwordcontroller,
                        obscureText: isobsecure,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            labelText: "Enter Passwordcontrollerword",
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                ),
                                borderRadius: BorderRadius.circular(11)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.solid

                                ),
                                borderRadius: BorderRadius.circular(11)
                            ),
                            disabledBorder:OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black54,
                                    style: BorderStyle.solid
                                ),
                                borderRadius: BorderRadius.circular(11)
                            ),
                            suffixIcon: IconButton(
                              icon:isobsecure==true? Icon(Icons.visibility,color: Colors.black):Icon(Icons.visibility_off,color: Colors.black,),
                              onPressed: (){
                                setState(() {
                                  if(isobsecure==true){
                                    isobsecure=false;
                                  }
                                  else{
                                    isobsecure=true;
                                  }
                                });
                              },
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child:Center(
                          child: ElevatedButton(
                            child: Text("submit"),
                            onPressed:(){
                              Firebase().login(emailcontroller.text.toString(), Passwordcontroller.text.toString(),context);
                            },
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            child: Text("Forget Passwordcontrollerword",style: TextStyle(color:Colors.blue),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: (){
                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=>New_Customer()));
                            },
                            child: Container(
                              child: Text("New User",style: TextStyle(color: Colors.blue),),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Narrow layout design
class NarrowLayoutDesign extends StatefulWidget {
  const NarrowLayoutDesign({super.key});

  @override
  State<NarrowLayoutDesign> createState() => _NarrowLayoutDesignState();
}

class _NarrowLayoutDesignState extends State<NarrowLayoutDesign> {
  var emailcontroller = TextEditingController();
  var Passwordcontroller =TextEditingController();
  bool isobsecure=true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
          ),
          Container(
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
                    padding: const EdgeInsets.only(left:10.0,right: 10.0),
                    child: Container(

                        child: TextField(
                          controller: emailcontroller,
                          decoration: InputDecoration(
                            labelText: "Enter Username or Email",
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
                          ),
                        ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                    child: Container(

                        child: TextField(
                          controller: Passwordcontroller,
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
                                icon: isobsecure==true? Icon(Icons.visibility,color: Colors.black,): Icon(Icons.visibility_off,color: Colors.black,),
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
                  ElevatedButton(
                      onPressed: (){
                        Firebase().login(emailcontroller.text.toString(), Passwordcontroller.text.toString(),context);
                      },
                      child:const Text("Login"),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgetPassword()));
                      },
                          child: Text("Forget Password",style: TextStyle(color: Colors.blue),)),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                      },
                          child: Text("New User",style: TextStyle(color: Colors.blue),)
                      )

                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}


