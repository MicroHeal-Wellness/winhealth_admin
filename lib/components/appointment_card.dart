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
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withOpacity(0.2) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ID: ${appointment.id!}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Appointment for: ${appointment.user!.firstName} ${appointment.user!.lastName}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Time: ${appointment.slot!.startTime}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Status: ${appointment.status}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
