import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/presentation/dashboard/widgets/hire_item.dart';
import 'package:flutter/material.dart';

class ProjectProposalScreen extends StatefulWidget {
  final List<ProposalStatus>? filterHired;

  const ProjectProposalScreen({super.key, this.filterHired});
  @override
  State<StatefulWidget> createState() {
    return _ProjectProposalScreenState();
  }
}

class _ProjectProposalScreenState extends State<ProjectProposalScreen> {
  static final List<ProposalData> _saveData = [
    ProposalData(id: 1, projectId: 1, studentId: 1),
  ];
  @override
  Widget build(BuildContext context) {
    var filtedData = _saveData.where((e) => (widget.filterHired == null ||
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
