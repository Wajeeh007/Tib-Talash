import 'package:flutter/material.dart';
import 'package:tib_talash/constants.dart';
import 'dart:math';

var num = Random();
class DoneAppointmentBubble extends StatelessWidget {
  DoneAppointmentBubble(this.time, this.name, this.age, this.gend, this.pic);

  final String name;
  final String gend;
  final int age;
  final String pic;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(num.nextInt(255), num.nextInt(255), num.nextInt(255), 0.6),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)
                )
            ),
            onPressed: null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 8.0),
              child: Column(
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image(
                        image: NetworkImage('$pic'), height: 40, width: 40,),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Appointment Time:',
                              style: kAppointmentDescriptionText.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0
                              )
                          ),
                          SizedBox(
                            height: 13.0,
                          ),
                          Text(
                              'Patient\'s Name:',
                              style: kAppointmentDescriptionText
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                              'Gender:',
                              style: kAppointmentDescriptionText
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                              'Age:',
                              style: kAppointmentDescriptionText
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              '$time',
                              style: kAppointmentDescriptionText.copyWith(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          SizedBox(
                            height: 13.0,
                          ),
                          Text(
                              '$name',
                              style: kAppointmentDescriptionText
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                              '$gend',
                              style: kAppointmentDescriptionText
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Text(
                              '$age',
                              style: kAppointmentDescriptionText
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}