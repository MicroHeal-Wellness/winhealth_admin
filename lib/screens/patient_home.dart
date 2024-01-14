import 'package:flutter/material.dart';
import 'package:winhealth_admin/components/patient_info_card.dart';
import 'package:winhealth_admin/models/answer.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/services/patient_service.dart';
import 'package:winhealth_admin/utils/constants.dart';

class PatientHome extends StatefulWidget {
  final UserModel currentUser;
  const PatientHome({super.key, required this.currentUser});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  bool showNotes = false;
  bool loading = false;
  List<UserModel> patientList = [];
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
    patientList = await PatientService.getPatients();
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
                        crossAxisCount: MediaQuery.of(context).size.width > 1800
                            ? 3
                            : MediaQuery.of(context).size.width > 1200
                                ? 2
                                : 1,
                        childAspectRatio:
                            MediaQuery.of(context).size.width > 600 ? 1 : 0.8,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        return PatientInfoCard(
                          patient: patientList[index],
                          currentUser: widget.currentUser,
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
