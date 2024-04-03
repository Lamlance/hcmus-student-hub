import 'dart:convert';
import 'dart:developer';

class AuthApiSignInRequest {
  final String email;
  final String password;
  AuthApiSignInRequest({required this.email, required this.password});
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class AuthApiSignUpRequest {
  final String email;
  final String password;
  final String fullName;
  final int role = 0;

  AuthApiSignUpRequest({
    required this.email,
    required this.password,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'role': role
    };
  }
}
