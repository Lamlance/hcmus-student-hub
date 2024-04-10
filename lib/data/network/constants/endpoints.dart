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

  //Projects
  static String getProjectsByCompanyId(int companyId) =>
      "$baseUrl/project/company/$companyId";
  static String getAllProjects = "$baseUrl/project/";

  //Profiles
  static String createCompany = '$baseUrl/profile/company';
  static String updateCompanyById(int id) => '$baseUrl/profile/company/$id';
  static String createStudent = '$baseUrl/profile/student';
  static String updateStudentById(int id) => '$baseUrl/profile/student/$id';

  //Misc
  static String getAllTechStack = '$baseUrl/techstack/getAllTechStack';
  static String getAllSkillSet = '$baseUrl/skillset/getAllSkillSet';
}
