import 'package:flutter/material.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage({super.key});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        foregroundColor: Colors.black, 
        elevation: 0,  
      ),
      // PreferredSize(
      //           preferredSize: const Size.fromHeight(150),
      //           child: AppBar(
      //   // backgroundColor: Colors.white,
      //   flexibleSpace: Container(
      //     decoration: const BoxDecoration(
      //       image: DecorationImage(
      //         image: AssetImage('assets/images/bg.png'),
      //         fit: BoxFit.cover,
      //         // opacity: 0.5
      //       ),
      //     ),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   foregroundColor: Colors.black, 
      //   elevation: 0,   
      // ),
      // ),
      body: Container(
        color: Colors.grey.shade100,
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            const Text("JOB OFFER", 
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),

            Container(
              width: size.width,
              height: 100,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Company Name",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        Text("Address",
                          style: TextStyle(
                            fontStyle: FontStyle.italic
                          ),
                        )
                      ],
                    )
                  ),
                  
                ],
              ),
            ),

            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                borderRadius:  BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("About the Job",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),

            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                borderRadius:  BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Qualification",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                ],
              ),
            ),

            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                borderRadius:  BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Company Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ),
                  ),
                  
                  SizedBox(
                    height: 10,
                  ),

                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}