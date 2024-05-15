import 'package:flutter/material.dart';

class UserSearchPage extends StatefulWidget {
  final String Uid;
  final List<Map<String,dynamic>> scrapData;
  const UserSearchPage({super.key,required this.scrapData,required this.Uid});

  @override
  State<UserSearchPage> createState() => _UserSearchPageState();
}

class _UserSearchPageState extends State<UserSearchPage> {
  var searchcontroller=TextEditingController();
  List<Map<String,dynamic>> searchdata=[];
  @override
  void initState() {
    searchdata=widget.scrapData;
    super.initState();
  }

  @override
  void dispose(){
  searchcontroller.dispose();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
            child: TextField(
              onChanged: (value){
                setState(() {
                  searchdata=[];
                  RegExp regex= RegExp(value,caseSensitive: false);
                  for(int i=0;i<widget.scrapData.length;i++){
                    if(regex.hasMatch(widget.scrapData[i]["Name"])){
                      searchdata.add(widget.scrapData[i]);
                    }
                  }
                });
              },
              controller: searchcontroller,
              decoration: InputDecoration(
               hintText: "Search for Scrap Price",
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
                suffixIcon:const Padding(
                  padding:  EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.search,size: 25),
                )
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchdata.length,
                itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text("${searchdata[index]["Name"]}"),
                      subtitle: Text("Rs ${searchdata[index]["price"]}/kg"),
                    ),
                  ),
                );
              }),
          )
        ],
      ),
    );
  }
}
