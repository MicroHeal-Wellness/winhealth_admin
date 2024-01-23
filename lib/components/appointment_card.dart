import 'package:flutter/material.dart';
import 'package:winhealth_admin/models/appointment.dart';
import 'package:winhealth_admin/utils/constants.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final bool isSelected;
  const AppointmentCard(
      {super.key, required this.appointment, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.2) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.withOpacity(0.4),
          )),
      padding: EdgeInsets.all(16-size.width*0.001),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ID: ${appointment.id!}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Appointment for: ${appointment.userCreated!.firstName} ${appointment.userCreated!.lastName}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Time: ${appointment.slot!.startTime} - ${appointment.slot!.endTime}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Status: ${appointment.slot!.status}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
                        const Text(
                "\n**click to see patient info",
                softWrap: true,
                // overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
          Row(
            children: [
              // const Text(
              //   "\n**click to see patient info",
              //   softWrap: true,
              //   overflow: TextOverflow.ellipsis,
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),
              // const Spacer(),
              (appointment.slot!.status == "booked" &&
                      DateTime(
                        appointment.slot!.date!.year,
                        appointment.slot!.date!.month,
                        appointment.slot!.date!.day,
                        int.parse(
                            appointment.slot!.startTime!.split(":").first),
                        int.parse(
                          appointment.slot!.startTime!.split(":")[1],
                        ),
                      ).isBefore(DateTime.now()) &&
                      DateTime(
                        appointment.slot!.date!.year,
                        appointment.slot!.date!.month,
                        appointment.slot!.date!.day,
                        int.parse(appointment.slot!.endTime!.split(":").first),
                        int.parse(
                          appointment.slot!.endTime!.split(":")[1],
                        ),
                      ).isAfter(DateTime.now()))
                  ? MaterialButton(
                      onPressed: () {},
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Join Call",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ],
      ),
    );
  }
}
