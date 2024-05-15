import 'package:flutter/material.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';

class ScheduledPickupSummaryPage extends StatefulWidget {
  final Map<String, dynamic> scheduledPickup;
  List<Map<String, dynamic>> pickupdata;
  final String Uid;
  final Function refreshData;
  ScheduledPickupSummaryPage(
      {super.key,
      required this.scheduledPickup,
      required this.Uid,
      required this.pickupdata,
        required this.refreshData
 });

  @override
  State<ScheduledPickupSummaryPage> createState() =>
      _ScheduledPickupSummaryPageState();
}

class _ScheduledPickupSummaryPageState
    extends State<ScheduledPickupSummaryPage> {
  List<Map<String, dynamic>> scrapItem = [];
  TextStyle textStyle =
      const TextStyle(fontWeight: FontWeight.w700, fontSize: 17);



  @override
  void initState() {
    getdata();
    // TODO: implement initState
    super.initState();
  }

  getdata() {
    for (var temp in widget.scheduledPickup["Selected Scrap"]) {
      scrapItem.add(temp);
    }
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
            child: Text("Order Summary!")),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, top: 20),
                    child: Row(
                      children: [
                        Text(
                          "Category : ",
                          style: textStyle,
                        ),
                        Expanded(
                          child: Text(
                            "${widget.scheduledPickup["Category"]}",
                            style: textStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        Text(
                          "Address of Pickup : ",
                          style: textStyle,
                        ),
                        Expanded(
                          child: Text(
                            "${widget.scheduledPickup["Address"]} ${widget.scheduledPickup["Pin code"]}",
                            style: textStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        Text(
                          "Date of Pickup : ",
                          style: textStyle,
                        ),
                        Text(
                          "${widget.scheduledPickup["Date of Pickup"]!.day}-${widget.scheduledPickup["Date of Pickup"]!.month}-${widget.scheduledPickup["Date of Pickup"]!.year}",
                          style: textStyle,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        Text(
                          "Date of Applying : ",
                          style: textStyle,
                        ),
                        Text(
                          "${widget.scheduledPickup["Date of applying"]!.day}-${widget.scheduledPickup["Date of applying"]!.month}-${widget.scheduledPickup["Date of applying"]!.year}",
                          style: textStyle,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        Text(
                          "Time Slot Of Pickup : ",
                          style: textStyle,
                        ),
                        Text(
                          "${widget.scheduledPickup["Time Slot"]}",
                          style: textStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      "Selected Scrap Items ",
                      style: textStyle,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columns: const [
                          DataColumn(label: Text("Scrap Item")),
                          DataColumn(label: Text("Weight(in Kg)")),
                          DataColumn(label: Text("Price List"))
                        ],
                        rows: scrapItem.map((value) {
                          return DataRow(cells: [
                            DataCell(Text(value["Name"])),
                            DataCell(Text(value["quantity"].toString())),
                            DataCell(Text(
                                "${value["quantity"] * int.parse(value["price"])}"))
                          ]);
                        }).toList()),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, bottom: 30, left: 8),
                    child: Row(
                      children: [
                        Text(
                          "Total amount : ",
                          style: textStyle,
                        ),
                        Text(
                          "Rs ${widget.scheduledPickup["Total Amount"].toString()}",
                          style: textStyle,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10, left: 30, right: 30),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: const Center(
                        child: Text(
                          "This Space is For Advertisement Purpose",
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 15),
                    child: ElevatedButton(
                        onPressed: () async {
                          String docname = widget.scheduledPickup["Time Slot"] +
                              widget.scheduledPickup["Date of Pickup"]
                                  .toString();
                          bool flag = await Firebase().deletePickup(
                              Uid: widget.Uid,
                              context: context,
                              category: widget.scheduledPickup["Category"],
                              docname: docname);
                          if (flag) {
                            setState(() {
                              widget.pickupdata.remove(widget.scheduledPickup);
                            });
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return Dialog(
                                    child: SizedBox(
                                      height: 250,
                                      width: 150,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Colors.black),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                50))),
                                                child: const CircleAvatar(
                                                  radius: 50,
                                                  backgroundColor: Colors.green,
                                                  child: Center(
                                                      child: Text("Done",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black))),
                                                ),
                                              )),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                              "Your Pickup is Deleted Successfully!!"),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0, bottom: 5),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  widget.refreshData(widget.scheduledPickup);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Okk")),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }));
                          }
                        },
                        child: const Text(
                          "Cancel pickup",
                        )),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
