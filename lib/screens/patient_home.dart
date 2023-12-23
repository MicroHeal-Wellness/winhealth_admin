import 'package:flutter/material.dart';
import 'package:winhealth_admin/components/patient_info_card.dart';
import 'package:winhealth_admin/models/answer.dart';
import 'package:winhealth_admin/models/question.dart';
import 'package:winhealth_admin/models/user_model.dart';
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
  List<UserModel> patientList = [];
  List<Question> questions = [];
  List<Answer> answer = [];

  UserModel? selectedPatient;
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
                    const Divider(),
                    const SizedBox(
                      height: 16,
                    ),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 1800
                                  ? 3
                                  : MediaQuery.of(context).size.width > 1200
                                      ? 2
                                      : 1,
                          childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.2 : 0.9,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16),
                      itemBuilder: (context, index) {
                        return PatientInfoCard(
                          patient: patientList[index],
                        );
                      },
                      shrinkWrap: true,
                      itemCount: patientList.length,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
