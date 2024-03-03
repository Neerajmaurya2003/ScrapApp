import 'package:cloud_firestore/cloud_firestore.dart';

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
}