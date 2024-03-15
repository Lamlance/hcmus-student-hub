import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/presentation/dashboard/models/hire_model.dart';
import 'package:boilerplate/presentation/dashboard/widgets/hire_item.dart';
import 'package:flutter/material.dart';

class ProjectProposalScreen extends StatefulWidget {
  final List<HireStatus>? filterHired;

  const ProjectProposalScreen({super.key, this.filterHired});
  @override
  State<StatefulWidget> createState() {
    return _ProjectProposalScreenState();
  }
}

class _ProjectProposalScreenState extends State<ProjectProposalScreen> {
  static final List<HireModel> _saveData = [
    HireModel(name: "Do Van A", skill: "Junior Front-end"),
    HireModel(name: "Tran Thi B", skill: "Senior Backend-end"),
    HireModel(
        name: "Le Thanh C",
        skill: "Junior Backend-end",
        hireStatus: HireStatus.sentHire),
    HireModel(
        name: "Vu Phu D",
        skill: "Jnior data scientis",
        hireStatus: HireStatus.hired),
  ];
  @override
  Widget build(BuildContext context) {
    var filtedData = _saveData.where((e) => (widget.filterHired == null ||
        widget.filterHired!.contains(e.hireStatus)));

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
