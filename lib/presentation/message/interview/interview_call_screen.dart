import 'dart:developer';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/data/models/message_models.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/agora_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class InterviewCallScreen extends StatefulWidget {
  final InterviewData interviewData;
  const InterviewCallScreen({super.key, required this.interviewData});
  @override
  State<StatefulWidget> createState() {
    return _InterviewCallScreenState();
  }
}

class _InterviewCallScreenState extends State<InterviewCallScreen> {
  static final _users = <int>[];
  final _agoraService = getIt<AgoraSerivce>();
  final _userStore = getIt<UserStore>();

  bool isInitalize = false;
  AgoraClient? _client;

  Future<bool> _handleGetPermission() async {
    var cameraStatus = (await Permission.camera.status).isGranted;
    if (cameraStatus == false) {
      cameraStatus = (await Permission.camera.request()).isGranted;
    }
    var micStatus = (await Permission.microphone.status).isGranted;
    if (micStatus == false) {
      micStatus = (await Permission.microphone.request()).isGranted;
    }

    return cameraStatus && micStatus;
  }

  void _createClient(String channel, String token, int? uid) {
    _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "04f9320fa1e941a6a62ffcbade25beed",
        uid: uid ?? 0,
        username: _userStore.selectedUser!.fullName,
        channelName: channel,
        tempToken: token,
        rtmEnabled: false,
      ),
      agoraEventHandlers: AgoraRtcEventHandlers(
        onError: ((err, msg) {
          log("Error $msg: $err");
        }),
        onConnectionStateChanged: (con, state, reason) {
          log("State change: $state + $reason");
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _handleGetPermission().then((isGranted) {
      log('Access granted: $isGranted');
      if (isGranted == false) return;
      _agoraService.getRTCToken(
        interview: widget.interviewData,
        listener: (res, data) {
          if (data == null) return;
          //log("Channel: ${data.channelName} ${data.token}");
          _createClient(data.channelName, data.token, data.uid);
          _client?.initialize().then((v) {
            setState(() {
              isInitalize = true;
            });
          });
        },
      );

      // _createClient(
      //     "1_1714387190546771",
      //     "007eJxSYJhp+lXB5WCScUbNgdOZLQsX/5n3t4IvYVvSu22uR3JT7YsVGAxM0iyNjQzSEg1TLU0ME80SzYzS0pKTElNSjUyTUlNTwr5apgnwMTBkM9SwMjJAIIgvxGAYb2huaGJsYW5oaWBqYmZubsjAAAgAAP//cdQhyA==",
      //     0);
      // _client?.initialize().then((v) {
      //   setState(() {
      //     isInitalize = true;
      //   });
      // });
    });

    //_initEngine();
  }

  @override
  void dispose() {
    // _channel?.leave();
    // _client?.release();
    // _users.clear();
    // _engine?.leaveChannel();
    // _engine?.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isInitalize
              ? "${_client!.agoraConnectionData.uid} - ${_client!.agoraConnectionData.channelName}"
              : "Video call ${widget.interviewData.roomId}"),
        ),
        body: SafeArea(
          child: Stack(
            children: isInitalize == false
                ? []
                : [
                    AgoraVideoViewer(
                      client: _client!,
                      layoutType: Layout.floating,
                      showNumberOfUsers: true,
                    ),
                    AgoraVideoButtons(
                      client: _client!,
                      enabledButtons: [
                        BuiltInButtons.toggleCamera,
                        BuiltInButtons.toggleMic,
                        BuiltInButtons.callEnd,
                      ],
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
