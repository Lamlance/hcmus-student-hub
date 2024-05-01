import 'dart:developer';

import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/proposal_service.dart';
import 'package:boilerplate/presentation/di/services/socket_service.dart';
import 'package:flutter/material.dart';

class HireItem extends StatefulWidget {
  final ProposalData hireData;
  HireItem({super.key, required this.hireData});

  @override
  State<StatefulWidget> createState() {
    return _HireItemState();
  }
}

class _HireItemState extends State<HireItem> {
  final _chatService = getIt<SocketChatService>();
  final _proposalService = getIt<ProposalService>();

  void _handleSendMessage() {
    _chatService.sendMsg(
      content: "Hello can we chat about the project",
      receiveId: widget.hireData.studentId,
      projectId: widget.hireData.projectId,
    );
  }

  @override
  void initState() {
    super.initState();
    _chatService.connectToProject(widget.hireData.projectId, (data) {
      log(data?.content ?? "No content");
    });
  }

  @override
  void dispose() {
    super.dispose();
    _chatService.closeSocket();
  }

  @override
  Widget build(BuildContext context) {
    final hireButton = Expanded(
      flex: 1,
      child: TextButton(
        onPressed: widget.hireData.statusFlag == ProposalStatus.hired ||
                widget.hireData.statusFlag == ProposalStatus.hiredOfferSent
            ? null
            : () => _proposalService.updateProposal(
                  updateData: UpdateProposalByProposalId(
                    proposalId: widget.hireData.id,
                    statusFlag: ProposalStatus.hiredOfferSent,
                  ),
                ),
        child: switch (widget.hireData.statusFlag) {
          ProposalStatus.none => Text("Sent hire offer"),
          ProposalStatus.notHired => Text("Sent hire offer"),
          ProposalStatus.hiredOfferSent => Text("Waiting acception"),
          ProposalStatus.hired => Text("Already hired")
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: 64),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.hireData.userName),
            ])
          ],
        ),
        Text(widget.hireData.techStackData.name),
        SizedBox(height: 16),
        Text(widget.hireData.coverLetter, maxLines: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: _handleSendMessage,
                child: const Text("Message"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
              ),
            ),
            hireButton
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Container(height: 2, color: Colors.grey),
        )
      ],
    );
  }
}
