import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:tib_talash/constants.dart';

var spec_details = [];

final formKey = GlobalKey<FormState>();
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
    print('Hello');
  }
  return ;
}

class dr_signup_2 extends StatefulWidget {
  static const signup_2ID = "signup_2_screen";
  // dr_signup_2(this.details);
  //
  // final Map<String, dynamic> details;

  @override
  State<dr_signup_2> createState() => _dr_signup_2State();
}

class _dr_signup_2State extends State<dr_signup_2> {

  List <field> _widgetList=[];
  double cont_height = 1;
  removewidget(){
    if(_widgetList.length == 1){
      return;
    }
    _widgetList.removeLast();
    cont_height -= 110.0;
    setState(() {
    });
  }
  addWidget(){
    if(_widgetList.length >= 3){
      return ;
    }
    _widgetList.add(new field());
    cont_height += 110.0;
    setState(() {
    });
  }

  String showerror(widget){
    return widget.fieldValidator.errorText;
  }

  dynamic submitData(){
    spec_details.clear();
    _widgetList.forEach((widget){
      if(widget.degree_name != ''){
        spec_details.add(widget.degree_name);
      }
      showerror(widget);
    });
    print(spec_details);
  }

  @override
  void initState() {
    addWidget();
    super.initState();

  }

  String dropdownvalue = 'Select Specialization';
  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required*'),
    MinLengthValidator(
        8, errorText: 'Password must be at least 8 characters long*')
  ]);

  bool visible = false;
  var specializations = ['Select Specialization', 'Allergist', 'Anaestheseologist', 'Cardiologist', 'Dermatologist', 'Endocrinologist', 'Gaestroentrologist', 'Genetics', 'Gynaecologist', 'Hematologist', 'Nephrologist', 'Neurologist', 'Ophthalmologist', 'Otolaryngologist', 'Pediatrician', 'Physiatrist', 'Podiatrist'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                        'Specialization Details',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Ubuntu',
                        color: primColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 17.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Select Specialization:',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 15.0,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xfff9f9e0),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: DropdownButton(
                                      value: dropdownvalue,
                                      icon: Icon(Icons.keyboard_arrow_down),
                                      items: specializations.map((String specialization) {
                                        return DropdownMenuItem(
                                          value: specialization,
                                          child: Text(specialization),);
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownvalue = newValue!;
                                        });
                                      }
                                  ),
                                ),
                              ),
                              Text(
                                visible? 'Select a Specialization*' : '',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14.0,
                                )
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  Form(
                    key: formKey,
                    child: Container(
                      height: cont_height,
                      child: ListView.builder(
                          itemCount: _widgetList.length,
                          itemBuilder: (_, index) => _widgetList[index]
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                    ),
                      onPressed: (){
                      addWidget();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline, color: Colors.grey, size: 25.0,),
                          SizedBox(
                            width: 18.0,
                          ),
                          Text('Add Another field', style: TextStyle(color: Colors.grey,
                              fontSize: 18.0,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold),),
                        ],
                      )),
                  SizedBox(
                    height: 15.0,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(onPressed: (){
                      removewidget();
                      },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: Text(
                                'Remove the last field',
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu',
                                fontSize: 18.0,
                                color: Colors.grey
                              ),
                            ),
                          ),
                          Icon(Icons.remove_circle_outline, color: Colors.grey, size: 25.0,),
                        ],
                      )),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Buttons('Continue', (){
                        validateAndSubmit();
                      }, primColor),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}

class field extends StatelessWidget {

  String degree_name = '';
  final fieldValidator = RequiredValidator(errorText: "This field is required*");
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Align(alignment: Alignment.centerLeft,child: Text('Enter your Degree Name')),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: TextFormField(
              decoration: ksignupInputFieldDecoration,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                degree_name = value;
              },
              textCapitalization: TextCapitalization.characters,
              validator: fieldValidator,
            ),
          ),
        ],
      );
  }
}