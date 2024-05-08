import 'package:flutter/material.dart';
import 'bullet_widget.dart';
import 'styles.dart';

class S3PostAProjectPage extends StatefulWidget {
  final String projectName;
  final int numberOfStudent;
  final int projectDuration;
  final String projectDesc;
  final void Function(String desc) onSubmit;

  const S3PostAProjectPage({
    super.key,
    required this.projectName,
    required this.numberOfStudent,
    required this.projectDuration,
    required this.onSubmit,
    this.projectDesc = "",
  });
  @override
  State<StatefulWidget> createState() => _S3PostAProjectState();
}

class _S3PostAProjectState extends State<S3PostAProjectPage> {
  final _projectDescController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _handleNextPageClick() {
    if (_formKey.currentState!.validate() == false) return;
    widget.onSubmit(_projectDescController.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.projectDesc.isEmpty) return;
    setState(() {
      _projectDescController.text = widget.projectDesc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
