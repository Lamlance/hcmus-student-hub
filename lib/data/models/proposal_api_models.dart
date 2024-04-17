import 'package:boilerplate/core/domain/model/user_data.dart';

enum ProjectStatus { none, working, archive }

enum ProposalStatus { none, hired, hiredOfferSent, notHired }

class ProposalData {
  static ProposalStatus intToStatus(int status) {
    return switch (status) {
      1 => ProposalStatus.notHired,
      2 => ProposalStatus.hiredOfferSent,
      3 => ProposalStatus.hired,
      _ => ProposalStatus.notHired
    };
  }

  static int statusToInt(ProposalStatus status) {
    return switch (status) {
      ProposalStatus.notHired => 1,
      ProposalStatus.hiredOfferSent => 2,
      ProposalStatus.hired => 3,
      _ => 1
    };
  }

  final int id;
  final int projectId;
  final int studentId;
  final String coverLetter;
  final ProposalStatus statusFlag;
  final bool isDisable;

  final StudentProfile studentProfile;

  ProposalData(
      {required this.id,
      required this.projectId,
      required this.studentId,
      required this.studentProfile,
      this.coverLetter = "",
      this.statusFlag = ProposalStatus.notHired,
      this.isDisable = false});

  factory ProposalData.fromJson(Map<String, dynamic> json) {
    return ProposalData(
      id: json["id"],
      projectId: json["projectId"],
      studentId: json["studentId"],
      studentProfile: StudentProfile.fromJson(json["student"]),
      statusFlag: ProposalData.intToStatus(json["statusFlag"]),
    );
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

  int proposalCount = 3;
  int messageCount = 2;
  int hiredCount = 1;

  ProjectData(
      {required this.id,
      required this.companyId,
      required this.title,
      this.numberOfStudent = 5,
      this.description = "description",
      this.status = ProjectStatus.none,
      this.messageCount = 2,
      List<ProposalData>? proposals,
      DateTime? createdDate})
      : createdDate = createdDate ?? DateTime.now(),
        hiredCount = (proposals ?? [])
            .where((e) => e.statusFlag == ProposalStatus.hired)
            .length,
        proposalCount = (proposals ?? [])
            .where((e) => e.statusFlag == ProposalStatus.none)
            .length,
        monthTime = (createdDate?.difference(DateTime.now()).inDays ?? 0) ~/ 30;

  factory ProjectData.fromJson(Map<String, dynamic> json) {
    return ProjectData(
        id: json["id"],
        companyId: int.parse(json["companyId"].toString()),
        createdDate: DateTime.tryParse(json["createAt"] ?? ""),
        title: json["title"],
        description: json["description"]);
  }
}

class CreateProposalRequest {
  final int projectId;
  final int studentId;
  final String coverLetter;

  CreateProposalRequest(
      {required this.projectId,
      required this.studentId,
      required this.coverLetter});

  Map<String, dynamic> toJson() {
    return {
      "statusFlag": 1,
      "disableFlag": 0,
      "projectId": projectId,
      "studentId": studentId,
      "coverLetter": coverLetter,
    };
  }
}

class GetProposalByProjectIdRequest {
  final int projectId;
  final String? keyWord;
  final int offSet;
  final int limit;
  final int? statusFlag;

  GetProposalByProjectIdRequest(
      {required this.projectId,
      this.keyWord,
      this.offSet = 0,
      this.limit = 100,
      this.statusFlag});

  Map<String, String> toQueryObject() {
    final query = <String, String>{};

    if (keyWord != null) query["q"] = keyWord!;
    if (statusFlag != null) query["statusFlag"] = statusFlag!.toString();

    query["offset"] = offSet.toString();
    query["limit"] = limit.toString();

    return query;
  }
}

class GetProposalByProjectIdRespond {
  final bool hasNext;
  final List<ProposalData> proposals;
  GetProposalByProjectIdRespond(
      {required this.hasNext, required this.proposals});

  factory GetProposalByProjectIdRespond.fromJson(Map<String, dynamic> json) {
    return GetProposalByProjectIdRespond(
      hasNext: json["hasNext"].toString().toLowerCase() == "true",
      proposals: (json["items"] as List<dynamic>)
          .map((e) => ProposalData.fromJson(e))
          .toList(),
    );
  }
}

class UpdateProposalByProposalId {
  final int proposalId;
  final ProposalStatus statusFlag;
  UpdateProposalByProposalId({
    required this.proposalId,
    required this.statusFlag,
  });
  Map<String, dynamic> toJson() {
    return {"statusFlag": ProposalData.statusToInt(statusFlag)};
  }
}
