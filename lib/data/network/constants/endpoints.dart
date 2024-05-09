class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://10.0.2.2:4400/api";
  static const String socketUrl = "http://10.0.2.2:4400";
  static const String agoraTokenUrl = "http://10.0.2.2:8080";
  // receiveTimeout
  static const int receiveTimeout = 15000;
  // connectTimeout
  static const int connectionTimeout = 30000;

  // Auth
  static const String signUp = '$baseUrl/auth/sign-up';
  static const String signIn = '$baseUrl/auth/sign-in';
  static const String authMe = '$baseUrl/auth/me';
  static const String forgotPwd = '$baseUrl/user/forgotPassword';
  static const String changePwd = '$baseUrl/user/changePassword';

  //Projects
  static String getProjectsByCompanyId(int companyId) =>
      "$baseUrl/project/company/$companyId";
  static String getAllProjects = "$baseUrl/project/";
  static String postProject = '$baseUrl/project';
  static String updateProject(int projectId) => '$baseUrl/project/$projectId';
  static String deleteProject(int projectId) => '$baseUrl/project/$projectId';
  static String getFavProjects(int studentId) =>
      '$baseUrl/favoriteProject/$studentId';
  //Profiles
  static String createCompany = '$baseUrl/profile/company';
  static String updateCompanyById(int id) => '$baseUrl/profile/company/$id';
  static String createStudent = '$baseUrl/profile/student';
  static String updateStudentById(int id) => '$baseUrl/profile/student/$id';

  //Misc
  static String getAllTechStack = '$baseUrl/techstack/getAllTechStack';
  static String getAllSkillSet = '$baseUrl/skillset/getAllSkillSet';

  //Proposal
  static String createProposal = '$baseUrl/proposal';
  static String getPropsalByProjectId(int projectId) =>
      '$baseUrl/proposal/getByProjectId/$projectId';
  static String updateProposalByProposalId(int proposalId) =>
      '$baseUrl/proposal/$proposalId';
  static String getProposalByStudentId(int studentId) =>
      '$baseUrl/proposal/project/$studentId';

  //Messages
  static String getMyMessage = '$baseUrl/message';
  static String getMyMessageWith(int projectId, int targetId) =>
      '$baseUrl/message/$projectId/user/$targetId';
  static String sendMessage = "$baseUrl/message/sendMessage";
  //Interview
  static String createInterview = '$baseUrl/interview';
  static String getInterviews = '$baseUrl/interview';
  static String cancelInterview(int interviewId) =>
      '$baseUrl/interview/$interviewId/disable';
  static String editInterview(int interviewId) =>
      '$baseUrl/interview/$interviewId';
}
