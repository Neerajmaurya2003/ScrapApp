import 'package:flutter/material.dart';

class Uihelper {

  static Widget MyCustomtextfield(TextEditingController controller,String text) {
    return TextField(
      controller:controller,
      decoration: InputDecoration(
        labelText: text,
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
    );
  }
  static Future MyCustomdialogueBox(BuildContext context,String text){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text(text),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("Close"))
        ],
      );
    }) ;
  }
  static Widget MyCustomElevatedButton(VoidCallback callback,String text){
    return ElevatedButton(
        onPressed: callback,
        child: Text(text)

    );
  }
  static Widget MyCustomObsecureTextfield(TextEditingController controller,String text,bool isobsecure){
    return TextField(
      controller: controller,
      obscureText: isobsecure,
      obscuringCharacter: "*",
      decoration: InputDecoration(
          labelText: text,
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

      ),

    );
  }
  static Widget MyCustomNumericTextfield(TextEditingController controller,String text){
    return TextField(
      keyboardType: TextInputType.number,
      controller:controller,
      decoration: InputDecoration(
          labelText: text,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
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
    );
  }
}