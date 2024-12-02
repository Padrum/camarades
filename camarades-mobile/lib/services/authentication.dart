import 'dart:async';
import 'dart:convert' as convert;
import 'package:camarades/data/data.dart';
import 'package:camarades/data/user.dart';
import 'package:camarades/data/signup_data.dart';
import 'package:camarades/services/responses.dart';
import 'package:camarades/services/serialization.dart';
import 'package:http/http.dart' as http;

class Auth {
  Auth._();
  static final Auth instance = Auth._();

  final String _urlRegistration =
      "https://camarades.herokuapp.com/authentication/register";

  Future<RegistrationResponse> apiRegister() async {
    // Navigator.of(context).push(FadeRoute(
    //     page: Scaffold(
    //   backgroundColor: Colors.transparent,
    //   body: Center(child: CircularProgressIndicator()),
    // )));
    // var response = await Auth.instance.register();

    // String message;
    // if (response.success) {
    //   message = response.message;
    //   Navigator.of(context).push(FadeRoute(page: HomePage()));
    // } else {
    //   message = response.error;
    //   Navigator.of(context).pop();
    // }
    // topScaffoldKey.currentState.showSnackBar(
    //   SnackBar(
    //     duration: Duration(seconds: 3),
    //     content: Text(message),
    //   ),
    // );
    SignupData data = SignupData.instance;
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded"
    };
    Map<String, String> body = {
      "email": data.email,
      "password": data.password,
      "first_name": data.firstName,
      "last_name": data.lastName
    };
    var httpResponse = await http.put(
      _urlRegistration,
      headers: headers,
      body: body,
    );
    Map jsonResponse = convert.jsonDecode(httpResponse.body);
    RegistrationResponse response = RegistrationResponse.fromJson(jsonResponse);
    return response;
  }

  Future<bool> apiConnection() async {
    return await null;
  }

  Future<User> jsonRegister() async {
    return await Future.delayed(Duration(milliseconds: 1500)).then(
      (d) async {
        User user = User.fromRegistrationData();
        Data.instance.users.add(user);
        Serialization.serialize();
        return user;
      },
    );
  }

  Future<bool> jsonConnection({String email, String password}) async {
    return await Future.delayed(Duration(milliseconds: 1500)).then(
      (d) async {
        User user = Data.instance.users
            .firstWhere((user) => user.email == email, orElse: () => null);
        if (user != null && user.password == password) {
          Data.instance.connectedUser = user;
          return true;
        }
        return false;
      },
    );
  }

  Future<bool> checkIfEmailExist(String email) async {
    return await Future.delayed(Duration(milliseconds: 1500)).then(
      (d) async {
        Data data = Data.instance;
        User findUser =
            data.users.firstWhere((u) => u.email == email, orElse: () => null);
        bool isEmailExist = findUser == null ? false : true;
        return isEmailExist;
      },
    );
  }
}
