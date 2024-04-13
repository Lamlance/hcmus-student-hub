import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';
export 'package:boilerplate/data/models/proposal_api_models.dart';

class ProposalService {
  final DioClient _dioClient;
  final UserStore _userStore;

  ProposalService({required DioClient dioClient, required UserStore userStore})
      : _dioClient = dioClient,
        _userStore = userStore;

  void createProposal({
    required CreateProposalRequest request,
    void Function(Response<dynamic>)? listener,
  }) {
    _dioClient.dio
        .post(Endpoints.createProposal,
            data: request,
            options: Options(
              headers: {"authorization": 'Bearer ${_userStore.token}'},
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
            ))
        .then((value) {
      if (listener != null) {
        listener(value);
      }
    });
  }

  void getProposalByProjectId(
      {required GetProposalByProjectIdRequest request,
      void Function(Response<dynamic> res, GetProposalByProjectIdRespond? data)?
          listener}) {
    _dioClient.dio
        .get(Endpoints.getPropsalByProjectId(request.projectId),
            options: Options(
              headers: {"authorization": 'Bearer ${_userStore.token}'},
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
            ))
        .then((value) {
      if (value.statusCode != 200) {
        if (listener != null) listener(value, null);
        return;
      }
      final proposalData =
          GetProposalByProjectIdRespond.fromJson(value.data["result"]);
      if (listener != null) listener(value, proposalData);
    });
  }
}
