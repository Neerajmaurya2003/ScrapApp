import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';

class EnterpriseHomePage extends StatefulWidget {
  final String collection;
  const EnterpriseHomePage({super.key,required this.collection});

  @override
  State<EnterpriseHomePage> createState() => _EnterpriseHomePageState();
}

class _EnterpriseHomePageState extends State<EnterpriseHomePage> {
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:const Icon(Icons.logout),onPressed: (){
        Firebase().signoutUser(context);
        },),
        title: const Text("Enterprise Home Page"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 300,
            width: double.maxFinite,
            color: Colors.blueAccent,
          )
        ],
      ),
    bottomNavigationBar: Padding(
      padding: const EdgeInsets.only(top: 8,bottom: 8),
      child: GNav(
            rippleColor: Colors.grey[800]!, 
            hoverColor: Colors.grey[700]!, 
            haptic: true, 
            tabBorderRadius: 15, 
            tabActiveBorder: Border.all(color: Colors.black, width: 1), 
            tabBorder: Border.all(color: Colors.grey, width: 1), 
            curve: Curves.easeOutExpo, 
            duration:const Duration(milliseconds: 200), 
            gap: 8, 
            color: Colors.grey[800], 
            activeColor: Colors.teal, 
            iconSize: 24, 
            tabBackgroundColor: Colors.teal.withOpacity(0.1), 
            padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 5), 
        tabs:const [
              GButton(
          icon: Icons.home,
          text: 'Home',
              ),
               GButton(
          icon: Icons.heart_broken,
          text: 'Likes',
              ),
               GButton(
          icon: Icons.search,
          text: 'Search',
              ),
               GButton(
          icon: Icons.person,
          text: 'Profile',
              )
            ]
      ),
    ),
    );
  }
}
