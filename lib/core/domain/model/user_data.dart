enum AccountType { none, student, business }

abstract class BaseProfile {
  abstract AccountType type;
  final int id;

  BaseProfile({required this.id});
}

class CompanyProfile extends BaseProfile {
  @override
  AccountType type = AccountType.business;
  CompanySize companySize = CompanySize.only1;
  String companyName;
  String website;
  String desc;
  CompanyProfile(
      {required super.id,
      required this.companyName,
      required this.website,
      required this.desc,
      this.companySize = CompanySize.only1});

  factory CompanyProfile.fromJson(Map<String, dynamic> json) {
    return CompanyProfile(
        id: json["id"],
        companyName: json["companyName"],
        website: json["website"],
        desc: json["description"]);
  }
}

class StudentProfile extends BaseProfile {
  @override
  AccountType type = AccountType.student;
  final int techStackId;
  final List<int> skillSets;
  StudentProfile(
      {required super.id, required this.techStackId, required this.skillSets});

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      id: json["id"],
      techStackId: json["techStackId"],
      skillSets: ((json["skillSets"] ?? []) as List<dynamic>)
          .map((e) => int.parse('$e'))
          .toList(),
    );
  }
}

class UserData {
  static const Map<String, AccountType> roleStrToAcc = {
    "0": AccountType.none,
    "1": AccountType.business,
    "2": AccountType.student,
  };

  factory UserData.fromJson(Map<String, dynamic> json) {
    final company = json["company"] == null
        ? null
        : CompanyProfile.fromJson(json["company"]);
    final student = json["student"] == null
        ? null
        : StudentProfile.fromJson(json["student"]);
    return UserData(
        userId: json["id"] ?? -1,
        fullName: json["fullname"] ?? "",
        company: company,
        student: student,
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
      profiles
          .add(CompanyProfile(id: -1, companyName: "", website: "", desc: ""));
    }
    if (student != null) {
      profiles.add(student!);
    } else {
      profiles.add(StudentProfile(id: -1, techStackId: -1, skillSets: []));
    }
    return profiles;
  }
}

enum CompanySize { only1, less9, less99, less1000, more1000 }
