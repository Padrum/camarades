import 'package:camarades/data/data.dart';
import 'package:camarades/data/user.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    User user = Data.instance.connectedUser;
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
      ),
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 40.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue[100],
                      ),
                      child: Icon(Icons.person, size: 100),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Charlie Guerry",
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "22 ans",
                          style: TextStyle(fontSize: 17),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Etudiant",
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    alignment: Alignment.centerLeft,
                    height: 100,
                    child: Text(user.profileDescription),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
