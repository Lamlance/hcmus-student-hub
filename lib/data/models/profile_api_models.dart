import 'package:boilerplate/core/domain/model/user_data.dart';

class CreateCompanyProfile {
  final String companyName;
  final int companySize;
  final String website;
  final String description;

  CreateCompanyProfile(
      {required this.companyName,
      required this.companySize,
      required this.website,
      required this.description});

  Map<String, dynamic> toJson() {
    return {
      "companyName": companyName,
      "size": companySize,
      "website": website,
      "description": description
    };
  }
}

class UpdateCompanyProfile extends CreateCompanyProfile {
  final int companyId;
  UpdateCompanyProfile(
      {required this.companyId,
      required super.companyName,
      required super.companySize,
      required super.website,
      required super.description});

  factory UpdateCompanyProfile.fromProfile(CompanyProfile profile) {
    return UpdateCompanyProfile(
        companyId: profile.id,
        companyName: profile.companyName,
        companySize: 0,
        website: profile.website,
        description: profile.desc);
  }
}

class CreateStudentProfile {
  final int techStackId;
  final List<int> skillSets;
  CreateStudentProfile({required this.techStackId, required this.skillSets});

  Map<String, dynamic> toJson() {
    return {"techStackId": techStackId, "skillSets": skillSets};
  }
}

class UpdateStudentProfile extends CreateStudentProfile {
  final String studentId;

  UpdateStudentProfile(
      {required super.techStackId,
      required super.skillSets,
      required this.studentId});
}
