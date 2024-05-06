import 'dart:developer';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:boilerplate/data/models/message_models.dart';
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
  bool muted = false;
  // RtcEngine? _engine;
  // AgoraRtmChannel? _channel;
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

  void _createClient() async {
    _client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "04f9320fa1e941a6a62ffcbade25beed",
        channelName: "demo-room",
        tempToken:
            "007eJxTYND73XJGxmKfIkPt41P6chZ/DhySm38+tSqq2VpMR6Y/3UyBwcAkzdLYyCAt0TDV0sQw0SzRzCgtLTkpMSXVyDQpNTVF96NFWkMgI4NofSwrIwMEgvicDCmpufm6Rfn5uQwMAHiLH74=",
      ),
    );
  }

  Future<void> _createChannels() async {
    // final instance =
    //     await AgoraRtmClient.createInstance("04f9320fa1e941a6a62ffcbade25beed");
    // await instance.createChannel(widget.interviewData.roomCode);
  }

  /*
  void _initEngine() async {
    _engine = createAgoraRtcEngine();
    _engine!.initialize(
      RtcEngineContext(
        appId: "04f9320fa1e941a6a62ffcbade25beed",
      ),
    );

    _engine!.registerEventHandler(RtcEngineEventHandler(
      onError: (type, code) {
        setState(() {
          final info = 'onError: $code';
          _infoStrings.add(info);
        });
      },
      onJoinChannelSuccess: (conn, elapsed) {
        setState(() {
          final info =
              'onJoinChannel: ${conn.channelId}, uid: ${conn.localUid}';
          _infoStrings.add(info);
        });
      },
      onLeaveChannel: (conn, stats) {
        setState(() {
          _infoStrings.add('onLeaveChannel');
          _users.clear();
        });
      },
      onUserJoined: (conn, uid, elapsed) {
        setState(() {
          final info = 'userJoined: $uid';
          _infoStrings.add(info);
          _users.add(uid);
        });
      },
      onUserOffline: (conn, uid, reason) {
        setState(() {
          final info = 'userOffline: $uid , reason: $reason';
          _infoStrings.add(info);
          _users.remove(uid);
        });
      },
      onFirstRemoteVideoFrame: (conn, uid, width, height, elapsed) {
        setState(() {
          final info = 'firstRemoteVideoFrame: $uid';
          _infoStrings.add(info);
        });
      },
    ));
  }
  */

  @override
  void initState() {
    super.initState();
    _handleGetPermission().then((isGranted) {
      log('Access granted: $isGranted');
    });
    _createClient();
    _createChannels().then((data) {
      log("Trying to initalize client");
      _client?.initialize();
    });
    //_initEngine();
  }

  @override
  void dispose() {
    // _channel?.leave();
    _client?.release();
    _users.clear();
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
          title: Text("Video call ${widget.interviewData.roomId}"),
        ),
        body: SafeArea(
          child: Stack(
            children: _client == null
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
