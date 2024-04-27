import 'package:boilerplate/core/stores/user/user_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'step4.dart';
import 'bullet_widget.dart';
import 'styles.dart';

class S3PostAProjectPage extends StatefulWidget {
  final String projectName;
  final int numberOfStudent;
  final int projectDuration;
  const S3PostAProjectPage(
      {super.key,
      required this.projectName,
      required this.numberOfStudent,
      required this.projectDuration});
  @override
  State<StatefulWidget> createState() => _S3PostAProjectState();
}

class _S3PostAProjectState extends State<S3PostAProjectPage> {
  final _projectDescController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _handleNextPageClick() {
    if (_formKey.currentState!.validate() == false) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => S4PostAProjectPage(
          projectDuration: widget.projectDuration,
          projectName: widget.projectName,
          numberOfStudent: widget.numberOfStudent,
          projectDesc: _projectDescController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('StudentHub', style: TextStyle(fontSize: 20)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Routes.profile);
            },
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "3/4    Next, provide project description",
              style: AppStyles.titleStyle,
            ),
            SizedBox(height: 20),
            Text("Students are looking for:", style: AppStyles.normalTextStyle),
            Container(
              height: 150,
              decoration: BoxDecoration(
                  //color: Constants.agreementBG,
                  borderRadius: BorderRadius.circular(14)),
              child: SingleChildScrollView(
                child: BulletList([
                  'Clear expectation about your project or deliverables',
                  'The skills required for your project',
                  'Detail about your project',
                ]),
              ),
            ),
            Text(
              'Describe your project',
              style: AppStyles.titleStyle, // Use the title style
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (v) => v == null || v.isEmpty
                    ? "Please give some description"
                    : null,
                controller: _projectDescController,
                decoration: AppStyles.inputDecorationHeight,
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _handleNextPageClick,
                child: Text('Review'),
                style: AppStyles.elevatedButtonStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
            )
          ],
        ),
      ),
    );
  }
}
