import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/companylanding.dart';
import 'package:peso/findemployee.dart';
import 'package:peso/global/container.dart';
import 'package:peso/global/datacacher.dart';
import 'package:peso/employeelanding.dart';
import 'package:peso/landing.dart';
import 'package:peso/login.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final DataCacher _cacher = DataCacher.instance;

  checker() async {
    String? d = _cacher.token;

    if (d == null) {
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: const LandingPage(),
          type: PageTransitionType.fade,
        ),
      );
    } else {
      setState(() {
        accesstoken = d;
      });
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: EmployeeLandingPage(isfromemployee: true,),
          type: PageTransitionType.fade,
        ),
      );
    }
  }

  @override
  void initState() {
    checker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 21, 32, 146),
          ),
        ),
      ),
    );
  }
}
