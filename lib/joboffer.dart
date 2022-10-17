

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:peso/findemployee.dart';
import 'package:peso/findjob.dart';
import 'package:peso/jobdetails.dart';

class JobOfferPage extends StatefulWidget {
  bool isfromemployee;

  JobOfferPage({Key? key, required this.isfromemployee}):super(key: key);

  @override
  State<JobOfferPage> createState() => _JobOfferPageState();
}

class _JobOfferPageState extends State<JobOfferPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(right: 20, top: 7, bottom: 7),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
            ),
            child: IconButton(
              onPressed: (){
                if(widget.isfromemployee == true){
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const FindJobPage(),
                      type: PageTransitionType.fade
                    )
                  );
                }
                else{
                  Navigator.push(
                    context,
                    PageTransition(
                      child: const FindEmployeePage(),
                      type: PageTransitionType.fade
                    )
                  );
                }
              }, 
              icon: const Icon(Icons.person_rounded)
            ),
          )
        ],
        elevation: 0,
      ),

      body: SafeArea(
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height * .07,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                child: Expanded(
                  child: TextField(
                    onChanged: (value) {
                            // setState(() {
                            //   searchString = value.toLowerCase();
                            // });
                    },

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:BorderSide(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      hintText: 'Search job offer',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIconConstraints: const BoxConstraints(
                        maxHeight: double.maxFinite,
                      ),
                      suffixIcon:  Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
      
                        child: const Icon(Icons.search_rounded, color: Colors.grey),
                      )
                    ),
                  ),
                ),
              ),

              Container(
                width: size.width,
                height: size.height * .3,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Suggested Jobs",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 18
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            
                          },
                          child: Text("See more",
                            style: TextStyle(
                              letterSpacing: .5,
                              fontSize: 16,
                              color: Colors.grey.shade400
                            ),
                          ),
                        ),
                      ],
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const JobDetailsPage(),
                              type: PageTransitionType.fade
                            )
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (_, index) {
                              return Container(
                                width: size.width *.7,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                                  color: Colors.grey.shade200,
                                ),
                              );
                            }
                          )
                        ),
                      ),
                    )
                  ],
                ),
              ),
              
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Popular Jobs",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            fontSize: 18
                          ),
                        ),

                        GestureDetector(
                          onTap: (){
                            
                          },
                          child: Text("See more",
                            style: TextStyle(
                              letterSpacing: .5,
                              fontSize: 16,
                              color: Colors.grey.shade400
                            ),
                          ),
                        ),
                      ],
                    ),

                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: 5,
                            itemBuilder: (BuildContext ctx, int index){
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: const JobDetailsPage(),
                                      type: PageTransitionType.fade
                                    )
                                  );
                                },
                                child: Container(
                                  width: size.width,
                                  height: size.height *.15,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                                    color: Colors.grey.shade100,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        height: size.height * .3,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Colors.black12,
                                        ),
                                        margin: const EdgeInsets.only(right: 10),
                                      ),
                                        
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 5),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Company Name".toUpperCase(), 
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey
                                                ),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            
                                              SizedBox(
                                                height: size.height * .009,
                                              ),
                                            
                                              const Text("Company job vacancy",
                                                textAlign: TextAlign.center,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) => const Divider(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}