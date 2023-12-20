import 'package:flutter/material.dart';

class ProfileHome extends StatefulWidget {
  const ProfileHome({super.key});

  @override
  State<ProfileHome> createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Comming Soon ...")),
    );
  }
}