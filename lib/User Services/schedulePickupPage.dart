import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learning/Common%20Services/Uihelper.dart';
import 'package:learning/Firebase/Firebase_Utilities.dart';

class PickUpInfo {
  String category;
  String Address;
  String pincode;
  DateTime dateofpickup;
  DateTime currentdate = DateTime.now();
  String timeslot;
  double Totalamount;
  List<Map<String, dynamic>> selectedScrap;

  PickUpInfo(
      {required this.Address,
      required this.dateofpickup,
      required this.pincode,
      required this.timeslot,
      required this.Totalamount,
      required this.selectedScrap,
      required this.category});

  Map<String, Object?> toMap() {
    return {
      "Category": category,
      "Address": Address,
      "Pin code": pincode,
      "Date of Pickup": dateofpickup,
      "Time Slot": timeslot,
      "Total Amount": Totalamount,
      "Selected Scrap": selectedScrap,
      "Date of applying": currentdate
    };
  }
}

class SchedulePickuppage extends StatefulWidget {
  final List<Map<String, dynamic>> scrapData;
  final String Uid;
  int selectedIndex;
  List<Map<String, dynamic>> scheduledPickups;

  SchedulePickuppage(
      {super.key,
      required this.scrapData,
      required this.Uid,
      required this.selectedIndex,
      required this.scheduledPickups});

  @override
  State<SchedulePickuppage> createState() => _SchedulePickuppageState();
}

class _SchedulePickuppageState extends State<SchedulePickuppage> {
  var _dropDownController = SingleValueDropDownController();
  var timecontroller = SingleValueDropDownController();
  int _activeCurrentStep = 0;
  List<Map<String, dynamic>> tempData = [];
  List<Map<String, dynamic>> selectedScrap = [];
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController pincodecontroller = TextEditingController();
  DateTime? datepicker;
  TextStyle textStyle =const TextStyle(fontWeight: FontWeight.w700, fontSize: 15);
  double totalAmount = 0;
  Map<String, dynamic> temp = {};
  var flag;

  @override
  void initState() {
    tempData = widget.scrapData;
    super.initState();
  }

  @override
  void dispose() {
    _dropDownController.dispose();
    addresscontroller.dispose();
    pincodecontroller.dispose();
    timecontroller.dispose();
    super.dispose();
  }

