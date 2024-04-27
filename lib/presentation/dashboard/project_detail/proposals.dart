import 'package:boilerplate/data/models/proposal_api_models.dart';
import 'package:boilerplate/presentation/dashboard/widgets/hire_item.dart';
import 'package:flutter/material.dart';

class ProjectProposalScreen extends StatefulWidget {
  final ProjectData projectData;
  final List<ProposalStatus>? filterHired;
  final List<ProposalData> proposals = [];
  ProjectProposalScreen(
      {super.key,
      this.filterHired,
      required this.projectData,
      List<ProposalData>? data}) {
    if (data != null) proposals.addAll(data);
  }

  @override
  State<StatefulWidget> createState() {
    return _ProjectProposalScreenState();
  }
}

class _ProjectProposalScreenState extends State<ProjectProposalScreen> {
  @override
  Widget build(BuildContext context) {
    var filtedData = widget.proposals.where((e) =>
        (widget.filterHired == null ||
            widget.filterHired!.contains(e.statusFlag)));

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 16),
          ...filtedData.map((e) => HireItem(hireData: e))
        ],
      ),
    );
  }
}
