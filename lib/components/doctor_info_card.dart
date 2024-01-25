// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:winhealth_admin/models/role.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/services/doctor_service.dart';

class DoctorInfoCard extends StatefulWidget {
  final UserModel doctor;
  final UserModel currentUser;
  final Function callback;
  const DoctorInfoCard(
      {super.key,
      required this.doctor,
      required this.currentUser,
      required this.callback});

  @override
  State<DoctorInfoCard> createState() => _DoctorInfoCardState();
}

class _DoctorInfoCardState extends State<DoctorInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // ignore: prefer_const_constructors
        child: Column(children:  [
          Text(
            "",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
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
                "${widget.doctor.firstName} ${widget.doctor.lastName}",
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
                widget.doctor.emailAddress == null
                    ? widget.doctor.email!
                    : widget.doctor.emailAddress!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          // Row(
          //   children: [
          //     const Text(
          //       "Phone: ",
          //       style: TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     Text(
          //       "+91 ${widget.doctor.phoneNumber}",
          //       style: const TextStyle(
          //         fontSize: 16,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 8,
          // ),
          // Row(
          //   children: [
          //     const Text(
          //       "DOB: ",
          //       style: TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     Text(
          //       "${widget.doctor.dob!.toString().split(" ").firstOrNull}",
          //       style: const TextStyle(
          //         fontSize: 16,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(
          //   height: 8,
          // ),
          Row(
            children: [
              const Text(
                "Role: ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.doctor.access == null ? "Not yet signed" : "DTx",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ]),
      ),
    );
  }
}
