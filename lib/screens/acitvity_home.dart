import 'package:flutter/material.dart';

class ActivityHome extends StatefulWidget {
  const ActivityHome({super.key});

  @override
  State<ActivityHome> createState() => _ActivityHomeState();
}

class _ActivityHomeState extends State<ActivityHome> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Comming Soon ...")),
    );
  }
}