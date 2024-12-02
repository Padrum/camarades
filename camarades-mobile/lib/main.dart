import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/data.dart';
import 'login/pages.dart';

void main() {
  Data.deserialize();
  runApp(
    new MaterialApp(
      title: "camarades",
      theme: ThemeData(primaryColor: Colors.blue),
      home: LoginPage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr'),
      ],
    ),
  );
}
