import 'package:boilerplate/data/models/misc_api_models.dart';
import 'package:flutter/material.dart';

class SkillSetDialog extends StatefulWidget {
  final List<SkillSetData> selectedSkillSet;
  final ValueSetter<List<SkillSetData>>? onSkillSetSelect;
  final List<SkillSetData> skillSets;

  SkillSetDialog(
      {super.key,
      List<SkillSetData>? selectedSkillSet,
      this.onSkillSetSelect,
      required this.skillSets})
      : selectedSkillSet = selectedSkillSet ?? [];
  @override
  State<StatefulWidget> createState() {
    return _SkillSetDialogState();
  }
}

class _SkillSetDialogState extends State<SkillSetDialog> {
  CheckboxListTile _makeTitleCheckBox(SkillSetData value) {
    return CheckboxListTile(
        title: Text(
          value.name,
          style: TextStyle(fontSize: 16),
        ),
        value: widget.selectedSkillSet.any((e) => e.id == value.id),
        onChanged: (isCheck) {
          setState(() {
            if (isCheck != null && isCheck) {
              widget.selectedSkillSet.add(value);
            } else {
              widget.selectedSkillSet.removeWhere((e) => e == value);
            }
            widget.onSkillSetSelect!(widget.selectedSkillSet);
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
          children: [...widget.skillSets.map((e) => _makeTitleCheckBox(e))],
        ),
      )),
    );
  }
}
