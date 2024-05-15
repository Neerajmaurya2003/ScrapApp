import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import 'package:learning/Common%20Services/ForgetPassword.dart';
import 'package:learning/Common%20Services/SignUpPage.dart';


class LoginPage extends StatelessWidget {
   const LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:const Text("Already Have an Account"),) ,
      body: Center(
        child: NarrowLayoutDesign(),

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
  var passwordcontroller =TextEditingController();
  var _dropDownController=SingleValueDropDownController();
  bool isobsecure=true;

  @override
  void dispose() {
   emailcontroller.dispose();
   passwordcontroller.dispose();
   _dropDownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            margin:const EdgeInsets.only(left: 10,right: 10),
            width: 380,
            height: 550,
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
                    child:const Icon(Icons.lock,size: 50,),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:10.0,right: 10.0),
                    child: TextField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        labelText: "Enter Username or Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:const BorderSide(
                            width: 2,
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                    
                                borderRadius: BorderRadius.circular(15),
                                borderSide:const BorderSide(
                                  width: 2,
                                ),
                      ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:const BorderSide(
                              width: 2,
                              color: Colors.teal,
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        disabledBorder:OutlineInputBorder(
                            borderSide:const BorderSide(
                              width: 2,
                                color: Colors.black54,
                                style: BorderStyle.solid
                            ),
                            borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                    child: TextField(
                      controller: passwordcontroller,
                      obscureText: isobsecure,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                          labelText: "Enter Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:const BorderSide(
                                width: 2,
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                    
                            borderRadius: BorderRadius.circular(15),
                            borderSide:const BorderSide(
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:const BorderSide(
                                width: 2,
                                color: Colors.teal,
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          disabledBorder:OutlineInputBorder(
                              borderSide:const BorderSide(
                                width: 2,
                                  color: Colors.black54,
                                  style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          suffixIcon: IconButton(
                            icon: isobsecure==true?const  Icon(Icons.visibility,color: Colors.black,):const Icon(Icons.visibility_off,color: Colors.black,),
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
                  SizedBox(
                    height: 11,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: DropDownTextField(
                      textFieldDecoration: InputDecoration(
                          labelText: "Select Category",
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.teal,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          )
                      ),
                      controller: _dropDownController,
                      dropDownItemCount: 2,
                      dropDownList:const [
                        DropDownValueModel(name: "Household", value: "Household"),
                        //DropDownValueModel(name: "Enterprize", value: "Enterprize")
                      ],
                      onChanged: (val){},
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Firebase().login(context: context,email:emailcontroller.text.toString(),password: passwordcontroller.text.toString(),collection: _dropDownController.dropDownValue!.value.toString());
                      },
                      child:const Text("Login"),
                  ),
                 const SizedBox(
                    height: 11,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgetPassword()));
                      },
                          child:const Text("Forget Password",style: TextStyle(color: Colors.blue),)),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpPage()));
                      },
                          child:const Text("New User",style: TextStyle(color: Colors.blue),)
                      )

                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}


