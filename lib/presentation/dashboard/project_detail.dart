import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/presentation/dashboard/models/hire_model.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/detail.dart';
import 'package:boilerplate/presentation/dashboard/project_detail/proposals.dart';
import 'package:boilerplate/presentation/dashboard/widgets/hire_item.dart';
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
  static final List<HireModel> _saveData = [
    HireModel(name: "Do Van C", skill: "Junior Front-end"),
    HireModel(name: "Tran Thi A", skill: "Senior Backend-end")
  ];

  @override
  Widget build(BuildContext context) {
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
              ])),
          body: TabBarView(children: [
            ProjectProposalScreen(),
            ProjectDetailInfoScreen(projectData: widget.projectData),
            Text("Message"),
            ProjectProposalScreen(),
          ]),
        ));
  }
}
