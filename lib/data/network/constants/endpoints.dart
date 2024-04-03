class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://10.0.2.2:4400/api";
  // receiveTimeout
  static const int receiveTimeout = 15000;
  // connectTimeout
  static const int connectionTimeout = 30000;

  // Auth
  static const String signUp = '$baseUrl/auth/sign-up';
  static const String signIn = '$baseUrl/auth/sign-in';
  static const String authMe = '$baseUrl/auth/me';
}
