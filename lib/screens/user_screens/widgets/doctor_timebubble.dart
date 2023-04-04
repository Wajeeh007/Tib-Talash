import 'package:flutter/material.dart';
import 'package:tib_talash/constants.dart';
import '../feature_screens/doctorCard.dart';

class TimeBubble extends StatefulWidget {
  const TimeBubble(
      this.time,
      );

  final String time;

  @override
  State<TimeBubble> createState() => _TimeBubbleState();
}

class _TimeBubbleState extends State<TimeBubble> {
  bool buttonPressed = false;
  Color buttonColor = primColor;
  Color textColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Material(
        color: buttonColor,
        elevation: 1.5,
        borderRadius: BorderRadius.circular(5.0),
        child: MaterialButton(
          onPressed: (){
            setState((){
              if(buttonPressed == false){
                buttonPressed = true;
              }else{
                buttonPressed = false;
              }
              this.buttonColor = buttonPressed ? Colors.white : primColor;
              this.textColor = buttonPressed ? primColor : Colors.white;
              selected_time = widget.time;
            });
          },
          minWidth: 70,
          height: 35,
          child: Text(
            widget.time,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}