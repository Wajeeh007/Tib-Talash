import 'package:flutter/material.dart';
import 'package:tib_talash/helpers/constants.dart';
import 'dart:math';
import 'package:tib_talash/screens/user_screens/feature_screens/doctorsList.dart';

class specialistTypeButton extends StatelessWidget {

  specialistTypeButton(this.type, this.desc);

  final String type;
  final String desc;

  var _num = Random();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
          elevation: 5.0,
          color: Color.fromRGBO(_num.nextInt(255), _num.nextInt(255), _num.nextInt(255), 0.8),
          borderRadius: BorderRadius.circular(15.0),
          child: MaterialButton(
              height: 60,
              minWidth: 100,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      type,
                      style: k3ButtonHeadingStyle.copyWith(
                          overflow: TextOverflow.fade, fontSize: 13.0, color: Colors.white),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Image(
                      image: AssetImage('images/specialist_type_images/$type.png'),
                      height: 70.0,
                      width: 75.0,
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Center(
                        child: Text(
                          desc,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: k3ButtonDescriptionText.copyWith(
                              fontSize: 10.0, fontWeight: FontWeight.w500, color: Colors.white),)
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DoctorsList(type)));
              }
          )
      ),
    );
  }
}