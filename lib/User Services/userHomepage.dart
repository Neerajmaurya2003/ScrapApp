import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning/Location%20Services/map.dart';
import 'package:learning/User%20Services/allScheduledPickups.dart';
import 'package:learning/User%20Services/blankscreen.dart';
import 'package:learning/User%20Services/scheduledPickUpSummary.dart';

class userHomepage extends StatefulWidget {
  final String collection;
  final dynamic data;
  final String Uid;
  final List<Map<String, dynamic>> scheduledPickups;

  const userHomepage(
      {super.key,
      required this.collection,
      required this.data,
      required this.Uid,
      required this.scheduledPickups});

  @override
  State<userHomepage> createState() => _userHomepageState();
}

class _userHomepageState extends State<userHomepage> {
  var Username;
  var data;
  double? latitude, longitude;
  late List<Map<String, dynamic>> pickupdata = [];

void refreshData(Object data){
  setState(() {
    pickupdata.remove(data);
  });
}
  @override
  void initState() {
    _getdata();
    super.initState();
  }

  _getdata() async {
    data = await widget.data;
    if (widget.scheduledPickups.isNotEmpty) {
      pickupdata = widget.scheduledPickups;
      pickupdata
          .sort((a, b) => a["Date of Pickup"].compareTo(b["Date of Pickup"]));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: data != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 30, right: 20, left: 10),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      const TextSpan(
                          text: "Hello, ",
                          style: TextStyle(
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: data["Name"],
                          style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black26)),
                      const TextSpan(
                          text: "\n\nWhat you want to sell Today?",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontStyle: FontStyle.italic))
                    ]),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  child: Card(
                      elevation: 5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AllScheduledPickups(
                                                pickupdata: pickupdata,
                                                Uid: widget.Uid,
                                                refreshData: refreshData,
                                              )));
                                },
                                child: Container(
                                  height: 60,
                                  width: 155,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.fire_truck,
                                          size: 30,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                              text: const TextSpan(
                                                  text: "Scheduled",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18))),
                                          RichText(
                                              text: const TextSpan(
                                                  text: "Pickups",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18))),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BlankScreen()));
                                },
                                child: Container(
                                  height: 60,
                                  width: 155,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.history,
                                          size: 30,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                                  text: "Pickup",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18))),
                                          RichText(
                                              text: TextSpan(
                                                  text: "History",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18))),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const myMap()));
                                },
                                child: Container(
                                  height: 60,
                                  width: 155,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.map,
                                          size: 30,
                                        ),
                                      ),
                                      RichText(
                                          text: const TextSpan(
                                              text: "Map ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)))
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BlankScreen()));
                                },
                                child: Container(
                                  height: 60,
                                  width: 155,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FaIcon(
                                          FontAwesomeIcons.users,
                                          size: 30,
                                        ),
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              text: "Enterprises ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                pickupdata.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: ListTile(
                            title: Text(
                                "Scrap Picked Up in ${pickupdata[0]["Date of Pickup"].difference(DateTime.now()).inDays + 1} Days"),
                            subtitle: Text(
                                "Total Amount Rs ${pickupdata[0]["Total Amount"]} only"),
                            trailing: CircleAvatar(
                              backgroundColor: Colors.teal.shade100,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScheduledPickupSummaryPage(
                                                  scheduledPickup:
                                                      pickupdata[0],
                                                  Uid: widget.Uid,
                                                  pickupdata: pickupdata,
                                                  refreshData: refreshData,
                                                )));
                                  },
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_rounded)),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                const Expanded(
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        "This Space is for Advertisement Purpose",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                )
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    ));
  }
}
