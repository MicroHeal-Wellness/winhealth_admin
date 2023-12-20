import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winhealth_admin/components/side_bar_item.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/provider/sidebar_provvider.dart';
import 'package:winhealth_admin/screens/appointment_home.dart';
import 'package:winhealth_admin/screens/patient_home.dart';
import 'package:winhealth_admin/screens/profile_home.dart';
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
        return AppointmentHome(currentUser: currentUser!);
      case 1:
        return const PatientHome();
      case 2:
        return const ProfileHome();
      case 3:
        return SlotsHome(currentUser: currentUser!);
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
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "images/logo_new.png",
                                  height: 50,
                                ),
                                const SizedBox(
                                  width: 32,
                                ),
                                const Text(
                                  "Winhealth",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: Text(
                              "Doctor's Dashboard",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8),
                            child: Text(
                              "Dr. ${currentUser!.firstName}",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(
                            endIndent: 16,
                            indent: 16,
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
                            iconData: Icons.people_alt,
                            title: "Patients",
                          ),
                          const SideBarItem(
                            pageKey: 2,
                            iconData: Icons.settings,
                            title: "Profile",
                          ),
                          const SideBarItem(
                            pageKey: 3,
                            iconData: Icons.add_box,
                            title: "Slots",
                          ),
                          const SideBarItem(
                            pageKey: 4,
                            isDisabled: true,
                            iconData: Icons.logout,
                            title: "Logout",
                          ),
                        ],
                      ),
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
