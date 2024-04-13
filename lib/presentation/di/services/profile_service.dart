import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/profile_api_models.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';
export "package:boilerplate/data/models/profile_api_models.dart";

class ProfileService {
  final DioClient _dioClient;
  final UserStore _userStore;

  ProfileService({required DioClient dioClient, required UserStore userStore})
      : _dioClient = dioClient,
        _userStore = userStore;

  createCompanyProfile(
      {required CreateCompanyProfile profile,
      Function({Response<dynamic> response})? listener}) {
    _dioClient.dio
        .post(
      Endpoints.createCompany,
      data: profile,
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token}'},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    )
        .then((value) {
      if (value.statusCode == 200) {
        final companyProfile = CompanyProfile.fromJson(value.data["result"]);
        _userStore.updateCompany(companyProfile);
      }
      if (listener != null) listener(response: value);
    });
  }

  updateCompanyProfile(
      {required UpdateCompanyProfile profile,
      Function({Response<dynamic> response})? listener}) {
    _dioClient.dio
        .put(
      Endpoints.updateCompanyById(profile.companyId),
      data: profile,
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token}'},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    )
        .then((value) {
      if (value.statusCode == 200) {
        final companyProfile = CompanyProfile.fromJson(value.data["result"]);
        _userStore.updateCompany(companyProfile);
      }
      if (listener != null) listener(response: value);
    });
  }

  createStudentProfile(
      {required CreateStudentProfile profile,
      Function(Response<dynamic> response)? listener}) {
    _dioClient.dio
        .post(
      Endpoints.createStudent,
      data: profile,
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token}'},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    )
        .then((value) {
      if (value.statusCode == 200) {
        final studentProfile = StudentProfile.fromJson(value.data["result"]);
        _userStore.updateStudent(studentProfile);
      }
      if (listener != null) listener(value);
    });
  }
}
