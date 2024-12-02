import 'dart:convert';

import 'package:camarades/data/data.dart';
import 'package:camarades/data/user.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Serialization {
  static Future serialize() async {
    File jsonFile = await _getJsonFile();
    Map<String, dynamic> jsonMap = Data.instance.dataToJson();
    File f = await jsonFile.writeAsString(json.encode(jsonMap));
    if (f == null)
      print("LOG: Serialization failed");
    else
      print("LOG: Serialization OK");
  }

  static Future<Data> deserialize() async {
    File jsonFile = await _getJsonFile();
    String jsonString = await jsonFile.readAsString();
    if (jsonString.isNotEmpty) {
      print("LOG: Deserialization");
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      Data data = Data.fromJson(jsonMap);
      print("LOG: Deserialization OK");
      return data;
    }
    print("LOG: Deserialization File empty");
    return null;
  }

  static Future<File> _getJsonFile() async {
    Directory appPath = await getApplicationDocumentsDirectory();
    String filePath = '${appPath.path}/data.json';
    File file = File(filePath.replaceAll("'", ""));
    bool isFileExists = await file.exists();
    if (!isFileExists) {
      print("LOG: File doesn't exists");
      File f = await file.create();
      print("LOG: File cretaed");
      return f;
    }
    print("LOG: File exists");
    return file;
  }

  static Future<bool> clearJsonFile() async {
    File jsonFile = await _getJsonFile();
    User user = User(
      firstName: "Admin",
      lastName: "Admin",
      email: "admin",
      password: "admin",
      status: "etudiant",
      profileDescription: "Gnialalalalaa BONSOIR",
      gender: "homme",
      dateOfBirth: DateTime.now().subtract(
        Duration(days: 365),
      ),
    );
    List<User> users = List<User>()..add(user);
    Map<String, dynamic> jsonMap = Map<String, dynamic>()
      ..addAll({"users": users});
    File f = await jsonFile.writeAsString(json.encode(jsonMap));
    if (f == null) {
      print("LOG: Serialization failed");
      return false;
    } else {
      print("LOG: Serialization OK");
      Data.deserialize();
      return true;
    }
  }
}
