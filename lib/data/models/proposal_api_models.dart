import 'project_models.dart';
export 'project_models.dart';

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
