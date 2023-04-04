import 'package:flutter/material.dart';
import 'package:tib_talash/constants.dart';
import 'package:tib_talash/screens/user_screens/widgets/specialist_button.dart';

class findSpecialist extends StatelessWidget {
  static const findSpecialistID = "findSpecialist_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: primColor,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            'Find Your Specialist',
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 13.0,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.1,
                                mainAxisSpacing: 3.5,
                                crossAxisSpacing: 4.5

                            ),
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: specialist_list.length,
                            itemBuilder: (context, index){
                              var specialistType = specialist_list[index];
                              return specialistTypeButton(specialistType.type, specialistType.desc);
                            }
                        )
                    ),
                  ]
              )
          ),
        )
    );
  }
}