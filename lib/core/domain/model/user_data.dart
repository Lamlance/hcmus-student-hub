enum AccountType { none, student, business }

abstract class ProfileData {
  ProfileData();
}

abstract class UserData {
  final String userName;
  final AccountType accountType;
  abstract ProfileData? profileData;
  UserData({required this.userName, required this.accountType});
}

enum EmployeeSize { only1, less9, less99, less1000, more1000 }

class CompanyProfile extends ProfileData {
  EmployeeSize employeeSize = EmployeeSize.only1;
  String companyName;
  String website;
  String desc;
  CompanyProfile(
      {required this.companyName,
      required this.website,
      required this.desc,
      this.employeeSize = EmployeeSize.only1});
}

class CompanyData extends UserData {
  @override
  covariant CompanyProfile? profileData;

  CompanyData({required super.userName, this.profileData})
      : super(accountType: AccountType.business);
}

class StudentProfile extends ProfileData {
  String studentName;
  StudentProfile({required this.studentName});
}

class StudentData extends UserData {
  @override
  covariant StudentProfile? profileData;
  StudentData({required super.userName, this.profileData})
      : super(accountType: AccountType.student);
}
