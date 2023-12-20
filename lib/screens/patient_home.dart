import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:winhealth_admin/components/notes_card.dart';
import 'package:winhealth_admin/components/pateint_card.dart';
import 'package:winhealth_admin/components/questionare_card.dart';
import 'package:winhealth_admin/models/answer.dart';
import 'package:winhealth_admin/models/patient.dart';
import 'package:winhealth_admin/models/question.dart';
import 'package:winhealth_admin/services/patient_service.dart';
import 'package:winhealth_admin/services/questionare_service.dart';
import 'package:winhealth_admin/utils/constants.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  bool showNotes = false;
  bool loading = false;
  List<Patient> patientList = [];
  List<Question> questions = [];
  List<Answer> answer = [];

  Patient? selectedPatient;
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
    await getPatients();
    questions = await QuestionareService.getAllQuestion();
    setState(() {
      loading = false;
    });
  }

  getPatients() async {
    patientList = await PatientService.getPatients();
  }

  genAnswer(Question question, Answer answer) {
    if (question.type == "multi") {
      return question.options!
          .where((element) => element.key! == answer.response![0])
          .first
          .text;
    }
    if (question.type == "range") {
      switch (answer.response![0]) {
        case "0":
          return "None";
        case "1":
          return "Not very sever";
        case "2":
          return "Tolerable Pain";
        case "3":
          return "In a lot of pain";
        case "4":
          return "Extreme Pain";
        default:
          return "None";
      }
    }
    if (question.type == "text") {
      return answer.response![0];
    }

    return "N/A";
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
                        "All Patients",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 16, vertical: 8),
                    //       decoration: BoxDecoration(
                    //         color: Colors.greenAccent,
                    //         borderRadius: BorderRadius.circular(12),
                    //       ),
                    //       child: const Text(
                    //         "Add Patient",
                    //         style: TextStyle(
                    //           fontSize: 20,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //     // const Spacer(),
                    //     const SizedBox(
                    //       width: 32,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () async {
                    //         // currentDate = await showDatePicker(
                    //         //   context: context,
                    //         //   initialDate: currentDate!,
                    //         //   firstDate: DateTime(2023),
                    //         //   lastDate: DateTime(2923),
                    //         // );
                    //         // setState(() {});
                    //       },
                    //       child: const CircleAvatar(
                    //         radius: 24,
                    //         backgroundColor: Colors.greenAccent,
                    //         child: Icon(
                    //           Icons.person_add,
                    //           size: 24,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    const Divider(),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: PatientCard(
                                  patient: patientList[index],
                                  isSelected: selectedPatient == null
                                      ? false
                                      : (selectedPatient!.userId ==
                                          patientList[index].userId),
                                ),
                                onTap: () async {
                                  if (!showNotes &&
                                      selectedPatient != null &&
                                      selectedPatient!.userId !=
                                          patientList[index].userId) {
                                    setState(() {
                                      showNotes = true;
                                      selectedPatient = patientList[index];
                                    });
                                    answer = await QuestionareService
                                        .getAllAnswerByUserId(
                                            selectedPatient!.userId.toString());
                                    setState(() {});
                                  } else {
                                    setState(() {
                                      showNotes = true;
                                      selectedPatient = patientList[index];
                                    });
                                    answer = await QuestionareService
                                        .getAllAnswerByUserId(
                                            selectedPatient!.userId.toString());
                                    setState(() {});
                                  }
                                  print(answer.length);
                                },
                              );
                            },
                            shrinkWrap: true,
                            itemCount: patientList.length,
                          ),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Questionare Data for Selected Patinet",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              showNotes
                                  ? Text(
                                      "ID: ${selectedPatient!.user!.id}\nName: ${selectedPatient!.user!.firstName} ${selectedPatient!.user!.lastName}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const Text(
                                      "Select Patient to add/show the Questionare Data",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                              // const Text(
                              //   "No Notes for Selected Appointment",
                              //   style: TextStyle(fontWeight: FontWeight.bold),
                              // ),
                              !showNotes
                                  ? const SizedBox()
                                  : const SizedBox(
                                      height: 16,
                                    ),
                              !showNotes
                                  ? const SizedBox()
                                  : Row(
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      'Enter your question here',
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
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              child: TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  hintText:
                                                      'Enter your answer here',
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
                                          ],
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Fluttertoast.showToast(
                                              msg: "Comming Soon",
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            width: 80,
                                            height: 130,
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
                              !showNotes && answer.isEmpty
                                  ? const SizedBox()
                                  : answer.isEmpty
                                      ? const Center(
                                          child: Text(
                                            "* No Answer found for the selected patient",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemBuilder: (context, index) =>
                                              QuestionareCard(
                                            question: questions[index].text!,
                                            answer: genAnswer(questions[index],
                                                answer[index]),
                                          ),
                                          itemCount: questions.length,
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
