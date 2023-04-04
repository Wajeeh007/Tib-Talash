import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tib_talash/constants.dart';
import 'package:tib_talash/screens/user_screens/feature_screens/doctorCard.dart';

final _firestore = FirebaseFirestore.instance;

class doctorsList extends StatelessWidget {
  static const doctorsListID = "doctorsList_screen";
  final String Type;
  doctorsList(this.Type);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: listStream(Type),
      ),
    );
  }
}
class listStream extends StatelessWidget {

  final String type;
  listStream(this.type);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("doctors_data").snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
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

  DoctorBubble(this.firstName, this.lastName, this.specialization, this.Email);

  final String firstName;
  final String lastName;
  final String specialization;
  final String Email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Material(
        elevation: 3.0,
        color: Colors.white60,
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          height: 100,
          onPressed: (){
            filterEmail = Email;
           Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorCard(filterEmail)));
          },
            child: Row(
              children: [
                Icon(Icons.account_circle,size: 60.0,),
                SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dr. $firstName $lastName', style: TextStyle(fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: 7.0,
                    ),
                    Text('$specialization', style: TextStyle(fontSize: 18.0, color: Colors.black45, fontWeight: FontWeight.w600),)
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