import 'package:flutter/material.dart';

class SchoolCareerPage extends StatefulWidget {
  const SchoolCareerPage({Key key}) : super(key: key);

  @override
  State<SchoolCareerPage> createState() => SchoolCareerPageState();
}

class SchoolCareerPageState extends State<SchoolCareerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Center(
          child: Text("SCHOOL CAREER PAGE"),
        ),
      ),
    );
  }
}
