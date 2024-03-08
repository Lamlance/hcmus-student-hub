import 'package:boilerplate/presentation/profile/widgets/skillset_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SkillSet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SkillSetState();
  }
}

class _SkillSetState extends State<SkillSet> {
  List<String> _selectedSkillSet = [];

  void _showSkillSetDialog(BuildContext buildContext) {
    showDialog(
        context: buildContext,
        builder: ((context) => SkillSetDialog(
              selectedSkillSet: _selectedSkillSet,
              onSkillSetSelect: (v) => setState(() {
                _selectedSkillSet.replaceRange(0, _selectedSkillSet.length, v);
              }),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(color: Colors.white),
        constraints: BoxConstraints(
            minHeight: (16 * 3),
            minWidth: MediaQuery.of(context).size.width - (16 * 2)),
        child: Wrap(
          spacing: 24,
          runSpacing: 8,
          children: [
            ..._selectedSkillSet.map((e) => Container(
                  decoration: BoxDecoration(color: Colors.blue),
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Text(
                    e,
                    style: TextStyle(color: Colors.black),
                  ),
                ))
          ],
        ),
      ),
      onTap: () => _showSkillSetDialog(context),
    );
  }
}
