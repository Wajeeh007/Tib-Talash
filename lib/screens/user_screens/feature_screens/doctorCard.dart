import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tib_talash/helpers/constants.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../helpers/custom_widgets/doctor_timebubble.dart';

late String selected_time;
final _firestore = FirebaseFirestore.instance;
int fee = 0;
DateTime current_Day = DateTime.now();
String day_name = DateFormat('EEEE').format(current_Day);
late String doc_email;
late String doc_name;

class appointment_Details extends StatelessWidget {

  appointment_Details(this.id);
  final String id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('doctors_data').doc(id).collection('appointment_details').doc('details').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepPurple,
              ),
            );
          }
          List<TimeBubble> timebubble =[];
          List<String> times = [];
          bool day_check = false;
          List<String> arr = [];
          final data = snapshot.data!;
          final sttime = data['start_time'].toDate().toString();
          final entime = data['end_time'].toDate().toString();
          final timeFormat = DateFormat('h:mm a');
          final time = "${timeFormat.format(DateTime.parse(sttime))} - ${timeFormat.format(DateTime.parse(entime))}";
          for(var day in data['days']){
            if(day_name == day){
              day_check = true;
            }
            var spl = day.split('${day[3]}');
            arr.add(spl[0]);
          }
          for(var t in data['time_intervals']){
            timebubble.add(TimeBubble(time: t,));
            times.add(t);
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Appointment Details: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),)),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Days Available:", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                    Text(arr.join(", "), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  height: 10.0,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Fee:", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                    Text("$fee", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  height: 10.0,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Timings:", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                    Text(time, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  height: 10.0,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Column(
                    children: day_check ? [const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Make An Appointment:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                      const SizedBox(
                        height: 13.0,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Available Timings:',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Wrap(
                          children: timebubble
                      ),
                      const SizedBox(
                        height: 7.0,
                      ),
                      ElevatedButton(
                        child: const Text(
                          'Make An Appointment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primColor,

                        ),
                        onPressed: (){
                          if(selected_time == null){
                            null;
                          }
                          Alert(
                              context: context,
                              title: "Appointment Details",
                              desc: "Doctor\'s Name: $doc_name\nTime: $selected_time\nFee: $fee",
                              buttons: [
                                DialogButton(
                                  child: const Text(
                                    'Confirm Details',
                                    style: TextStyle(
                                        color: Colors.white),),
                                  onPressed: (){
                                    // final appointment_details = {
                                    //   "appointment_time": selected_time,
                                    //   "doc_email_address": doc_email,
                                    //   "user_email_address": userEmail,
                                    //   "doctorName": doc_name
                                    // };
                                    // _firestore.collection("doctors_data").doc(
                                    //     'HleMIVy9ED8nxlFfvcq6').collection(
                                    //     'appointments').doc().set(appointment_details);
                                    // times.remove(selected_time);
                                    // _firestore.collection("doctors_data").doc(
                                    //     'HleMIVy9ED8nxlFfvcq6').collection(
                                    //     'appointment_details')
                                    //     .doc('details')
                                    //     .update({
                                    //   "time_intervals": times});
                                    Alert(
                                        context: context,
                                        title: "Appointment Made",
                                        desc: "Your Appointment has been made.\nSee the details:\nDoctor's Name: $doc_name.\nTime: $selected_time\nFee: $fee",
                                        buttons: [
                                          DialogButton(child: const Text(
                                            'Continue',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                            onPressed: (){
                                              Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                                            },
                                            width: 140,
                                          )
                                        ]
                                    ).show();
                                  },
                                  width: 140,
                                )
                              ]
                          ).show();

                        },
                      ),
                    ] : [Text(
                      'Not Available Today',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          color: Colors.red.shade600),)]
                )
              ],
            ),
          );
        }
    );
  }
}