import 'package:camarades/signup/pages.dart';
import 'package:camarades/data/signup_data.dart';
import 'package:camarades/util/functions.dart';
import 'package:camarades/util/transitions.dart';
import 'package:camarades/widgets/custom_buttons.dart';
import 'package:camarades/widgets/custom_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupPasswordPage extends StatefulWidget {
  @override
  _SignupPasswordPageState createState() => _SignupPasswordPageState();
}

class _SignupPasswordPageState extends State<SignupPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode focusNodePassword = FocusNode();

  @override
  void dispose() {
    focusNodePassword.dispose();
    super.dispose();
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
                      "Entrez votre mot de passe",
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  child: PasswordField(
                    autofocus: true,
                    focusNode: focusNodePassword,
                    labelText: "Mot de passe",
                    onSaved: (value) {
                      SignupData.instance.password = value;
                    },
                    validator: (value) {
                      if (value.isEmpty)
                        return "Veuillez entrer un mot de passe";
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 40.0),
                Container(
                  child: CustomBlueButton(
                    child: Text("CONTINUER"),
                    onPressed: () {
                      _formKey.currentState.save();
                      if (_formKey.currentState.validate())
                        Navigator.of(context)
                            .push(FadeRoute(page: SignupBirthdayPage()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
