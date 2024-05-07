import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/message_api_model.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';

class GetRTCTokenRespond {
  final String channelName;
  final String token;
  final int uid;
  GetRTCTokenRespond({
    required this.channelName,
    required this.token,
    required this.uid,
  });
}

class AgoraSerivce {
  final DioClient _dioClient;
  final UserStore _userStore;

  AgoraSerivce({
    required DioClient dioClient,
    required UserStore userStore,
  })  : _dioClient = dioClient,
        _userStore = userStore;

  void getRTCToken({
    required InterviewData interview,
    required void Function(Response<dynamic>? res, GetRTCTokenRespond? data)
        listener,
  }) {
    // final replaceLen = "${interview.id}".length;
    final uid = 0;
    // if (uid == null) {
    //   return listener(null, null);
    // }

    _dioClient.dio.post(
      '${Endpoints.agoraTokenUrl}/getToken',
      data: {
        "tokenType": "rtc",
        "channel": "${interview.id}_${interview.roomId}",
        "role": "subscriber", // "publisher" or "subscriber"
        "uid": "$uid",
        "expire": 3600,
      },
    ).then((v) {
      log("Get agora token: ${v.statusCode}");
      if (v.statusCode != 200) return listener(v, null);
      return listener(
        v,
        GetRTCTokenRespond(
          channelName: "${interview.id}_${interview.roomId}",
          token: v.data["token"],
          uid: uid,
        ),
      );
    });
  }
}
