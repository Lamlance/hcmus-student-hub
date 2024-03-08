import 'package:flutter/material.dart';

class SkillSetDialog extends StatefulWidget {
  final List<String>? selectedSkillSet;
  final ValueSetter<List<String>>? onSkillSetSelect;

  SkillSetDialog({super.key, this.selectedSkillSet, this.onSkillSetSelect});
  @override
  State<StatefulWidget> createState() {
    return _SkillSetDialogState(
        selectedSkillSet: selectedSkillSet ?? List.empty(growable: true));
  }
}

class _SkillSetDialogState extends State<SkillSetDialog> {
  static const List<String> jobTitles = [
    "React",
    "Nodejs",
    "Angular",
    "Vue",
    "Go",
    "C#"
  ];

  List<String> selectedSkillSet;
  _SkillSetDialogState({required this.selectedSkillSet});

  CheckboxListTile _makeTitleCheckBox(String value) {
    return CheckboxListTile(
        title: Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
        value: selectedSkillSet.any((e) => e == value),
        onChanged: (isCheck) {
          setState(() {
            if (isCheck != null && isCheck) {
              selectedSkillSet.add(value);
            } else {
              selectedSkillSet.removeWhere((e) => e == value);
            }
            widget.onSkillSetSelect!(selectedSkillSet);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [...jobTitles.map((e) => _makeTitleCheckBox(e))],
        ),
      )),
    );
  }
}