  void showSnackBar({required BuildContext context, required String content}) {
    final snackbar = SnackBar(
      content: Text(content),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void totalAmountCalculator() {
    for (int i = 0; i < selectedScrap.length; i++) {
      totalAmount +=
          selectedScrap[i]["quantity"] * int.parse(selectedScrap[i]["price"]);
    }
  }

  List<Step> stepList() => [
        Step(
          state:
              _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 0,
          title: const Text('Select Your Category'),
          content: Container(
            child: Column(
              children: [
                DropDownTextField(
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
                      )),
                  controller: _dropDownController,
                  dropDownItemCount: 2,
                  dropDownList: const [
                    DropDownValueModel(name: "Sell", value: "Sell"),
                    DropDownValueModel(name: "Donate", value: "Donate")
                  ],
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
        ),
        Step(
            state: _activeCurrentStep <= 1
                ? StepState.editing
                : StepState.complete,
            isActive: _activeCurrentStep >= 1,
            title: const Text('Select Items'),
            content: Container(
              width: MediaQuery.of(context).size.width - 30,
              height: MediaQuery.of(context).size.height - 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          tempData = [];
                          RegExp regex = RegExp(value, caseSensitive: false);
                          for (int i = 0; i < widget.scrapData.length; i++) {
                            if (regex.hasMatch(widget.scrapData[i]["Name"])) {
                              tempData.add(widget.scrapData[i]);
                            }
                          }
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Search for Scrap",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                width: 2,
                              )),
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
                              borderRadius: BorderRadius.circular(15)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.black54,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(15)),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.search, size: 25),
                          )),
                    ),
                  ),
                  selectedScrap.length != 0
                      ? SizedBox(
                          child: Text("Selected Items"),
                        )
                      : SizedBox.shrink(),
                  selectedScrap.length != 0
                      ? Expanded(
                          flex: selectedScrap.length + 1,
                          child: ListView.builder(
                              itemCount: selectedScrap.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0, bottom: 2),
                                  child: Card(
                                    elevation: 3,
                                    child: ListTile(
                                      title: Text(selectedScrap[index]["Name"]),
                                      subtitle: Text(
                                          "Rs ${selectedScrap[index]["price"]}/kg"),
                                      trailing: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedScrap
                                                .remove(selectedScrap[index]);
                                          });
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.x,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : SizedBox.shrink(),
                  Container(
                    width: MediaQuery.of(context).size.width - 30,
                    height: 2,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text("All Scraps"),
                  ),
                  Expanded(
                    flex: (tempData.length - selectedScrap.length) + 1,
                    child: ListView.builder(
                        itemCount: tempData.length,
                        itemBuilder: (context, index) {
                          if (selectedScrap.contains(tempData[index])) {
                            return const SizedBox.shrink();
                          } else {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 2.0, bottom: 2),
                              child: Card(
                                elevation: 3,
                                child: ListTile(
                                  title: Text(tempData[index]["Name"]),
                                  subtitle:
                                      Text("Rs ${tempData[index]["price"]}/kg"),
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedScrap.add(tempData[index]);
                                        selectedScrap[selectedScrap.length - 1]
                                            ["quantity"] = 0;
                                      });
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  )
                ],
              ),
            )),
        Step(
            state: _activeCurrentStep <= 2
                ? StepState.editing
                : StepState.complete,
            isActive: _activeCurrentStep >= 2,
            title:
                const Text('Select Approx Quantity(in Kg) of selected items'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              height: MediaQuery.of(context).size.height / 3,
              child: ListView.builder(
                  itemCount: selectedScrap.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 2.0, bottom: 2),
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          title: Text(selectedScrap[index]["Name"]),
                          subtitle: Text(selectedScrap[index]["price"]),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (selectedScrap[index]["quantity"] ==
                                          0) {
                                        return;
                                      } else {
                                        selectedScrap[index]["quantity"] -= 0.5;
                                      }
                                    });
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.minus,
                                    size: 15,
                                  )),
                              CircleAvatar(
                                child: Text(selectedScrap[index]["quantity"]
                                    .toString()),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      selectedScrap[index]["quantity"] += 0.5;
                                    });
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.plus,
                                    size: 15,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )),
        Step(
          state:
              _activeCurrentStep <= 3 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 3,
          title: const Text('Select Address of Pickup'),
          content: Container(
              child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Uihelper.MyCustomtextfield(
                  addresscontroller, "Enter Your Pickup Address"),
              const SizedBox(
                height: 20,
              ),
              Uihelper.MyCustomNumericTextfield(
                  pincodecontroller, "Enter Pincode"),
            ],
          )),
        ),
        Step(
          state:
              _activeCurrentStep <= 4 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 4,
          title: const Text('Select Date and Time'),
          content: Container(
            child: Column(
              children: [
                Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width - 30,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          datepicker != null
                              ? "${datepicker!.day}-${datepicker!.month}-${datepicker!.year}"
                              : "Select a Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 3.0),
                        child: IconButton(
                            onPressed: () async {
                              datepicker = await showDatePicker(
                                  currentDate: DateTime.now(),
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 15)));
                              setState(() {});
                            },
                            icon: Icon(Icons.calendar_month)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                DropDownTextField(
                  textFieldDecoration: InputDecoration(
                      hintText: "Select Your Time Slot",
                      hintStyle: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                      )),
                  controller: timecontroller,
                  dropDownItemCount: 2,
                  dropDownList: const [
                    DropDownValueModel(name: "7AM to 9AM", value: "Slot1"),
                    DropDownValueModel(name: "9AM to 12PM", value: "Slot2"),
                    DropDownValueModel(name: "12PM to 4PM", value: "Slot3"),
                    DropDownValueModel(name: "4PM to 7PM", value: "Slot4"),
                  ],
                  textStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeCurrentStep >= 5,
          title: const Text('Order Summary'),
          content: Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Row(
                      children: [
                        Text(
                          "Address of Pickup : ",
                          style: textStyle,
                        ),
                        (addresscontroller.text != null &&
                                pincodecontroller.text != null)
                            ? Expanded(
                                child: Text(
                                  "${addresscontroller.text.toString()} ${pincodecontroller.text.toString()}",
                                  style: textStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            : SizedBox.shrink(),
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
                        (datepicker != null)
                            ? Text(
                                "${datepicker!.day}-${datepicker!.month}-${datepicker!.year}",
                                style: textStyle,
                              )
                            : SizedBox.shrink()
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
                        (timecontroller.dropDownValue != null)
                            ? Text(
                                "${timecontroller.dropDownValue!.name}",
                                style: textStyle,
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                  (selectedScrap.isNotEmpty)
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                              columns: const [
                                DataColumn(label: Text("Scrap Item")),
                                DataColumn(label: Text("Weight(in Kg)")),
                                DataColumn(label: Text("Price List"))
                              ],
                              rows: selectedScrap.map((value) {
                                return DataRow(cells: [
                                  DataCell(Text(value["Name"])),
                                  DataCell(Text(value["quantity"].toString())),
                                  DataCell(Text(
                                      "${value["quantity"] * int.parse(value["price"])}"))
                                ]);
                              }).toList()),
                        )
                      :const SizedBox.shrink(),
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
                          "Rs ${totalAmount.toString()}",
                          style: textStyle,
                        )
                      ],
                    ),
                  )
                ],
              )),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        type: StepperType.vertical,
        steps: stepList(),
        currentStep: _activeCurrentStep,
        controlsBuilder: (context, controlDetails) {
          return _activeCurrentStep != stepList().length - 1
              ? Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: controlDetails.onStepContinue,
                          child: Text("Next")),
                      ElevatedButton(
                          onPressed: controlDetails.onStepCancel,
                          child: Text("Back"))
                    ],
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: ()async {
                          var Scrapinfo = PickUpInfo(
                              category: _dropDownController.dropDownValue!.name
                                  .toString(),
                              Address: addresscontroller.text.toString(),
                              dateofpickup: datepicker!,
                              pincode: pincodecontroller.text.toString(),
                              timeslot: timecontroller.dropDownValue!.name,
                              Totalamount: totalAmount,
                              selectedScrap: selectedScrap);
                            flag = await Firebase().schedulePickup(
                                Uid: widget.Uid,
                                context: context,
                                pickupdata: Scrapinfo.toMap());
                          if(flag){
                            setState(() {
                            widget.scheduledPickups
                                .add(Scrapinfo.toMap());
                            widget.selectedIndex = 1;
                          });
                          showDialog(context: context, builder: ( (context) {
                            return  Dialog(
                              child: SizedBox(
                                height: 250,
                                width: 150,
                                child: Column(
                                  children: [
                                   const SizedBox(height: 20,),
                                   Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.black
                                        ),
                                        borderRadius:const BorderRadius.all(Radius.circular(50))
                                      ),
                                      child:const CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.green,
                                        child: Center(child: Text("Done",style:TextStyle(color: Colors.black))),
                                      ),
                                    )
                                  ),
                                 const SizedBox(height: 5,),
                                 const Text("Your Pickup is Scheduled!!"),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0,bottom: 5),
                                    child: ElevatedButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child:const Text("Okk")),
                                  )
                                ],),
                              ),
                            );
                          }));
                          }


                        },
                        child: Text("Submit")),
                    ElevatedButton(
                        onPressed: controlDetails.onStepCancel,
                        child: Text("Edit")),
                  ],
                );
        },
        onStepContinue: () {
          if (_activeCurrentStep != stepList().length) {
            if (_activeCurrentStep == 0) {
              if (_dropDownController.dropDownValue == null) {
                return showSnackBar(
                    context: context, content: "Please Select your category");
              } else {
                setState(() {
                  _activeCurrentStep++;
                });
              }
            } else if (_activeCurrentStep == 1) {
              if (selectedScrap.isEmpty) {
                return showSnackBar(
                    context: context,
                    content: "Please Select Items To Schedule A PickUp");
              } else {
                setState(() {
                  _activeCurrentStep++;
                });
              }
            } else if (_activeCurrentStep == 2) {
              for (int i = 0; i < selectedScrap.length; i++) {
                if (selectedScrap[i]["quantity"] == 0 ||
                    !selectedScrap[i].containsKey("quantity")) {
                  return showSnackBar(
                      context: context, content: "Quantity Can't be zero");
                }
              }
              setState(() {
                _activeCurrentStep++;
              });
            } else if (_activeCurrentStep == 3) {
              if (addresscontroller.text.toString().isEmpty ||
                  pincodecontroller.text.toString().isEmpty) {
                return showSnackBar(
                    context: context, content: "All Fields are Required");
              }
              setState(() {
                _activeCurrentStep++;
              });
            } else if (_activeCurrentStep == 4) {
              if (datepicker == null || timecontroller.dropDownValue == null) {
                return showSnackBar(
                    context: context,
                    content: "Please Enter Date and Time of Pickup");
              }
              setState(() {
                totalAmountCalculator();
                _activeCurrentStep++;
              });
            }
          }
        },
        onStepCancel: () {
          if (_activeCurrentStep > 0) {
            setState(() {
              _activeCurrentStep--;
            });
          }
        },
      ),
    );
  }
}
