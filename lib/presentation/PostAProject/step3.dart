import 'package:flutter/material.dart';
import 'bullet_widget.dart';
import 'styles.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/constants/text.dart';
import 'package:provider/provider.dart';

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
            Provider.of<LanguageProvider>(context).isEnglish
                ? AppStrings.step3Title_en
                : AppStrings.step3Title_vn,
            style: AppStyles.titleStyle,
          ),
          SizedBox(height: 20),
          Text(
            Provider.of<LanguageProvider>(context).isEnglish
                ? AppStrings.step3Desc_en
                : AppStrings.step3Desc_vn,
            style: AppStyles.normalTextStyle,
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
                //color: Constants.agreementBG,
                borderRadius: BorderRadius.circular(14)),
            child: SingleChildScrollView(
              child: BulletList([
                Provider.of<LanguageProvider>(context).isEnglish
                    ? AppStrings.clearExpectation_en
                    : AppStrings.clearExpectation_vn,
                Provider.of<LanguageProvider>(context).isEnglish
                    ? AppStrings.skillRequired_en
                    : AppStrings.skillRequired_vn,
                Provider.of<LanguageProvider>(context).isEnglish
                    ? AppStrings.detailProject_en
                    : AppStrings.detailProject_vn,
              ]),
            ),
          ),
          Text(
            Provider.of<LanguageProvider>(context).isEnglish
                ? AppStrings.describeProject_en
                : AppStrings.describeProject_vn,
            style: AppStyles.titleStyle,
          ),
          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: TextFormField(
              validator: (v) => v == null || v.isEmpty
                  ? Provider.of<LanguageProvider>(context).isEnglish
                      ? AppStrings.giveDescription_en
                      : AppStrings.giveDescription_vn
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
              child: Text(
                Provider.of<LanguageProvider>(context).isEnglish
                    ? AppStrings.review_en
                    : AppStrings.review_vn,
              ),
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
