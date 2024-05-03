import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';
export 'package:boilerplate/data/models/proposal_api_models.dart';

typedef ResponseListener<T> = Function(Response<dynamic> res, T? data);

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

  void updateProposal({
    required UpdateProposalByProposalId updateData,
    void Function(Response<dynamic> res)? listener,
  }) {
    _dioClient.dio
        .patch(
      Endpoints.updateProposalByProposalId(updateData.proposalId),
      data: updateData,
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token}'},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    )
        .then((value) {
      if (listener != null) return listener(value);
    });
  }

  void getProposalByStudentId({
    ResponseListener<Iterable<GetProposalByStudentIdResponse>>? listener,
  }) {
    _dioClient.dio
        .get(
      Endpoints.getProposalByStudentId(_userStore.selectedUser!.student!.id),
      options: Options(
        headers: {"authorization": 'Bearer ${_userStore.token}'},
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        validateStatus: (status) => true,
      ),
    )
        .then((v) {
      if (v.statusCode != 200) {
        if (listener != null) listener(v, null);
        return;
      }
      if (listener != null) {
        listener(
          v,
          ((v.data["result"] ?? []) as List<dynamic>).map(
            (e) => GetProposalByStudentIdResponse.fromJson(e),
          ),
        );
      }
    });
  }
}
