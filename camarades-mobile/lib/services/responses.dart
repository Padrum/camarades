class RegistrationResponse {
  final bool success;
  final String error;
  final String message;

  RegistrationResponse(this.success, this.error, this.message);

  RegistrationResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] ?? false,
        error = json['error'] ?? "",
        message = json['message'] ?? "";
}

class ConnectionResponse {
  final bool success;
  final String error;
  final String message;

  ConnectionResponse(this.success, this.error, this.message);

  ConnectionResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'] ?? false,
        error = json['error'] ?? "",
        message = json['message'] ?? "";
}
