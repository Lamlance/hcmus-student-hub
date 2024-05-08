import 'package:boilerplate/core/widgets/profile_icon_btn.dart';
import 'package:boilerplate/data/models/project_models.dart';
import 'package:boilerplate/presentation/PostAProject/step3.dart';
import 'package:boilerplate/presentation/PostAProject/step4.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'step2.dart';
import 'styles.dart';

class S1PostAProjectPage extends StatefulWidget {
  final ProjectData? projectData;
  const S1PostAProjectPage({super.key, this.projectData});
  @override
  State createState() => _S1PostAProjectState();
}

class _S1PostAProjectState extends State<S1PostAProjectPage>
    with TickerProviderStateMixin {
  final _txtNameController = TextEditingController();
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  int _numberOfStudent = 0;
  int _projectDuration = 0;
  String _projectDesc = "";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    if (widget.projectData != null) {
      setState(() {
        _txtNameController.text = widget.projectData!.title;
        _projectDuration = widget.projectData!.numberOfStudent == 0 ? 3 : 6;
        _numberOfStudent = widget.projectData!.numberOfStudent;
        _projectDesc = widget.projectData!.description;
      });
    }
  }

  void _handleNextPageClick() {
    if (_formKey.currentState!.validate() == false) return;
    _tabController.animateTo(1);
  }

  @override
  Widget build(BuildContext context) {
    final screen1 = SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "1/4    Let's start with a strong title",
            style: AppStyles.titleStyle,
          ),
          SizedBox(height: 30),
          Text(
            "This helps your post stand out to the right students. It's the first thing they'll see, so make it impressive!",
            style: AppStyles.normalTextStyle,
          ),
          SizedBox(height: 30),
          Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) => value == null || value.isEmpty
                  ? "Please insert project name"
                  : null,
              controller: _txtNameController,
              decoration: InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Example titles',
            style: AppStyles.titleStyle, // Use the title style
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity, // Take up all available horizontal space
            child: RichText(
              text: AppStyles.bulletListStyle(
                  '• Build responsive WordPress site with booking/payment functionality',
                  AppStyles.normalTextStyle),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity, // Take up all available horizontal space
            child: RichText(
              text: AppStyles.bulletListStyle(
                  'Facebook ad specialist need for product launch',
                  AppStyles.normalTextStyle),
            ),
          ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _handleNextPageClick,
              child: Text('Next: Scope'),
              style: AppStyles.elevatedButtonStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
          )
        ],
      ),
    );

    final screen2 = S2PostAProjectPage(
      projectName: _txtNameController.text,
      projectDuration: _projectDuration,
      numberOfStudent: _numberOfStudent,
      onSubmit: (duration, numOfStudent) {
        setState(() {
          _projectDuration = duration;
          _numberOfStudent = numOfStudent;
        });

        _tabController.animateTo(2);
      },
    );

    final screen3 = S3PostAProjectPage(
      projectName: _txtNameController.text,
      numberOfStudent: _numberOfStudent,
      projectDuration: _projectDuration,
      projectDesc: _projectDesc,
      onSubmit: (desc) {
        setState(() {
          _projectDesc = desc;
        });
        _tabController.animateTo(3);
      },
    );

    final screen4 = S4PostAProjectPage(
      projectName: _txtNameController.text,
      numberOfStudent: _numberOfStudent,
      projectDesc: _projectDesc,
      projectDuration: _projectDuration,
      projectData: widget.projectData,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('StudentHub'),
        actions: <Widget>[ProfileIconButton()],
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [screen1, screen2, screen3, screen4],
      ),
    );
  }
}
