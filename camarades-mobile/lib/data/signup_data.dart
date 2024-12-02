class SignupData {
  SignupData._();
  String email;
  String password;
  String lastName;
  String firstName;
  DateTime dateOfBirth;
  String gender;
  String status;

  static final SignupData instance = SignupData._();

  void clear() {
    email = "";
    password = "";
    lastName = "";
    firstName = "";
    dateOfBirth = null;
    gender = "";
    status = "";
  }
}
