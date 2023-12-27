import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:winhealth_admin/components/activity_info_card.dart';
import 'package:winhealth_admin/models/activity.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/services/activity_service.dart';
import 'package:winhealth_admin/utils/constants.dart';

class ActivityInfo extends StatefulWidget {
  final UserModel patient;
  const ActivityInfo({super.key, required this.patient});

  @override
  State<ActivityInfo> createState() => _ActivityInfoState();
}

class _ActivityInfoState extends State<ActivityInfo> {
  ScrollController scrollController = ScrollController();
  bool showbtn = false;
  DateTime? currentDate = DateTime.now();

  bool isLoadingActivities = false;
  List<ActivityItem> dayActivityList = [];
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
      isLoadingActivities = true;
    });
    dayActivityList = await ActivityService.getActivitiesByUserIDandDate(
        widget.patient.id!, DateFormat('yyyy-MM-dd').format(currentDate!));
    setState(() {
      isLoadingActivities = false;
    });
  }

  bool loading = false;
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
                    Row(
                      children: [
                        const BackButton(),
                        const SizedBox(
                          width: 32,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${widget.patient.firstName}'s Activity Info",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 64,
                        ),
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
                      height: 16,
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return ActivityInfoCard(activityItem: dayActivityList[index],);
                      },
                      itemCount: dayActivityList.length,
                      shrinkWrap: true,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
