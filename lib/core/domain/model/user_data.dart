enum AccountType { none, student, business }

abstract class BaseProfile {
  abstract AccountType type;
}

class CompanyProfile extends BaseProfile {
  @override
  AccountType type = AccountType.business;

  CompanySize companySize = CompanySize.only1;
  String companyName;
  String website;
  String desc;
  CompanyProfile(
      {required this.companyName,
      required this.website,
      required this.desc,
      this.companySize = CompanySize.only1});
}

class StudentProfile extends BaseProfile {
  @override
  AccountType type = AccountType.student;

  String fullName;
  StudentProfile({required this.fullName});
}

class UserData {
  static const Map<String, AccountType> roleStrToAcc = {
    "0": AccountType.none,
    "1": AccountType.business,
    "2": AccountType.student,
  };

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        userId: json["id"] ?? -1,
        fullName: json["fullname"] ?? "",
        role: ((json["roles"] ?? []) as List<dynamic>)
            .map((e) => e.toString())
            .toList());
  }

  final int userId;
  final String fullName;
  final List<String> role;
  CompanyProfile? company;
  StudentProfile? student;
  UserData(
      {required this.userId,
      required this.fullName,
      required this.role,
      this.company,
      this.student});

  List<BaseProfile> getProfiles() {
    List<BaseProfile> profiles = [];
    if (company != null) {
      profiles.add(company!);
    } else {
      profiles.add(CompanyProfile(companyName: "", website: "", desc: ""));
    }
    if (student != null) {
      profiles.add(student!);
    } else {
      profiles.add(StudentProfile(fullName: ""));
    }
    return profiles;
  }
}

enum CompanySize { only1, less9, less99, less1000, more1000 }
