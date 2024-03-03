import 'package:firebase_core/firebase_core.dart';
import 'package:learning/Firebase/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:learning/customer_login.dart';
import 'package:learning/splash_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scrap App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const Splash_Screen(),
    );
  }
}

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});





  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: WideLayoutDesign()
    );
  }
}
//Wide Layout Design
class WideLayoutDesign extends StatelessWidget {
  const WideLayoutDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(
              ),
            ),
            Image.asset("assets/images/1.jpg", ),
            const Column(
              children: [
                SizedBox(
                  width: 400,
                  height: 50,
                  child: Center(child: Text("SELL RECYCLABLE ONLINE"),),
                ),
                SizedBox(
                  width: 400,
                  height: 50,
                  child: Center(child: Text("PAPERS | PLASTICS | METALS | EWASTE",style: TextStyle(color: Colors.blueGrey),)),
                ),
              ],
            ),
           const Expanded(
                flex: 1,
                child: SizedBox()
            ),
             SizedBox(
              height: 60,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                  },
                  child:const Center(child: Text("GET STARTED"))),
            )
          ],
        )
    );
  }
}
