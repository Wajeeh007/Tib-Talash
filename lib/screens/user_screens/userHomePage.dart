import 'package:flutter/material.dart';
import 'package:tib_talash/screens/user_screens/feature_screens/pharmacy.dart';
import 'package:tib_talash/constants.dart';
import 'feature_screens/findSpecialist.dart';

class HomePage extends StatefulWidget {
  static const String homeID = "HomePage_screen";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                  children: <Widget>[
                    Stack(
                      children:<Widget>[
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/home_page_logos/Doctors_card.jpg'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(40.0)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                    size: 25.0,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            elevation: 5.0,
                            color: Color(0xFFc5eae7),
                            borderRadius: BorderRadius.circular(15.0),
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pushNamed(context, pharmacy.pharmacyID);
                                },
                              minWidth: 250.0,
                              height: 80.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Order Medicines', style: kButtonHeadingStyle),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                          'Get Medicines at Your Doorstep anywhere',
                                          style: kButtonDescriptionText,
                                      ),
                                    ],
                                  ),
                                  Image(
                                    image: AssetImage('images/home_page_logos/Medicine_Cart.png'),
                                    height: 70.0,
                                    width: 70.0,
                                  ),
                                ],
                              ),
                            ),
                          )
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Material(
                              elevation: 5.0,
                              color: Color(0xFFf3f78a),
                              borderRadius: BorderRadius.circular(15.0),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, findSpecialist.findSpecialistID);
                                },
                                minWidth: 50.0,
                                height: 220.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Which Specialist?', style: kButtonHeadingStyle),
                                        SizedBox(
                                          height: 7.0,
                                        ),
                                        Text(
                                          'Find the Specialist related to your disease/problem.',
                                          style: kButtonDescriptionText,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Image(
                                      image: AssetImage('images/home_page_logos/Find_Doctor.png'),
                                      height: 80.0,
                                      width: 80.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Material(
                                  elevation: 5,
                                  color: Color(0xFFf3c9fc),
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: MaterialButton(
                                    onPressed: () {
                                      null;
                                    },
                                    minWidth: 50.0,
                                    height: 80.0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:9.0, left: 2.0, bottom: 2.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('First Aid', style: kButtonHeadingStyle),
                                              SizedBox(
                                                height: 7.0,
                                              ),
                                              Text(
                                                'At your location',
                                                style: kButtonDescriptionText,
                                              ),
                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child: Image(
                                                  image: AssetImage('images/home_page_logos/First_Aid.png'),
                                                  height: 60.0,
                                                  width: 60.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0
                                ),
                                Material(
                                  elevation: 5.0,
                                  color: Color(0xFFf7d899),
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: MaterialButton(
                                    onPressed: () {
                                      null;
                                    },
                                    minWidth: 50.0,
                                    height: 80.0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 9.0, bottom: 2.0, left: 2.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                  'Health Records',
                                                  style: kButtonHeadingStyle
                                              ),
                                              SizedBox(
                                                height: 7.0,
                                              ),
                                              Text(
                                                'Your Health Stats',
                                                style: kButtonDescriptionText,
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Image(
                                              image: AssetImage('images/home_page_logos/Health_Records.png'),
                                              height: 50.0,
                                              width: 50.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children:<Widget> [
                          Expanded(
                            child: Material(
                              elevation: 5.0,
                              color: Color(0xFFcff7a5),
                              borderRadius: BorderRadius.circular(15.0),
                              child: MaterialButton(
                                onPressed: () {
                                  null;
                                },
                                minWidth: 50.0,
                                height: 150.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                        'Lab Tests',
                                        style: kButtonHeadingStyle
                                    ),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    Text(
                                      'Bring Lab to Your Home',
                                      style: kButtonDescriptionText,
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Image(
                                      image: AssetImage('images/home_page_logos/Lab_Test.png'),
                                      height: 65.0,
                                      width: 65.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Material(
                              elevation: 5.0,
                              color: Color(0xFFf4d2d2),
                              borderRadius: BorderRadius.circular(15.0),
                              child: MaterialButton(
                                onPressed: () {
                                  null;
                                },
                                minWidth: 60.0,
                                height: 150.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                        'Online Consultation',
                                        style: kButtonHeadingStyle
                                    ),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    Text(
                                      'Video/Voice Calls or Chat with Your Doctor',
                                      style: kButtonDescriptionText,
                                    ),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    Image(
                                      image: AssetImage('images/home_page_logos/Online_Consultation.png'),
                                      height: 55.0,
                                      width: 55.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                      ]
                ),
            ),
        ),
        );
  }
}

/*
Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                            child: Material(
                              elevation: 5.0,
                              color: Color(0xFFc5eae7),
                              borderRadius: BorderRadius.circular(15.0),
                              child: MaterialButton(
                                onPressed: () {
                                  null;
                                },
                                minWidth: 60.0,
                                height: 180.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                          'Find Hospital',
                                          style: k3ButtonHeadingStyle
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        'Find Hospitals near You',
                                        style: k3ButtonDescriptionText,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Image(
                                        image: AssetImage('images/Hospital.png'),
                                        height: 100.0,
                                        width: 120.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
 */