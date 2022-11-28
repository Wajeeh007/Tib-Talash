import 'package:flutter/material.dart';
import 'package:tib_talash/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/doneappointment_bubble.dart';
import 'widgets/upcomingappointment_bubble.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
enum selected_view {
  upcoming,
  done,
}

selected_view selection = selected_view.upcoming;

class dr_homePage extends StatefulWidget {
  static const dr_homePageID = "dr_homepage_screen";

  @override
  State<dr_homePage> createState() => _dr_homePageState();
}

class _dr_homePageState extends State<dr_homePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFf9f9e3),
        body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(const Radius.circular(40.0)),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade400
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const TextButton(
                            onPressed: null,
                            child: Icon(
                              Icons.view_headline,
                              size: 30.0,
                              color: Colors.grey,
                            ),
                          ),
                          const Text('Tib Talash',
                              style: kHomeTitleTextStyle
                          ),
                          const TextButton(
                            onPressed: null,
                            child: const Icon(Icons.account_circle,
                              size: 25.0,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                upcoming_appointments(),
              ],
            )
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    setState((){
                      selection = selected_view.upcoming;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: selection == selected_view.upcoming ? Colors.white:primColor,
                      border: Border.all(
                        color: selection == selected_view.upcoming? Colors.grey:primColor,
                      )
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.list_alt_outlined,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap:() {
                    setState((){
                      selection = selected_view.done;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: selection == selected_view.done ? Colors.white:primColor,
                        border: Border.all(
                          color: selection == selected_view.done? Colors.grey:primColor,
                        )
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.check_box,
                        size: 40.0,
                        color: Colors.grey
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}

class upcoming_appointments extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('doctors_data').doc(Myid).collection('appointments').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Column(
                children: [
                  const Text('Fetching data ...'),
                  const SizedBox(
                    height: 3.0,
                  ),
                  const CircularProgressIndicator(
                    backgroundColor: primColor,
                  )
                ],
              ),
            );
          }
          else if(snapshot.data?.size == 0){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: AssetImage('images/no_appointment.png'), height: 95, width: 95,),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  selection == selected_view.upcoming ? 'No Appointments made yet' : 'No History of any Appointments',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu'
                  ),
                )
              ],
            );
          }
          final up_appointments = snapshot.data!.docs;
          List<UpAppointmentBubble> up_Appointment_bubble = [];
          List<DoneAppointmentBubble> done_Appointment_bubble = [];
          for(var u in up_appointments) {
            final status = u.get('appointment_status');
            if (status == false) {
              final appointment_time = u.get('appointment_time');
              final patient_name = u.get('patient_name');
              final gender = u.get('gender');
              final patient_pic = u.get('picture');
              final age = u.get('age');
              final uid = u.get('uid');
              final message = u.get('message');
              final appointment_bubble = UpAppointmentBubble(
                  appointment_time,
                  patient_name,
                  age,
                  gender,
                  patient_pic,
                  uid,
                  message
              );
              up_Appointment_bubble.add(appointment_bubble);
            }
            else {
              final appointment_time = u.get('appointment_time');
              final patient_name = u.get('patient_name');
              final gender = u.get('gender');
              final patient_pic = u.get('picture');
              final age = u.get('age');
              final appointment_bubble = DoneAppointmentBubble(
                  appointment_time,
                  patient_name,
                  age,
                  gender,
                  patient_pic
              );
              done_Appointment_bubble.add(appointment_bubble);
            }
          }
          return Column(
            children: [
              Text(
                selection == selected_view.upcoming ? 'Upcoming Appointments' : 'Done Appointments',
                style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu'
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              ListView(
                shrinkWrap: true,
                children: selection == selected_view.upcoming? up_Appointment_bubble:done_Appointment_bubble
              ),
            ],
          );
        }
    );
  }
}