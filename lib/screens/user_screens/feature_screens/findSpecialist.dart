import 'package:flutter/material.dart';
import 'package:tib_talash/helpers/constants.dart';

import '../../../helpers/custom_widgets/specialist_button.dart';

class findSpecialist extends StatelessWidget {
  static const findSpecialistID = "findSpecialist_screen";

  const findSpecialist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
        ),
        backgroundColor: primColor,
        centerTitle: true,
        leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25,)),
        title: const Text('Find Your Specialist', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w600),),
      ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Container(
                  //   height: 60.0,
                  //   decoration: const BoxDecoration(
                  //       color: primColor,
                  //       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
                  //   ),
                  //   child: const Padding(
                  //     padding: EdgeInsets.all(10.0),
                  //     child: Center(
                  //       child: Text(
                  //         'Find Your Specialist',
                  //         style: TextStyle(
                  //           fontSize: 25.0,
                  //           fontWeight: FontWeight.bold,
                  //           fontFamily: 'Ubuntu',
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 13.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.1,
                              mainAxisSpacing: 3.5,
                              crossAxisSpacing: 4.5

                          ),
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemCount: specialist_list.length,
                          itemBuilder: (context, index){
                            var specialistType = specialist_list[index];
                            return specialistTypeButton(specialistType.type, specialistType.desc);
                          }
                      )
                  ),
                ]
            )
        )
    );
  }
}