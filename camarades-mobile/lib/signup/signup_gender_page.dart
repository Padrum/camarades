import 'package:camarades/data/signup_data.dart';
import 'package:camarades/signup/pages.dart';
import 'package:camarades/util/enum.dart';
import 'package:camarades/util/functions.dart';
import 'package:camarades/util/transitions.dart';
import 'package:camarades/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';

class SignupGenderPage extends StatefulWidget {
  @override
  SignupGenderPageState createState() {
    return SignupGenderPageState();
  }
}

class SignupGenderPageState extends State<SignupGenderPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Gender _gender;

  void setGender(Gender value) {
    setState(() {
      _gender = value;
      SignupData.instance.gender = getGenderNameOf(_gender);
    });
  }

  Future _validateInputs() async {
    if (_formKey.currentState.validate()) {
      if (_gender == null) {
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("Veuillez sélectionner un genre")));
      } else {
        Navigator.of(context).push(FadeRoute(page: SignupStatusPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 90.0),
                Center(
                  child: Text(
                    "Quel est votre sexe/genre ?",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 50.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: getRadioTile(Gender.homme),
                    ),
                    Expanded(
                      child: getRadioTile(Gender.femme),
                    ),
                    Expanded(
                      child: getRadioTile(Gender.humain),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.0,
                ),
                CustomBlueButton(
                  child: const Text("CONTINUER"),
                  onPressed: _validateInputs,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration getBoxDecorationIfSelected(Gender g) {
    if (g == _gender) {
      return BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.grey.shade300,
        border: Border.all(width: 1, color: Colors.grey.shade400),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      );
    } else {
      return BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.shade400),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      );
    }
  }

  Widget getRadioTile(Gender g) {
    return GestureDetector(
      onTap: () {
        setGender(g);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          height: 150,
          alignment: Alignment.center,
          decoration: getBoxDecorationIfSelected(g),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                getGenderNameOf(g),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Radio(
                activeColor: Colors.lightBlue,
                groupValue: _gender,
                value: g,
                onChanged: (value) {
                  setGender(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
