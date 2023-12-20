// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:winhealth_admin/models/user_model.dart';
import 'package:winhealth_admin/screens/auth/login_screen.dart';
import 'package:winhealth_admin/screens/doctor_home_landing.dart';
import 'package:winhealth_admin/services/auth_service.dart';
import 'package:winhealth_admin/services/base_service.dart';

class InitialRouter extends StatefulWidget {
  const InitialRouter({super.key});

  @override
  State<InitialRouter> createState() => _InitialRouterState();
}

class _InitialRouterState extends State<InitialRouter> {
  @override
  void initState() {
    super.initState();
    runInitFunc();
  }

  runInitFunc() async {
    await Future.delayed(const Duration(seconds: 1), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? isLogin = prefs.getBool('isLogin');
      if (isLogin == null || isLogin == false) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        UserModel? currentUser = await BaseService.getCurrentUser();
        if (currentUser!.userType == "doctor") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LandingScreen(),
            ),
          );
        }  else {
          Fluttertoast.showToast(msg: "Not a valid user type");
          await AuthService.logOut(context);
          // logout
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
