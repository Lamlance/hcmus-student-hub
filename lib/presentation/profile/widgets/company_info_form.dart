import 'package:boilerplate/core/domain/model/user_data.dart';
import 'package:boilerplate/utils/validator/txt_validator.dart';
import 'package:flutter/material.dart';

class CompanyInfoForm extends StatefulWidget {
  final Function(CompanyProfile profile) onSubmit;

  const CompanyInfoForm({super.key, required this.onSubmit});

  @override
  State<StatefulWidget> createState() => _CompanyInfoFormState();
}

class _CompanyInfoFormState extends State<CompanyInfoForm> {
  static const EdgeInsets listTilePadding =
      EdgeInsets.symmetric(horizontal: 16);

  CompanySize? _companySize = CompanySize.only1;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  ListTile _makeEmployeeSizeRadio(String label, CompanySize companySize) {
    return ListTile(
      dense: true,
      onTap: () => _onCompanyRadioSelect(companySize),
      contentPadding: listTilePadding,
      title: Text(
        label,
        style: TextStyle(fontSize: 16),
      ),
      leading: Radio<CompanySize>(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: companySize,
        groupValue: _companySize,
        onChanged: _onCompanyRadioSelect,
      ),
    );
  }

  void _onCompanyRadioSelect(CompanySize? size) {
    setState(() {
      _companySize = size;
    });
  }

  _onFormClick() {
    if (_formKey.currentState!.validate() == false) return;

    widget.onSubmit(CompanyProfile(
        id: -1,
        companyName: _nameController.text,
        website: _websiteController.text,
        desc: _descController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Column(
              children: [
                const Text("How many people are in your company"),
                _makeEmployeeSizeRadio("Only me", CompanySize.only1),
                _makeEmployeeSizeRadio("2-9 employees", CompanySize.less9),
                _makeEmployeeSizeRadio("10-99 employees", CompanySize.less99),
                _makeEmployeeSizeRadio(
                    "100-10000 employees", CompanySize.less1000),
                _makeEmployeeSizeRadio(
                    "More than 1000 employees", CompanySize.more1000),
                SizedBox(
                  height: 12,
                ),
              ],
            ),
            TextFormField(
              validator: TextValidator.txtIsNotEmptyValidator,
              controller: _nameController,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Company name *",
                  hintText: "Your company's name"),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              validator: TextValidator.txtIsNotEmptyValidator,
              controller: _websiteController,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Company website *",
                  hintText: "Your company's website"),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              validator: TextValidator.txtIsNotEmptyValidator,
              controller: _descController,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: "Description",
                  hintText: "Your company description"),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
            ),
            SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: _onFormClick, child: const Text("Continue")),
            ),
          ],
        ));
  }
}
