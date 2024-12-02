import 'package:camarades/main/pages.dart';
import 'package:camarades/services/serialization.dart';
import 'package:camarades/signup/pages.dart';
import 'package:camarades/services/authentication.dart';
import 'package:camarades/util/transitions.dart';
import 'package:camarades/widgets/custom_buttons.dart';
import 'package:camarades/widgets/custom_fields.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camarades/util/strings.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailFieldKey =
      GlobalKey<FormFieldState<String>>();

  final FocusNode _emailFocusNode = new FocusNode();
  final FocusNode _passwordFocusNode = new FocusNode();

  bool _isConnectionLoading = false;

  void _login() async {
    bool connection = false;
    String email = _emailFieldKey.currentState.value;
    String password = _passwordFieldKey.currentState.value;
    setState(() => _isConnectionLoading = true);

    if (!kReleaseMode && email.isEmpty && password.isEmpty) {
      connection =
          await Auth.instance.jsonConnection(email: "admin", password: "admin");
    } else if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      connection =
          await Auth.instance.jsonConnection(email: email, password: password);
    }
    if (connection) {
      Navigator.of(context).push(FadeRoute(page: MainPage()));
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Email ou mot de passe incorrect"),
          duration: Duration(seconds: 4),
        ),
      );
    }
    setState(() => _isConnectionLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !kReleaseMode
          ? FloatingActionButton(
              onPressed: () async {
                if (await Serialization.clearJsonFile())
                  Toast.show("Json file cleared", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                else
                  Toast.show("Error to clear json file", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              },
              child: Icon(Icons.delete),
            )
          : null,
      key: _scaffoldKey,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  strLogoPath,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          key: _emailFieldKey,
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            filled: true,
                            labelText: 'Mail',
                            prefixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (String value) {
                            if (value.isEmpty) {
                              FocusScope.of(context)
                                  .requestFocus(_emailFocusNode);
                              return "Veuillez rentrer votre email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        PasswordField(
                          fieldKey: _passwordFieldKey,
                          focusNode: _passwordFocusNode,
                          labelText: 'Mot de passe',
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Veuillez rentrer votre mot de passe";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 50),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              CustomBlueButton(
                                child: _isConnectionLoading
                                    ? SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          backgroundColor: Colors.white,
                                        ))
                                    : const Text('CONNEXION'),
                                onPressed: () => _login(),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 30.0),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              CustomWhiteButton(
                                child: Text("S'INSCRIRE"),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(FadeRoute(page: SignupFirstPage()));
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
