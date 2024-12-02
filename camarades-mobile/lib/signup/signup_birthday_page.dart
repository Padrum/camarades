import 'package:camarades/signup/pages.dart';
import 'package:camarades/data/signup_data.dart';
import 'package:camarades/util/functions.dart';
import 'package:camarades/util/transitions.dart';
import 'package:camarades/widgets/custom_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignupBirthdayPage extends StatefulWidget {
  @override
  _SignupBirthdayPageState createState() => _SignupBirthdayPageState();
}

class _SignupBirthdayPageState extends State<SignupBirthdayPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime _initialDate = DateTime(2000, 1);
  String _dateString = "1 Janvier 2000";

  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _initialDate,
      firstDate: DateTime(1, 1),
      lastDate: DateTime.now(),
      locale: Locale("fr"),
    );
    if (picked != null && picked != _initialDate)
      setState(() {
        _dateString = DateFormat.yMMMMd("fr").format(picked);
        _initialDate = picked;
        SignupData.instance.dateOfBirth = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Création de compte"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            leaveRegistration(context, true);
          },
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            dragStartBehavior: DragStartBehavior.down,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 70.0),
                Container(
                  child: Center(
                    child: Text(
                      "Quelle est votre date de naissance ?",
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.white, Colors.red]),
                    border: Border.all(
                      color: Colors.lightBlue,
                      width: 3.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 33),
                      CircleButton(
                        iconData: Icons.calendar_today,
                        onTap: () => _selectDate(context),
                      ),
                      SizedBox(height: 10),
                      Text(
                        _dateString,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                CustomBlueButton(
                  onPressed: () {
                    _formKey.currentState.save();
                    Navigator.of(context)
                        .push(FadeRoute(page: SignupGenderPage()));
                  },
                  child: Text("CONTINUER"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
