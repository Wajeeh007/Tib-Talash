import 'package:flutter/material.dart';
import 'package:tib_talash/helpers/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets/doneappointment_bubble.dart';
import 'widgets/upcomingappointment_bubble.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
enum SelectedView {
  upcoming,
  done,
}

SelectedView selection = SelectedView.upcoming;

class DrHomePage extends StatefulWidget {
  static const dr_homePageID = "dr_homepage_screen";

  const DrHomePage({super.key});

  @override
  State<DrHomePage> createState() => _DrHomePageState();
}

class _DrHomePageState extends State<DrHomePage> {

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
                      borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade400
                      )
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                            onPressed: null,
                            child: Icon(
                              Icons.view_headline,
                              size: 30.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text('Tib Talash',
                              style: kHomeTitleTextStyle
                          ),
                          TextButton(
                            onPressed: null,
                            child: Icon(Icons.account_circle,
                              size: 35.0,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const UpcomingAppointments(),
              ],
            )
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          height: 60,
          padding: EdgeInsets.zero,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: selection == SelectedView.upcoming ? Colors.white:primColor,
                    border: Border.all(
                      color: selection == SelectedView.upcoming? Colors.grey:primColor,
                    )
                  ),
                  child: GestureDetector(
                    onTap: (){
                      setState((){
                        selection = SelectedView.upcoming;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.list_alt_outlined,
                        size: 40,
                        color: selection == SelectedView.upcoming ? Colors.grey : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: selection == SelectedView.done ? Colors.white:primColor,
                      border: Border.all(
                        color: selection == SelectedView.done? Colors.grey:primColor,
                      )
                  ),
                  child: GestureDetector(
                    onTap:() {
                      setState((){
                        selection = SelectedView.done;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.check_box,
                        size: 40.0,
                        color: selection == SelectedView.done ? Colors.grey : Colors.white
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

class UpcomingAppointments extends StatelessWidget {
  const UpcomingAppointments({super.key});
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('doctors_data').doc(myId).collection('appointments').snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Expanded(
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: primColor,
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text('Fetching data ...', style: TextStyle(color: Colors.grey, fontSize: 18),),
                  ],
                ),
              ),
            );
          }
          else if(snapshot.data?.size == 0){
            return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage('images/no_appointment.png'), height: 95, width: 95,),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      selection == SelectedView.upcoming ? 'No Appointments made yet' : 'No History of any Appointments',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu'
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          final upAppointments = snapshot.data!.docs;
          List<UpAppointmentBubble> upAppointmentBubble = [];
          List<DoneAppointmentBubble> doneAppointmentBubble = [];
          for(var u in upAppointments) {
            final status = u.get('appointment_status');
            if (status == false) {
              final appointmentTime = u.get('appointment_time');
              final patientTime = u.get('patient_name');
              final gender = u.get('gender');
              final patientPic = u.get('picture');
              final age = u.get('age');
              final uid = u.get('uid');
              final message = u.get('message');
              final appointmentBubble = UpAppointmentBubble(
                  appointmentTime,
                  patientTime,
                  age,
                  gender,
                  patientPic,
                  uid,
                  message
              );
              upAppointmentBubble.add(appointmentBubble);
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
              doneAppointmentBubble.add(appointment_bubble);
            }
          }
          return Column(
            children: [
              Text(
                selection == SelectedView.upcoming ? 'Upcoming Appointments' : 'Done Appointments',
                style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Ubuntu'
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              ListView(
                shrinkWrap: true,
                children: selection == SelectedView.upcoming? upAppointmentBubble:doneAppointmentBubble
              ),
            ],
          );
        }
    );
  }
}