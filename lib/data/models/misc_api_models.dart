class TechStackData {
  final int id;
  final String name;
  TechStackData({required this.id, required this.name});

  factory TechStackData.fromJson(Map<String, dynamic> json) {
    return TechStackData(id: json["id"], name: json["name"]);
  }
}

class GetAllTechStackResponse {
  final List<TechStackData> response;
  GetAllTechStackResponse({required this.response});
  factory GetAllTechStackResponse.fromJson(Map<String, dynamic> json) {
    return GetAllTechStackResponse(
      response: (json["result"] as List<dynamic>)
          .map((e) => TechStackData.fromJson(e))
          .toList(),
    );
  }
}

class SkillSetData {
  final int id;
  final String name;
  SkillSetData({required this.id, required this.name});
  factory SkillSetData.fromJson(Map<String, dynamic> json) {
    return SkillSetData(id: json["id"], name: json["name"]);
  }
}

class GetAllSkillSetResponse {
  final List<SkillSetData> skillSets;
  GetAllSkillSetResponse({required this.skillSets});

  factory GetAllSkillSetResponse.fromJson(Map<String, dynamic> json) {
    return GetAllSkillSetResponse(
      skillSets: (json["result"] as List<dynamic>)
          .map((e) => SkillSetData.fromJson(e))
          .toList(),
    );
  }
}
