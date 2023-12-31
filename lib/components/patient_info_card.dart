import 'package:flutter/material.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/screens/activity_info.dart';
import 'package:winhealth_admin/screens/activity_stats.dart';
import 'package:winhealth_admin/screens/diet_home.dart';
import 'package:winhealth_admin/screens/foms_home.dart';
import 'package:winhealth_admin/screens/notes_home.dart';
import 'package:winhealth_admin/screens/report_home.dart';
import 'package:intl/intl.dart';
import 'package:winhealth_admin/services/activity_service.dart';

class PatientInfoCard extends StatefulWidget {
  final UserModel patient;
  const PatientInfoCard({super.key, required this.patient});

  @override
  State<PatientInfoCard> createState() => _PatientInfoCardState();
}

class _PatientInfoCardState extends State<PatientInfoCard> {
  List statuses = [];

  @override
  void initState() {
    super.initState();
    getInitData();
  }

  getInitData() async {
    List<DateTime> days = [];
    final now = DateTime.now();
    final int currentDay = now.weekday;
    final DateTime firstDayOfWeek =
        now.subtract(Duration(days: currentDay - 1));
    days = List.generate(7, (index) {
      final DateTime date = firstDayOfWeek.add(Duration(days: index));
      return date;
    });
    // statuses = days.map((date) => {"date": date, "status": 1}).toList();
    for (int i = 0; i < days.length; i++) {
      int val = await ActivityService.getActivityCount(
        widget.patient.id!,
        DateFormat('yyyy-MM-dd').format(days[i]),
      );
      print(val);
      statuses.add({
        "date": days[i],
        "status": val == 0
            ? 1
            : val < 6
                ? 2
                : 3
      });
    }
    print(statuses);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Patient Info",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                MenuAnchor(
                  builder: (BuildContext context, MenuController controller,
                      Widget? child) {
                    return IconButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      icon: const Icon(Icons.more_horiz),
                      tooltip: 'Show menu',
                    );
                  },
                  menuChildren: [
                    MenuItemButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ActivityInfo(
                              patient: widget.patient,
                            ),
                          ),
                        );
                      },
                      child: const Text('Activity Info'),
                    ),
                    MenuItemButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ActivityStats(
                              patient: widget.patient,
                            ),
                          ),
                        );
                      },
                      child: const Text('Activity Stats'),
                    ),
                    MenuItemButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DietHome(
                              patient: widget.patient,
                            ),
                          ),
                        );
                      },
                      child: const Text('Diet Plan'),
                    ),
                    MenuItemButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NotesHome(
                              patient: widget.patient,
                            ),
                          ),
                        );
                      },
                      child: const Text('Notes'),
                    ),
                    MenuItemButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FormsHome(
                              patient: widget.patient,
                            ),
                          ),
                        );
                      },
                      child: const Text('Patient Forms'),
                    ),
                    MenuItemButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ReportHome(
                              patient: widget.patient,
                            ),
                          ),
                        );
                      },
                      child: const Text('Uploads'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "Name: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.patient.firstName} ${widget.patient.lastName}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "Email: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.patient.emailAddress == null
                      ? widget.patient.emailAddress!
                      : widget.patient.email!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "Phone: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "+91 ${widget.patient.phoneNumber}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "DOB: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.patient.dob!.toString().split(" ").firstOrNull}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "Height: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.patient.height} CM",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "Weight: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.patient.weight} KG",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "Gender: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.patient.gender}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "Exercise: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.patient.exerciseType}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            widget.patient.gender!.toLowerCase() == "female"
                ? const SizedBox(
                    height: 8,
                  )
                : const SizedBox(),
            widget.patient.gender!.toLowerCase() == "female"
                ? Row(
                    children: [
                      const Text(
                        "Pregnant: ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${widget.patient.pregnant}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "Diet: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.patient.diet}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  "App Form Status: ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.patient.appFormAanswered!
                      ? "Answered"
                      : "Not yet answered",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 8,
            // ),
            // Row(
            //   children: [
            //     const Text(
            //       "Id: ",
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     Text(
            //       "${widget.patient.id}",
            //       style: const TextStyle(
            //         fontSize: 14,
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                statuses.length,
                (index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: statuses[index]['status'] == 3
                        ? Border.all(color: Colors.green, width: 2)
                        : statuses[index]['status'] == 2
                            ? Border.all(color: Colors.blue, width: 2)
                            : Border.all(color: Colors.black, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('EE').format(statuses[index]['date']),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          DateFormat('dd/MM').format(statuses[index]['date']),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
