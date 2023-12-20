import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:winhealth_admin/components/appointment_card.dart';
import 'package:winhealth_admin/components/notes_card.dart';
import 'package:winhealth_admin/models/appointment.dart';
import 'package:winhealth_admin/models/notes.dart';
import 'package:winhealth_admin/models/question.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/services/appointment_service.dart';
import 'package:winhealth_admin/services/questionare_service.dart';
import 'package:winhealth_admin/utils/constants.dart';

class AppointmentHome extends StatefulWidget {
  final UserModel? currentUser;
  const AppointmentHome({super.key, required this.currentUser});

  @override
  State<AppointmentHome> createState() => _AppointmentHomeState();
}

class _AppointmentHomeState extends State<AppointmentHome> {
  ScrollController scrollController = ScrollController();
  TextEditingController notesController = TextEditingController();
  bool showbtn = false;
  bool showNotes = false;
  DateTime? currentDate = DateTime(2023, 09, 15);
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

  bool loading = false;
  List<Appointment> appointments = [];
  Appointment? selectedAppointment;

  getInitData() async {
    setState(() {
      loading = true;
    });
    await getAppointments();
    setState(() {
      loading = false;
    });
  }

  getAppointments() async {
    appointments = await AppointmentService.getAppointmentsByDocterIDandDate(
        widget.currentUser!.id!,
        "${currentDate!.year.toString()}-${currentDate!.month.toString().padLeft(2, "0")}-${currentDate!.day.toString().padLeft(2, "0")}");
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
                        "Your Appointments",
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
                            await getAppointments();
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
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appointments.isEmpty
                            ? const Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "* No Appointments found for the selected date",
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      child: AppointmentCard(
                                        isSelected: selectedAppointment == null
                                            ? false
                                            : selectedAppointment!.id ==
                                                appointments[index].id,
                                        appointment: appointments[index],
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedAppointment =
                                              appointments[index];
                                          showNotes = !showNotes;
                                        });
                                      },
                                    );
                                  },
                                  shrinkWrap: true,
                                  itemCount: appointments.length,
                                ),
                              ),
                        const SizedBox(
                          width: 32,
                        ),
                        appointments.isEmpty
                            ? const SizedBox()
                            : Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Notes for Selected Appointment",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                    showNotes
                                        ? Text(
                                            "ID: ${selectedAppointment!.id}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const Text(
                                            "Select an Appointment to add/show the notes",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                    !showNotes
                                        ? const SizedBox()
                                        : const SizedBox(
                                            height: 16,
                                          ),
                                    !showNotes
                                        ? const SizedBox()
                                        : Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                child: TextFormField(
                                                  controller: notesController,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText:
                                                        'Enter your notes here',
                                                    hintStyle: TextStyle(
                                                        color: Colors.black),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    focusColor: Colors.white,
                                                    hoverColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                      borderSide: BorderSide(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        width: 1,
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () async {
                                                  selectedAppointment!.notes!
                                                      .add(
                                                    Note(
                                                      title:
                                                          notesController.text,
                                                      dateTime: DateTime.now()
                                                          .toString(),
                                                    ),
                                                  );
                                                  bool res =
                                                      await AppointmentService
                                                          .updateNotes({
                                                    "slot_id": 62,
                                                    "notes":
                                                        selectedAppointment!
                                                            .notes!
                                                            .map((e) =>
                                                                jsonEncode(
                                                                    e.toJson()))
                                                            .toList()
                                                            .toString(),
                                                    "status": "booked"
                                                  }, selectedAppointment!.id);
                                                  if (res) {
                                                    notesController.clear();
                                                    await getAppointments();
                                                    Fluttertoast.showToast(
                                                        msg: "Notes added!");
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "Notes addition failed!");
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  width: 40,
                                                  height: 40,
                                                  child: const Icon(
                                                    Icons.add,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                    !showNotes
                                        ? const SizedBox()
                                        : const SizedBox(
                                            height: 16,
                                          ),
                                    !showNotes
                                        ? const SizedBox()
                                        : selectedAppointment!.notes!.isEmpty
                                            ? const Text(
                                                "No Notes for Selected Appointment",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            : ListView.builder(
                                                itemBuilder: ((context, ind) =>
                                                    NotesCard(
                                                      note: selectedAppointment!
                                                          .notes![ind],
                                                    )),
                                                itemCount: selectedAppointment!
                                                    .notes!.length,
                                                shrinkWrap: true,
                                              )
                                  ],
                                ),
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
