import 'package:camarades/login/pages.dart';
import 'package:camarades/data/signup_data.dart';
import 'package:camarades/util/transitions.dart';
import 'package:camarades/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignupEndPage extends StatefulWidget {
  @override
  _SignupEndPageState createState() => _SignupEndPageState();
}

class _SignupEndPageState extends State<SignupEndPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Inscription validé",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Icon(
                Icons.check_circle,
                size: 60,
                color: Colors.green,
              ),
              SizedBox(height: 60),
              CustomBlueButton(
                child: Text("SE CONNECTER"),
                onPressed: () {
                  SignupData.instance.clear();
                  Navigator.of(context).push(FadeRoute(page: LoginPage()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
