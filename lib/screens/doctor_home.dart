import 'package:flutter/material.dart';
import 'package:winhealth_admin/components/doctor_info_card.dart';
import 'package:winhealth_admin/components/patient_info_card.dart';
import 'package:winhealth_admin/models/answer.dart';
import 'package:winhealth_admin/models/role.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/services/doctor_service.dart';
import 'package:winhealth_admin/services/patient_service.dart';
import 'package:winhealth_admin/services/role_service.dart';
import 'package:winhealth_admin/utils/constants.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  ScrollController scrollController = ScrollController();
  bool loading = false;
  bool showbtn = false;
  List<UserModel> doctorsList = [];
  List<Roles> roles = [];

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
    roles = await RoleService.fetchAllRolls();
    doctorsList = await DoctorService.getDoctors();
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
                        "All Doctors",
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
                            MediaQuery.of(context).size.width > 600 ? 2 : 1.5,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        return DoctorInfoCard(
                          doctor: doctorsList[index],
                          roles: roles,
                          callback: getInitData,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: doctorsList.length,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}