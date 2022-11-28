import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tib_talash/constants.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:tib_talash/screens/user_screens/widgets/doctor_timebubble.dart';

late String selected_time;
final _firestore = FirebaseFirestore.instance;
int fee = 0;
DateTime current_Day = DateTime.now();
String day_name = DateFormat('EEEE').format(current_Day);
late String doc_email;
late String doc_name;

class DoctorCard extends StatelessWidget {

  DoctorCard(this.ID);
  final String ID;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primColor,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back, size: 30.0, color: Colors.white)),
        title: Padding(
          padding: const EdgeInsets.only(right: 40.0),
          child: Center(child: Text('Doctor\'s Details'),),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    main_Data(ID),
                    SizedBox(
                      height: 30.0,
                    ),
                  appointment_Details(ID),
                  ]
                ),
              ),
            ),
          )
      ),
    );
  }
}


class main_Data extends StatelessWidget {

  main_Data(this.id);
  final String id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('doctors_data').doc(id).snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightGreen,
              ),
            );
          }
          List<DoctorDetailBubble> doctordetailbubble = [];
          final data = snapshot.data!;
          doc_name = data['firstname'] + ' ' + data['lastname'];
          final specialization = data['specialization'];
          final exp = data['experience'];
          final hospital_name = data['hospital'];
          final languages = data['languages'];
          fee = data['fee'];
          doc_email = data['email'];
          final Doctordetail = DoctorDetailBubble(
              doc_name,
              specialization,
              exp,
            hospital_name,
            languages.join(", ")
          );
          doctordetailbubble.add(Doctordetail);
          return Row(
            children: doctordetailbubble,
          );
        }
    );
  }
}

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
          final time = timeFormat.format(DateTime.parse(sttime)) + " - " + timeFormat.format(DateTime.parse(entime));
          for(var day in data['days']){
            if(day_name == day){
              day_check = true;
            }
            var spl = day.split('${day[3]}');
            arr.add(spl[0]);
          }
          for(var t in data['time_intervals']){
            timebubble.add(TimeBubble(t));
            times.add(t);
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                      child: Text(
                        'Appointment Details: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),)),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Days Available:", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                      Text("${arr.join(", ")}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    height: 10.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Fee:", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                      Text("$fee", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    height: 10.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Timings:", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),),
                      Text("$time", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    height: 10.0,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Column(
                    children: day_check ? [Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Make An Appointment:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                    ),
                      SizedBox(
                        height: 13.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Available Timings:',
                          style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Wrap(
                        children: timebubble
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      ElevatedButton(
                        child: Text(
                          'Make An Appointment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: primColor,

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
                                  child: Text(
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
                                          DialogButton(child: Text(
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