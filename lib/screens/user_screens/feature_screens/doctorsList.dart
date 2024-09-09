import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tib_talash/helpers/constants.dart';
import 'package:tib_talash/screens/user_screens/feature_screens/doctorCard.dart';

final _firestore = FirebaseFirestore.instance;

class DoctorsList extends StatelessWidget {
  static const doctorsListID = "doctorsList_screen";
  final String type;
  const DoctorsList(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListStream(type),
      ),
    );
  }
}
class ListStream extends StatelessWidget {

  final String type;
  const ListStream(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("doctors_data").snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightGreen,
              ),
            );
          }
          final doctors = snapshot.data!.docs;
          List<DoctorBubble> doctorBubble = [];
          for(var doctor in doctors){
            final specialization = doctor.get('specialization');
            if(specialization == type) {
              final doctorFirstName = doctor.get('firstname');
              final doctorLastName = doctor.get('lastname');
              final doctorEmail = doctor.get('email');
              final doctorbubble = DoctorBubble(
                doctorFirstName,
                doctorLastName,
                specialization,
                doctorEmail
              );
              doctorBubble.add(doctorbubble);
            }
          }
          return ListView(
            children: doctorBubble,
          );
        }
    );
  }
}


class DoctorBubble extends StatelessWidget {

  const DoctorBubble(this.firstName, this.lastName, this.specialization, this.email, {super.key});

  final String firstName;
  final String lastName;
  final String specialization;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 3.0,
        color: Colors.white60,
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          height: 100,
          onPressed: (){
            filterEmail = email;
           Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorCard(filterEmail)));
          },
            child: Row(
              children: [
                const Icon(Icons.account_circle,size: 60.0,),
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dr. $firstName $lastName', style: const TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 7.0,
                    ),
                    Text(specialization, style: const TextStyle(fontSize: 18.0, color: Colors.black45, fontWeight: FontWeight.w600),)
                  ],
                )
              ],
            ),
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {

  const DoctorCard(this.id, {super.key});
  final String id;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primColor,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back, size: 25.0, color: Colors.white)),
        title: const Text('Doctor\'s Details', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 28),),
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
                      MainData(id),
                      const SizedBox(
                        height: 30.0,
                      ),
                      appointment_Details(id),
                    ]
                ),
              ),
            ),
          )
      ),
    );
  }
}


class MainData extends StatelessWidget {

  const MainData(this.id, {super.key});
  final String id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('doctors_data').doc(id).snapshots(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(
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
          final hospitalName = data['hospital'];
          final languages = data['languages'];
          fee = data['fee'];
          doc_email = data['email'];
          final doctorDetail = DoctorDetailBubble(
              doc_name,
              specialization,
              exp,
              hospitalName,
              languages.join(", ")
          );
          doctordetailbubble.add(doctorDetail);
          return Row(
            children: doctordetailbubble,
          );
        }
    );
  }
}