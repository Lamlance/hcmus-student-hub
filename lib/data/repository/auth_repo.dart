import 'dart:convert';
import 'dart:developer';

class AuthApiSignInRequest {
  final String email;
  final String password;
  AuthApiSignInRequest({required this.email, required this.password});
}

class AuthApiSignUpRequest {
  final String email;
  final String password;
  final String fullName;
  final int role;

  AuthApiSignUpRequest(
      {required this.email,
      required this.password,
      required this.fullName,
      this.role = 0});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'role': role
    };
  }
}
