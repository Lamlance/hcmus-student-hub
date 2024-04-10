import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/models/misc_api_models.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';
export "package:boilerplate/data/models/misc_api_models.dart";

class MiscService {
  final DioClient _dioClient;
  MiscService({required DioClient dioClient}) : _dioClient = dioClient;

  getAllTechStack({
    required Function(Response<dynamic> response, GetAllTechStackResponse? data)
        listener,
  }) {
    _dioClient.dio.get(Endpoints.getAllTechStack).then((value) {
      return listener(
        value,
        value.statusCode != 200
            ? null
            : GetAllTechStackResponse.fromJson(value.data),
      );
    });
  }

  getAllSkillSet(
      {required Function(Response<dynamic>, GetAllSkillSetResponse? data)
          listener}) {
    _dioClient.dio.get(Endpoints.getAllSkillSet).then((value) {
      return listener(
        value,
        value.statusCode != 200
            ? null
            : GetAllSkillSetResponse.fromJson(value.data),
      );
    });
  }
}
