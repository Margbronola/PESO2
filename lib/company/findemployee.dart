import 'package:flutter/material.dart';
import 'package:peso/global/container.dart';
import 'package:peso/global/widget.dart';

class FindEmployeePage extends StatefulWidget {
  const FindEmployeePage({super.key});

  @override
  State<FindEmployeePage> createState() => _FindEmployeePageState();
}

class _FindEmployeePageState extends State<FindEmployeePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print(uid);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            MyWidget().text(
              label: "APPLICANT FORM",
              size: 18,
              weight: FontWeight.bold,
              letterSpacing: 2,
              align: TextAlign.center
            ),

            Container(
              height: size.height *.04,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}