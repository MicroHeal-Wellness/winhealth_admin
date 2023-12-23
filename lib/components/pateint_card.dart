import 'package:flutter/material.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/utils/constants.dart';

class PatientCard extends StatelessWidget {
  final UserModel patient;
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
                "ID: ${patient!.id}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Name: ${patient!.firstName} ${patient!.lastName}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Gender: ${patient!.gender}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              patient!.email.toString().contains("@winhealth.com")
                  ? const SizedBox()
                  : Text(
                      "Email: ${patient!.email}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
              patient!.email.toString().contains("@winhealth.com")
                  ? Text(
                      "Phone: ${patient!.email!.split("@winhealth.com").first}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DOB: ${patient!.dob.toString().split(' ').first}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Diet: ${patient.diet}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Height: ${patient.height}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Weight: ${patient.weight}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              patient.pregnant!
                  ? const Text(
                      "Pregnent",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
