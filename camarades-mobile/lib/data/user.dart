import 'package:camarades/data/signup_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  String email;
  String password;
  String firstName;
  String lastName;
  DateTime dateOfBirth;
  String gender;
  String status;
  String profilePhotoFileName;
  String profileDescription;

  User({
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.dateOfBirth,
    this.gender,
    this.status,
    this.profilePhotoFileName,
    this.profileDescription,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromRegistrationData() {
    SignupData data = SignupData.instance;
    return User(
        email: data.email,
        password: data.password,
        firstName: data.firstName,
        lastName: data.lastName,
        dateOfBirth: data.dateOfBirth,
        gender: data.gender,
        status: data.status);
  }
}
