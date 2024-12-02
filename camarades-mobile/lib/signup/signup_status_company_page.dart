import 'package:camarades/data/signup_data.dart';
import 'package:camarades/signup/signup_end_page.dart';
import 'package:camarades/services/authentication.dart';
import 'package:camarades/util/enum.dart';
import 'package:camarades/util/functions.dart';
import 'package:camarades/util/transitions.dart';
import 'package:camarades/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';

class SignupStatusPage extends StatefulWidget {
  @override
  SignupStatusPageState createState() {
    return SignupStatusPageState();
  }
}

class SignupStatusPageState extends State<SignupStatusPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> _companyFieldState =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _professionFieldState =
      GlobalKey<FormFieldState>();

  bool _isSignupLoading = false;
  String _company;
  String _profession;

  Future _validateInputs() async {
    if (_formKey.currentState.validate()) {
      if (_company.isEmpty) {
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("Veuillez sélectionner une entreprise")));
      } else if (_profession.isEmpty) {
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text("Veuillez sélectionner une profession")));
      } else {
        _formKey.currentState.save();
        setState(() {
          _isSignupLoading = true;
        });
        await Auth.instance.jsonRegister();
        Navigator.of(context).push(FadeRoute(page: SignupEndPage()));
        setState(() {
          _isSignupLoading = false;
        });
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
                    "Quel est votre statut ?",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 50.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: getRadioTile(Status.etudiant),
                    ),
                    Expanded(
                      child: getRadioTile(Status.professeur),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: getRadioTile(Status.professionnel),
                    ),
                    Expanded(
                      child: getRadioTile(Status.non_actif),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                CustomBlueButton(
                  child: _isSignupLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            backgroundColor: Colors.white,
                          ))
                      : const Text("S'INSCRIRE"),
                  onPressed: _validateInputs,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration getBoxDecorationIfSelected(Status s) {
    if (s == _status) {
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

  Widget getRadioTile(Status s) {
    return GestureDetector(
      onTap: () {
        setStatus(s);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          height: 150,
          alignment: Alignment.center,
          decoration: getBoxDecorationIfSelected(s),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                getStatusNameOf(s),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Radio(
                activeColor: Colors.lightBlue,
                groupValue: _status,
                value: s,
                onChanged: (value) {
                  setStatus(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
