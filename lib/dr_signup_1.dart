import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tib_talash/constants.dart';
import 'package:tib_talash/screens/dr_screens/signup&login/dr_signup_2.dart';
import 'dr_login.dart';
import 'package:intl/intl.dart';

class dr_signup_1 extends StatefulWidget {
  static const dr_signupID = "dr_signup_1 screen";

  @override
  State<dr_signup_1> createState() => _dr_signup_1State();
}

class _dr_signup_1State extends State<dr_signup_1> {
  final formKey = GlobalKey<FormState>();
  String _email = '';
  final DOBvalidator = RequiredValidator(errorText: 'This field is required');
  String _name = '';
  DateTime today = DateTime.now();
  TextEditingController dateInput = TextEditingController();
  String dropdownvalue = 'Male';
  var gender = ['Male', 'Female', 'Other'];
  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required*'),
    EmailValidator(errorText: 'Enter a valid email address*'),
  ]);
  final nameValidator = RequiredValidator(errorText: 'Name is required');
  final Map<String, dynamic> details = {};

  void updateUI() {
    setState(() {
      Navigator.pop(context);
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave() == true) {
      details.addAll({
        'Name' : '$_name',
        'Gender' : '$dropdownvalue',
        'Date of Birth': '${dateInput.text}',
        'email': '$_email',
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => dr_signup_2()));
    return ;
    }

  }

  @override
  void initState() {
    dateInput.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: kHomeTitleTextStyle.copyWith(fontSize: 28.0),),
                SizedBox(
                  height: 25.0,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('Enter Your Name', style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600),),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          _name = value;
                        },
                          validator: nameValidator,
                        decoration: ksignupInputFieldDecoration
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Row(
                        children: [
                          Text(
                              'Select Gender:',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15.0,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xfff9f9e0),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: DropdownButton(
                                      value: dropdownvalue,
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      items: gender.map((String gender) {
                                        return DropdownMenuItem(
                                          value: gender,
                                          child: Text(gender),);
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      }
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      TextFormField(
                          controller: dateInput,
                          decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today, color: primColor,),
                            labelText: "Select Date of Birth:",
                            focusColor: primColor,
                          ),
                        readOnly: true,
                        onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now());
                            if(pickedDate != null) {
                              print(pickedDate);
                              String formattedDate = DateFormat('dd-MM-yyyy')
                                  .format(pickedDate);
                              setState(() {
                                dateInput.text = formattedDate;
                              });
                              }
                            else{}
                            },
                        validator: DOBvalidator,
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text('Enter Your Email address', style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600),),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.left,
                          onChanged: (value) {
                            _email = value;
                          },
                          validator: emailValidator,
                          decoration: ksignupInputFieldDecoration
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Buttons('Continue', () {
                        validateAndSubmit();
                      }, primColor),
                      SizedBox(
                        height: 5.0,
                      ),
                      TextButton(onPressed: () async {
                        Navigator.pushReplacementNamed(context,
                            dr_login.dr_loginID);
                        },
                          child: Text('Already have an account? Log In'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}