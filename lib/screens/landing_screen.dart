import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winhealth_admin/components/side_bar_item.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/provider/sidebar_provvider.dart';
import 'package:winhealth_admin/screens/appointment_home.dart';
import 'package:winhealth_admin/screens/doctor_home.dart';
import 'package:winhealth_admin/screens/not_allowed.dart';
import 'package:winhealth_admin/screens/patient_home.dart';
import 'package:winhealth_admin/screens/access_management_home.dart';
import 'package:winhealth_admin/screens/slots_home.dart';
import 'package:winhealth_admin/services/base_service.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  UserModel? currentUser;
  bool loading = false;
  screenSwitcher(int index) {
    switch (index) {
      case 0:
        return currentUser!.access != null &&
                currentUser!.access!.permission!.contains("appointment")
            ? AppointmentHome(currentUser: currentUser!)
            : const NotAllowed();
      case 1:
        return currentUser!.access != null &&
                currentUser!.access!.permission!.contains("slots")
            ? SlotsHome(currentUser: currentUser!)
            : const NotAllowed();
      case 2:
        return currentUser!.access != null &&
                currentUser!.access!.permission!.contains("patients")
            ? PatientHome(currentUser: currentUser!)
            : const NotAllowed();
      case 3:
        return currentUser!.access != null &&
                currentUser!.access!.permission!.contains("doctors")
            ? DoctorHome(currentUser: currentUser!)
            : const NotAllowed();
      case 4:
        return currentUser!.access != null &&
                currentUser!.access!.permission!.contains("accessmangement")
            ? const AccessMangementHome()
            : const NotAllowed();
      default:
        return AppointmentHome(currentUser: currentUser!);
    }
  }

  @override
  void initState() {
    super.initState();
    getInitData();
  }

  getInitData() async {
    setState(() {
      loading = true;
    });
    currentUser = await BaseService.getCurrentUser();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade400,
                      ),
                    ),
                    padding: MediaQuery.of(context).size.width > 1600
                        ? const EdgeInsets.all(12.0)
                        : const EdgeInsets.all(2),
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.004,
                              vertical: size.width * 0.002),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/logo_new.png",
                                height: MediaQuery.of(context).size.width > 1600
                                    ? 50-size.width*0.001
                                    : 36-size.width*0.005,
                              ),
                              MediaQuery.of(context).size.width > 1600
                                  ? const SizedBox(
                                      width: 32,
                                    )
                                  : const SizedBox(),
                              MediaQuery.of(context).size.width > 1600
                                  ? const Text(
                                      "Winhealth",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                        MediaQuery.of(context).size.width > 1600
                            ? const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8),
                                child: Text(
                                  "Doctor's Dashboard",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : const SizedBox(),
                        MediaQuery.of(context).size.width > 1600
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8),
                                child: Text(
                                  "Dr. ${currentUser!.firstName}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : const SizedBox(),
                         Divider(
                          endIndent: size.width*0.01,
                          indent:size.width*0.01,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const SideBarItem(
                          pageKey: 0,
                          iconData: Icons.alarm,
                          title: "Appointments",
                        ),
                        const SideBarItem(
                          pageKey: 1,
                          iconData: Icons.add_box,
                          title: "Slots",
                        ),
                        const SideBarItem(
                          pageKey: 2,
                          iconData: Icons.people_alt,
                          title: "Patients",
                        ),
                        const SideBarItem(
                          pageKey: 3,
                          iconData: Icons.people_alt,
                          title: "Doctors",
                        ),
                        const SideBarItem(
                          pageKey: 4,
                          iconData: Icons.settings,
                          title: "Access",
                        ),
                        const SideBarItem(
                          pageKey: 5,
                          isDisabled: true,
                          iconData: Icons.logout,
                          title: "Logout",
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 11,
                  child: screenSwitcher(
                      context.watch<SideBarProvider>().currentPage),
                )
              ],
            ),
    );
  }
}
