//flutter packages pub run build_runner build

import 'package:camarades/data/user.dart';
import 'package:camarades/services/serialization.dart';

class Data {
  static Data instance = Data._();

  List<User> users = new List<User>();
  User connectedUser;

  Data._({this.users});

  static Future<void> deserialize() async {
    instance = await Serialization.deserialize() ?? Data._();
  }

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data._(
      users: (json['users'] as List)?.map(
        (e) {
          if (e == null) {
            return null;
          }
          User user = User.fromJson(e as Map<String, dynamic>);
          return user;
        },
      )?.toList(),
    );
  }

  Map<String, dynamic> dataToJson() => <String, dynamic>{
        'users': users,
      };
}
