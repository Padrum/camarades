import 'package:camarades/signup/pages.dart';
import 'package:camarades/data/signup_data.dart';
import 'package:camarades/services/authentication.dart';
import 'package:camarades/util/functions.dart';
import 'package:camarades/util/transitions.dart';
import 'package:camarades/widgets/custom_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupFirstPage extends StatefulWidget {
  @override
  _SignupFirstPageState createState() => _SignupFirstPageState();
}

class _SignupFirstPageState extends State<SignupFirstPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _emailTextFieldEmailKey =
      GlobalKey<FormFieldState>();
  final TextEditingController _emailController = TextEditingController();

  bool _formWasEdited = false;
  bool _isCheckEmailLoading = false;
  bool _isEmailExist;

  FocusNode _focusNodeLastName = FocusNode();
  FocusNode _focusNodeEmail = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNodeLastName.dispose();
    _focusNodeEmail.dispose();
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
            leaveRegistration(context, _formWasEdited);
          },
        ),
      ),
      body: Scaffold(
        key: _scaffoldKey,
        body: Form(
          key: _formKey,
          onWillPop: () => leaveRegistration(context, _formWasEdited),
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              dragStartBehavior: DragStartBehavior.down,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 90.0),
                  Container(
                    child: Center(
                      child: Text(
                        "Créez votre compte Camarades",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              labelText: "Prenom",
                            ),
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              SignupData.instance.firstName = value;
                            },
                            onEditingComplete: () {
                              _formWasEdited = true;
                              FocusScope.of(context)
                                  .requestFocus(_focusNodeLastName);
                            },
                            validator: (value) {
                              if (value.isEmpty) return "Entrez votre prénom";
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: TextFormField(
                            textCapitalization: TextCapitalization.words,
                            focusNode: _focusNodeLastName,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              labelText: "Nom",
                            ),
                            keyboardType: TextInputType.text,
                            onSaved: (value) {
                              SignupData.instance.lastName = value;
                              _formWasEdited = true;
                            },
                            onEditingComplete: () {
                              _formWasEdited = true;
                              FocusScope.of(context)
                                  .requestFocus(_focusNodeEmail);
                            },
                            validator: (value) {
                              if (value.isEmpty) return "Entrez votre nom";
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    key: _emailTextFieldEmailKey,
                    controller: _emailController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    focusNode: _focusNodeEmail,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      labelText: "Mail",
                      prefixIcon: _isCheckEmailLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      SignupData.instance.email = value;
                    },
                    onEditingComplete: () {
                      _formWasEdited = true;
                    },
                    validator: _validateEmail,
                  ),
                  SizedBox(height: 90),
                  CustomBlueButton(
                    child: Text("CONTINUER"),
                    onPressed: _validation(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "Entrez votre adresse mail";
    }
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (_isEmailExist) {
      return "Cette adresse mail est déjà utilisée";
    }

    if (!regExp.hasMatch(value)) {
      return "L'adresse mail n'est pas valide";
    }
    return null;
  }

  Future<void> _checkIfEmailExist() async {
    setState(() => _isCheckEmailLoading = true);
    _isEmailExist = await Auth.instance
        .checkIfEmailExist(_emailTextFieldEmailKey.currentState.value);
    setState(() => _isCheckEmailLoading = false);
  }

  Function _validation() {
    return () async {
      await _checkIfEmailExist();
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        Navigator.of(context).push(FadeRoute(page: SignupPasswordPage()));
      }
    };
  }
}
