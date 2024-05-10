import 'package:boilerplate/core/stores/misc/misc_store.dart';
import 'package:boilerplate/core/widgets/profile_icon_btn.dart';
import 'package:boilerplate/data/models/project_models.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/PostAProject/step3.dart';
import 'package:boilerplate/presentation/PostAProject/step4.dart';
import 'package:flutter/material.dart';
import 'step2.dart';
import 'styles.dart';
import 'package:boilerplate/constants/text.dart';

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
  final _miscStore = getIt<MiscStore>();

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
            _miscStore.isEnglish
                ? AppStrings.step1Title_en
                : AppStrings.step1Title_vn,
            style: AppStyles.titleStyle,
          ),
          SizedBox(height: 30),
          Text(
            _miscStore.isEnglish
                ? AppStrings.step1Desc_en
                : AppStrings.step1Desc_vn,
            style: AppStyles.normalTextStyle,
          ),
          SizedBox(height: 30),
          Form(
            key: _formKey,
            child: TextFormField(
              validator: (value) => value == null || value.isEmpty
                  ? _miscStore.isEnglish
                      ? AppStrings.step1Hint_en
                      : AppStrings.step1Hint_vn
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
            _miscStore.isEnglish
                ? AppStrings.exampleTitle_en
                : AppStrings.exampleTitle_vn,
            style: AppStyles.titleStyle,
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity, // Take up all available horizontal space
            child: RichText(
              text: AppStyles.bulletListStyle(
                  _miscStore.isEnglish
                      ? AppStrings.buildProject_en
                      : AppStrings.buildProject_vn,
                  AppStyles.normalTextStyle),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity, // Take up all available horizontal space
            child: RichText(
              text: AppStyles.bulletListStyle(
                  _miscStore.isEnglish
                      ? AppStrings.facebookAd_en
                      : AppStrings.facebookAd_vn,
                  AppStyles.normalTextStyle),
            ),
          ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _handleNextPageClick,
              child: Text(_miscStore.isEnglish
                  ? AppStrings.nextScope_en
                  : AppStrings.nextScope_vn),
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
