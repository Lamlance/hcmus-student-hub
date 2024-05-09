import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/detail.dart';
import 'package:boilerplate/presentation/dashboard/widgets/project_item.dart';
import 'package:boilerplate/presentation/di/services/proposal_service.dart';
import 'package:flutter/material.dart';

class DashBoardStudentScreen extends StatefulWidget {
  final ProjectStatus seletedStatus;

  const DashBoardStudentScreen({super.key, required this.seletedStatus});

  @override
  State<StatefulWidget> createState() {
    return _DashBoardStudentScreenState();
  }
}

class _DashBoardStudentScreenState extends State<DashBoardStudentScreen> {
  // final DashBoardStore _dashBoardStore = getIt<DashBoardStore>();
  final List<GetProposalByStudentIdResponse> _proposals = [];
  final _proposalService = getIt<ProposalService>();

  void _getPorposalByStudent() {
    _proposalService.getProposalByStudentId(listener: (res, data) {
      if (data == null) return;

      if (_proposals.isNotEmpty) {
        _proposals.removeRange(0, _proposals.length);
      }
      setState(() {
        _proposals.addAll(data);
      });
    });
  }

  void _toDetailScreen(ProjectData data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(
            title: Text(data.title),
          ),
          body: ProjectDetailInfoScreen(
            projectData: data,
          ),
        ),
      ),
    );
  }

  Iterable<Widget> _buildProjectItem() {
    return switch (widget.seletedStatus) {
      (ProjectStatus.working) => _proposals
          .where((p) => p.projectData.status == ProjectStatus.working)
          .map((e) => ProjectDetailInfoScreen(projectData: e.projectData)),
      (ProjectStatus.none) => [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Active proposal"),
                SizedBox(height: 16),
                ..._proposals
                    .where((e) =>
                        e.statusFlag == ProposalStatus.hiredOfferSent ||
                        e.statusFlag == ProposalStatus.active)
                    .map(
                      (e) => InkWell(
                        child: Column(
                          children: [
                            ProjectItem(
                              projectData: e.projectData,
                              displayNumber: false,
                              displayEndLine: false,
                            ),
                            TextButton(
                              onPressed: () => _toDetailScreen(e.projectData),
                              child: Text("View detail"),
                            ),
                            ...(e.statusFlag == ProposalStatus.hiredOfferSent
                                ? [
                                    TextButton(
                                      onPressed: () {
                                        _proposalService.updateProposal(
                                          updateData:
                                              UpdateProposalByProposalId(
                                            proposalId: e.id,
                                            statusFlag: ProposalStatus.hired,
                                          ),
                                        );
                                      },
                                      child: Text("Accept offer"),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8),
                                      child: Container(
                                          height: 2, color: Colors.grey),
                                    )
                                  ]
                                : []),
                            Divider(color: Colors.black)
                          ],
                        ),
                      ),
                    )
              ],
            ),
          ),
          SizedBox(height: 24),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Proposal"),
                SizedBox(height: 16),
                ..._proposals
                    .where((e) => e.statusFlag != ProposalStatus.hiredOfferSent)
                    .map(
                      (e) => Column(
                        children: [
                          ProjectItem(
                            projectData: e.projectData,
                            displayNumber: false,
                            displayEndLine: false,
                          ),
                          TextButton(
                            onPressed: () => _toDetailScreen(e.projectData),
                            child: Text("View detail"),
                          ),
                          Divider(color: Colors.black)
                        ],
                      ),
                    )
              ],
            ),
          )
        ],
      _ => [Text("Empty")]
    };
  }

  @override
  void initState() {
    super.initState();
    _getPorposalByStudent();
  }

  @override
  Widget build(BuildContext context) {
    var tabProjects = _buildProjectItem();
    return RefreshIndicator(
      onRefresh: () async {},
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [SizedBox(height: 16), ...tabProjects],
        ),
      ),
    );
  }
}
