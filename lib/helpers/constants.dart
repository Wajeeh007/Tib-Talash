import 'package:flutter/material.dart';
import 'custom_widgets/doctor_details.dart';
import 'custom_widgets/specialist_button.dart';

const Color primColor = Color(0xFF8BC34A);
const Color lightThemeBg = Colors.white;
const Color darkThemeSecondary = Color(0xffdaddd8);

const MaterialColor greenPalette = MaterialColor(
    0xFF8BC34A, <int, Color> {
      200: Color(0xffc7d59f),
      400: Color(0xffb7ce63),
      600: Color(0xff8fb339),
      800: Color(0xff4b5842)
    }
);

late final String userEmail;
late String filterWord;
late String filterEmail;
var myId;

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: primColor, width: 2.0),
  ),
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kHomeTitleTextStyle = TextStyle(
  overflow: TextOverflow.fade,
  fontFamily: 'Ubuntu',
  fontSize: 25.0,
  fontWeight: FontWeight.w600,
  letterSpacing: 1.0,
  color: primColor,
);

const kButtonHeadingStyle = TextStyle(
  fontSize: 17.0,
  fontWeight: FontWeight.w700,
  fontFamily: 'Ubuntu',
);

const kButtonDescriptionText = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 11.0,
  color: Colors.black,
);

const k3ButtonDescriptionText = TextStyle(
  fontWeight: FontWeight.w400,
  color: Color(0xFF706d6d),
);

const k3ButtonHeadingStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 15.0,
  fontFamily: 'Ubuntu',
);

const kAppointmentDescriptionText = TextStyle(
    fontFamily: "Ubuntu",
    fontWeight: FontWeight.w900,
    fontSize: 12.0,
    color: Colors.black54
);

const kloginInputFieldDecoration = InputDecoration(
  hintText: null,
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const ksignupInputFieldDecoration = InputDecoration(
  hintText: null,
  contentPadding:
  EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: primColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
  ),
);

class Buttons extends StatelessWidget {
  Buttons(this.boxText, this.onPressed, this.colour);

  final String boxText;
  final Function onPressed;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: (){
            onPressed();
          },
          minWidth: 150.0,
          height: 38.0,
          child: Text(
            boxText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}

class DoctorDetailBubble extends StatelessWidget {
  DoctorDetailBubble(this.doc_name, this.specialization, this.exp, this.hospital, this.lang);

  final String doc_name;
  final String specialization;
  final int exp;
  final String hospital;
  final dynamic lang;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          const Icon(
            Icons.account_circle, size: 80.0,),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Dr. $doc_name', style: TextStyle(fontSize: 27.0, color: Colors.grey.shade800, fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: 7.0,
                ),
                Text('$specialization', style: const TextStyle(fontSize: 22.0, color: Colors.black45, fontWeight: FontWeight.w600),),
                const SizedBox(
                  height: 7.0,
                ),
                const Text('At', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w500),),
                const SizedBox(
                  height: 2.0,
                ),
                Text('$hospital', style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700),),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Divider(
              thickness: 2.0,
              height: 20.0,
              color: Colors.black,
            ),
          ),
          main_Details(lang, exp)
        ],
      ),
    );
  }
}

List<specialistTypeButton> specialist_list = [
  specialistTypeButton('Allergist', 'Allergies, Asthma, Insect stings, Autoimmune diseases'),
  specialistTypeButton('Cardiologist', 'Blood Pressure, Irregular Heartbeat, Heart or blood vessel'),
  specialistTypeButton('Endocrinologist', 'Diabetes, Thyroid, Infertility, Hormonal problems'),
  specialistTypeButton('Genetics', 'Ask a specialist about the problem in your genes'),
  specialistTypeButton('Hematologist', 'Diseases of blood. Blood-clotting disorder, Leukemia, Anemia'),
  specialistTypeButton('Neurologist', 'Brain and Spinal Cord Disorders. Parkinson\'s Disease, Epilepsy'),
  specialistTypeButton('Otolaryngologist', 'Also called ENT. Consult for your head and neck issues'),
  specialistTypeButton('Physiatrist', 'Treats Bone problems like Sciatica, Osteoarthritis and Rehabilitation',),
  specialistTypeButton('Dermatologist', 'Skin, Nails or Hairs problem? Consult one'),
  specialistTypeButton('Anesthesiologist', 'Want to numb your pain? Ask an Anthesiologist'),
  specialistTypeButton('Gastroenterologist', 'Ulcer, Diarrhea, Jaundice, Abdominal pain'),
  specialistTypeButton('Gynecologist', 'Female Reproductive issues'),
  specialistTypeButton('Nephrologist', 'Kidney Diseases. Kidney Failiure'),
  specialistTypeButton('Ophthalmologist', 'Treats all Eye and Vision Disorders. '),
  specialistTypeButton('Pediatrician', 'Treats the health and disorders of Children, adolescents'),
  specialistTypeButton('Podiatrist', 'Treat your Foot and Ankle issues'),
];