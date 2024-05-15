import 'package:flutter/material.dart';
import 'package:learning/User%20Services/scheduledPickUpSummary.dart';

class AllScheduledPickups extends StatefulWidget {
  final List<Map<String, dynamic>> pickupdata;
  final String Uid;
  final Function refreshData;
  const AllScheduledPickups(
      {super.key, required this.pickupdata, required this.Uid,required this.refreshData});

  @override
  State<AllScheduledPickups> createState() => _AllScheduledPickupsState();
}

class _AllScheduledPickupsState extends State<AllScheduledPickups> {

  void refreshData(Object data){
    setState(() {
      widget.refreshData(data);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Text("Scheduled Pickups")),
        ),
        body: widget.pickupdata.isNotEmpty
            ? ListView.builder(
                itemCount: widget.pickupdata.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: ListTile(
                        title: Text(
                            "Scrap Picked Up in ${widget.pickupdata[index]["Date of Pickup"].difference(DateTime.now()).inDays + 1} Days"),
                        subtitle: Text(
                            "Total Amount Rs ${widget.pickupdata[index]["Total Amount"]} only"),
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
                                                  widget.pickupdata[index],
                                              Uid: widget.Uid,
                                              pickupdata: widget.pickupdata,
                                              refreshData: refreshData,
                                            )));
                              },
                              icon:
                                  const Icon(Icons.arrow_forward_ios_rounded)),
                        ),
                      ),
                    ),
                  );
                })
            : const Center(
                child: Text(
                  "No Pickup is Scheduled!!",
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.black54),
                ),
              ));
  }
}
