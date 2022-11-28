import 'package:flutter/material.dart';

class main_Details extends StatelessWidget {

  final int exp;
  final dynamic languages;

  main_Details(this.languages, this.exp);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Experience ', style: TextStyle(
                  fontSize: 17.5, fontWeight: FontWeight.bold),),
              SizedBox(
                height: 2.0,
              ),
              Text('$exp Years', style: TextStyle(
                  fontSize: 12.5, fontWeight: FontWeight.w500),),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Languages', style: TextStyle(
                  fontSize: 17.5, fontWeight: FontWeight.bold),),
              SizedBox(
                height: 2.0,
              ),
              Text('$languages', style: TextStyle(
                  fontSize: 12.5, fontWeight: FontWeight.w500),),
            ],
          ),
        ]
    );
  }
}
