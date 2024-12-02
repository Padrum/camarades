import 'package:camarades/login/pages.dart';
import 'package:camarades/util/transitions.dart';
import 'package:flutter/material.dart';

Color getColorOfPosition(double x, double y, double z) {
  return Color.fromRGBO((x / 10 * 255).toInt(), (y / 10 * 255).toInt(),
      (z / 10 * 255).toInt(), 1);
}

Future<void> leaveRegistration(BuildContext context, bool formWasEdited) async {
  if (!formWasEdited) {
    Navigator.of(context).push(FadeRoute(page: LoginPage()));
  } else {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("Voulez-vous annuler l'inscription ?"),
          actions: <Widget>[
            RaisedButton(
              child: const Text(
                'YES',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(FadeRoute(page: LoginPage()));
              },
            ),
            RaisedButton(
              child: const Text(
                'NO',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
