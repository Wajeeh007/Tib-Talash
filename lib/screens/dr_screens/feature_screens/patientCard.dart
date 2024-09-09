import 'package:flutter/material.dart';
import 'package:tib_talash/helpers/constants.dart';

class patient_card extends StatelessWidget {
  static const patient_cardID = "patient_card_screen";

  const patient_card(this.uid, this.patient_name, this.age, this.time, this.gender, this.ImageURL, this.msg);

  final String patient_name;
  final String gender;
  final int age;
  final String time;
  final String ImageURL;
  final String uid;
  final String msg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
        shadowColor: Colors.grey.shade800,
        backgroundColor: primColor,
        elevation: 4.0,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: Icon(Icons.arrow_back, color: Colors.white,),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Image.network(
                        '$ImageURL',
                        width: 80.0,
                        height: 80.0,
                        frameBuilder: (context, child, frame, wasSynchronouslyLoaded){
                          return child;
                        },
                        loadingBuilder: (context, child, loadingProgress){
                          if(loadingProgress == null){
                            return child;
                          }
                          else{
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.lightBlueAccent,
                              ),
                            );
                          }
                        },
                      )
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      '$patient_name',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontFamily: 'Ubuntu',
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    )
                  ]
              ),
              Column(
                children: [
                  SizedBox(
                    height: 35.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gender:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Ubuntu",
                          color: Colors.black54
                        ),
                      ),
                      Text(
                        '$gender',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Ubuntu",
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    height: 10.0,
                    color: primColor,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Age:',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Ubuntu",
                            color: Colors.black54
                        ),
                      ),
                      Text(
                        '$age',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Ubuntu",
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    height: 10.0,
                    color: primColor,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Message:',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Ubuntu",
                            color: Colors.black54
                        ),
                      ),
                      Text(
                        '$msg',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Ubuntu",
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2,
                    height: 10.0,
                    color: primColor,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
              SizedBox(
                height: 45.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Buttons('Enter Chat Room', (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => chatScreen(uid, patient_name, ImageURL)));
                    } , Colors.lightGreen),
                  SizedBox(
                      height: 5.0
                  ),
                  Buttons('Start Video Call', (){null;}, primColor)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
