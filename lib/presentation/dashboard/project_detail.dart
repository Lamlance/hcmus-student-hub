import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/detail.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/proposals.dart';
import 'package:boilerplate/presentation/di/services/proposal_service.dart';
import 'package:flutter/material.dart';

class ProjectDetailScreen extends StatefulWidget {
  final ProjectData projectData;

  const ProjectDetailScreen({super.key, required this.projectData});
  @override
  State<StatefulWidget> createState() {
    return ProjectDetailScreenState();
  }
}

class ProjectDetailScreenState extends State<ProjectDetailScreen> {
  GetProposalByProjectIdRespond? proposals;
  final ProposalService _proposalService = getIt<ProposalService>();

  void _getProposal() {
    _proposalService.getProposalByProjectId(
      request: GetProposalByProjectIdRequest(projectId: widget.projectData.id),
      listener: (res, data) {
        setState(() {
          proposals = data;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (proposals == null) {
      _getProposal();
    }

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.projectData.title),
            bottom: TabBar(tabs: [
              Tab(text: "Proposal"),
              Tab(text: "Detail"),
              Tab(text: "Message"),
              Tab(text: "Hired")
            ]),
          ),
          body: TabBarView(children: [
            ProjectProposalScreen(
              projectData: widget.projectData,
              data: proposals?.proposals,
            ),
            ProjectDetailInfoScreen(projectData: widget.projectData),
            Text("Message"),
            ProjectProposalScreen(
              projectData: widget.projectData,
              filterHired: [ProposalStatus.hired],
            ),
          ]),
        ));
  }
}
