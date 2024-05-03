import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:boilerplate/data/models/misc_api_models.dart';

enum ProjectStatus { none, working, archive }

enum ProposalStatus { none, hired, hiredOfferSent, active }

class ProposalData {
  static ProposalStatus intToStatus(int status) {
    return switch (status) {
      0 => ProposalStatus.none,
      2 => ProposalStatus.hiredOfferSent,
      3 => ProposalStatus.hired,
      1 => ProposalStatus.active,
      _ => ProposalStatus.none
    };
  }

  static int statusToInt(ProposalStatus status) {
    return switch (status) {
      ProposalStatus.none => 0,
      ProposalStatus.hiredOfferSent => 2,
      ProposalStatus.hired => 3,
      ProposalStatus.active => 1,
    };
  }

  final int id;
  final int projectId;
  final int studentId;
  final String coverLetter;
  final ProposalStatus statusFlag;
  final bool isDisable;
  final String userName;
  final StudentProfile studentProfile;
  final TechStackData techStackData;
  ProposalData(
      {required this.id,
      required this.projectId,
      required this.studentId,
      required this.studentProfile,
      required this.userName,
      required this.techStackData,
      this.coverLetter = "",
      this.statusFlag = ProposalStatus.none,
      this.isDisable = false});

  factory ProposalData.fromJson(Map<String, dynamic> json) {
    return ProposalData(
        id: json["id"],
        projectId: json["projectId"],
        studentId: json["studentId"],
        coverLetter: json["coverLetter"],
        studentProfile: StudentProfile.fromJson(json["student"]),
        statusFlag: ProposalData.intToStatus(json["statusFlag"]),
        userName: json["student"]["user"]["fullname"] ?? "",
        techStackData: TechStackData.fromJson(json["student"]["techStack"]));
  }
}

class ProjectData {
  final int id;
  final int companyId;
  final String title;
  final int numberOfStudent;
  final String description;
  final DateTime createdDate;
  final int monthTime;
  ProjectStatus status = ProjectStatus.none;
  int proposalCount = 0;
  int messageCount = 0;
  int hiredCount = 0;

  ProjectData(
      {required this.id,
      required this.companyId,
      required this.title,
      required this.monthTime,
      this.hiredCount = 0,
      this.messageCount = 0,
      this.proposalCount = 0,
      this.numberOfStudent = 5,
      this.description = "description",
      this.status = ProjectStatus.none,
      List<ProposalData>? proposals,
      DateTime? createdDate})
      : createdDate = createdDate ?? DateTime.now();

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
        id: json["id"],
        companyId: int.parse(json["companyId"].toString()),
        createdDate: DateTime.tryParse(json["createAt"] ?? ""),
        title: json["title"],
        description: json["description"],
        messageCount: json["countMessages"] ?? -1,
        proposalCount: json["countProposals"] ?? -1,
        hiredCount: json["countHired"] ?? -1,
        monthTime: switch (json["projectScopeFlag"] as int) { 0 => 3, _ => 6 },
        proposals: (json["proposals"] as List<dynamic>?)
            ?.map((e) => ProposalData.fromJson(e))
            .toList());
  }
}
