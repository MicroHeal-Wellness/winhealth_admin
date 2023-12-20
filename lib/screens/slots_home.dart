// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:winhealth_admin/components/appointment_card.dart';
import 'package:winhealth_admin/components/notes_card.dart';
import 'package:winhealth_admin/components/pateint_card.dart';
import 'package:winhealth_admin/components/slot_card.dart';
import 'package:winhealth_admin/models/slot.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/services/slot_service.dart';
import 'package:winhealth_admin/utils/constants.dart';

class SlotsHome extends StatefulWidget {
  final UserModel? currentUser;
  const SlotsHome({super.key, required this.currentUser});

  @override
  State<SlotsHome> createState() => _SlotsHomeState();
}

class _SlotsHomeState extends State<SlotsHome> {
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  DateTime? currentDate = DateTime.now();
  List<Slot> slots = [];
  List<String> timeList = [
    "09:00:00",
    "09:30:00",
    "10:00:00",
    "10:30:00",
    "11:30:00",
    "12:30:00",
    "13:00:00",
    "13:30:00",
    "14:00:00",
    "14:30:00",
    "15:30:00",
    "15:30:00",
    "16:00:00",
    "16:30:00",
    "17:00:00",
    "17:30:00",
    "18:30:00",
    "18:30:00",
    "19:00:00",
    "19:30:00",
    "20:00:00",
    "20:30:00",
    "21:00:00",
  ];

  bool chkClick(String time) {
    for (int i = 0; i < slots.length; i++) {
      if (slots[i].startTime == time) {
        return false;
      }
    }
    return true;
  }

  Color genStatusColor(String time) {
    for (int i = 0; i < slots.length; i++) {
      if (slots[i].startTime == time) {
        if (slots[i].status == "available") {
          return Colors.green;
        } else if (slots[i].status == "booked") {
          return Colors.cyan;
        }
        break;
      }
    }
    return Colors.grey;
  }

  bool loading = true;
  @override
  void initState() {
    scrollController.addListener(() {
      //scroll listener
      double showoffset =
          10.0; //Back to top botton will show on scroll offset 10.0

      if (scrollController.offset > showoffset) {
        showbtn = true;
        setState(() {
          //update state
        });
      } else {
        showbtn = false;
        setState(() {
          //update state
        });
      }
    });
    getInitData();
    super.initState();
  }

  getInitData() async {
    setState(() {
      loading = true;
    });
    slots = await SlotService.getSlotsByDocterID(widget.currentUser!.id!,
        "${currentDate!.year}-${currentDate!.month.toString().padLeft(2, "0")}-${currentDate!.day.toString().padLeft(2, "0")}");
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100.withOpacity(0.4),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: showbtn ? 1.0 : 0.0,
        child: FloatingActionButton(
          onPressed: () {
            scrollController.animateTo(0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          },
          backgroundColor: primaryColor,
          child: const Icon(
            Icons.arrow_upward,
          ),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(32.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Slots ",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Date: ${currentDate!.day.toString().padLeft(2, "0")}-${currentDate!.month.toString().padLeft(2, "0")}-${currentDate!.year.toString().padLeft(2, "0")}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // const Spacer(),
                        const SizedBox(
                          width: 32,
                        ),
                        GestureDetector(
                          onTap: () async {
                            currentDate = await showDatePicker(
                                  context: context,
                                  initialDate: currentDate!,
                                  firstDate: DateTime(2023),
                                  lastDate: DateTime(2923),
                                ) ??
                                DateTime.now();
                            setState(() {});
                            await getInitData();
                          },
                          child: const CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.greenAccent,
                            child: Icon(
                              Icons.calendar_month,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 8,
                    ),
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.grey,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text("Unavailable"),
                        SizedBox(
                          width: 16,
                        ),
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.green,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text("Available"),
                        SizedBox(
                          width: 16,
                        ),
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.cyan,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text("Booked"),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 16,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "* Click on unaviale slot to mark it as available",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 170,
                              childAspectRatio: 7 / 3,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: SlotsCard(
                                  title: timeList[index],
                                  color: genStatusColor(timeList[index]),
                                ),
                                onTap: () async {
                                  if (chkClick(timeList[index]) &&
                                      DateTime(
                                        currentDate!.year,
                                        currentDate!.month,
                                        currentDate!.day,
                                        int.parse(
                                            timeList[index].split(":").first),
                                        int.parse(
                                          timeList[index].split(":")[1],
                                        ),
                                      ).isAfter(DateTime.now())) {
                                    await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("Slot Update"),
                                        content: const Text(
                                          "Are you sure you want to mark the slot as available?",
                                        ),
                                        actions: [
                                          MaterialButton(
                                            onPressed: () async {
                                              bool res = await SlotService
                                                  .createSlotsByDocterID(
                                                widget.currentUser!.id!,
                                                "${currentDate!.year.toString()}-${currentDate!.month.toString().padLeft(2, "0")}-${currentDate!.day.toString().padLeft(2, "0")}",
                                                timeList[index],
                                                "available",
                                              );
                                              if (res) {
                                                Fluttertoast.showToast(
                                                    msg: "Slot Updated");
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "Slot Update Failed");
                                              }
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Ok"),
                                          ),
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel"),
                                          )
                                        ],
                                      ),
                                    );
                                    await getInitData();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "You cannot update an invalid slot");
                                  }
                                },
                              );
                            },
                            shrinkWrap: true,
                            itemCount: timeList.length,
                          ),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
