import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';
import 'package:learning/Common%20Services/Uihelper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var emailcontroller=TextEditingController();
  var passwordcontroller=TextEditingController();
  bool isobsecure=true;
  var _dropDownController=SingleValueDropDownController();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    _dropDownController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
 
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
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(left: 10,right: 10),
                width: 380,
                height: 470,
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
                        child: const Icon(Icons.lock,size: 50,),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Container(

                          child: Uihelper.MyCustomtextfield(emailcontroller, "Enter Username or Email"),
                        ),
                      ),
                      const SizedBox(
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
                                    borderSide: const BorderSide(
                                      width: 2,
                                    )
                                ),
                                enabledBorder: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Colors.teal,
                                    ),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                disabledBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2,
                                        color: Colors.black54,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.remove_red_eye,color: Colors.black,),
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
                      const SizedBox(
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
                              //DropDownValueModel(name: "Enterprise", value: "Enterprise")
                            ],
                            onChanged: (val){},
                        ),
                      ),
                      ElevatedButton(
                        onPressed: ()async{
                          print(emailcontroller.text.toString());
                          print(passwordcontroller.text.toString());
                          print(_dropDownController.dropDownValue!.value.toString());
                          if(emailcontroller.text.toString()=="" || passwordcontroller.text.toString()=="" || _dropDownController.dropDownValue!.value.toString()==null){
                            return await Uihelper.MyCustomdialogueBox(context, "Enter all fields");
                          }
                          else{
                            Firebase().signup(email: emailcontroller.text.toString(),context: context,password:passwordcontroller.text.toString(),whouser: _dropDownController.dropDownValue!.value.toString());
                          }
                        },
                        child: const Text("Submit"),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );

  }
}
