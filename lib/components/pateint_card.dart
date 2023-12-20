import 'package:flutter/material.dart';
import 'package:winhealth_admin/models/patient.dart';
import 'package:winhealth_admin/utils/constants.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final bool isSelected;
  const PatientCard(
      {super.key, required this.patient, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? primaryColor.withOpacity(0.2) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ID: ${patient.user!.id}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Name: ${patient.user!.firstName} ${patient.user!.lastName}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Gender: ${patient.user!.gender}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              patient.user!.emailId.toString().contains("@winhealth.com")
                  ? const SizedBox()
                  : Text(
                      "Email: ${patient.user!.emailId}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
              patient.user!.emailId.toString().contains("@winhealth.com")
                  ? Text(
                      "Phone: ${patient.user!.emailId!.split("@winhealth.com").first}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DOB: ${patient.user!.dob.toString().split(' ').first}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Diet: ${patient.diet}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Height: ${patient.height}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Weight: ${patient.weight}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              patient.isPregnant!
                  ? const Text(
                      "Pregnent",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
