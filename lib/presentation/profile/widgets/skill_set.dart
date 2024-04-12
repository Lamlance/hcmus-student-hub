import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/di/services/misc_service.dart';
import 'package:boilerplate/presentation/profile/widgets/skillset_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SkillSet extends StatefulWidget {
  final void Function(List<SkillSetData> skills) onSkillSetsSelect;
  const SkillSet({super.key, required this.onSkillSetsSelect});

  @override
  State<StatefulWidget> createState() {
    return _SkillSetState();
  }
}

class _SkillSetState extends State<SkillSet> {
  final MiscService _miscService = getIt<MiscService>();
  GetAllSkillSetResponse? _skillSetResponse;

  final List<SkillSetData> _selectedSkillSet = [];
  void _showSkillSetDialog(BuildContext buildContext) {
    showDialog(
      context: buildContext,
      builder: (context) => SkillSetDialog(
        skillSets: _skillSetResponse?.skillSets ?? [],
        selectedSkillSet: _selectedSkillSet,
        onSkillSetSelect: (v) {
          setState(() {
            _selectedSkillSet.replaceRange(0, _selectedSkillSet.length, v);
          });
        },
      ),
    ).then((value) => widget.onSkillSetsSelect(_selectedSkillSet));
  }

  @override
  void initState() {
    super.initState();
    if (_skillSetResponse == null) {
      _miscService.getAllSkillSet(listener: (res, data) {
        setState(() {
          _skillSetResponse = data;
        });
      });
    }
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
            ..._selectedSkillSet.map(
              (e) => Container(
                decoration: BoxDecoration(color: Colors.blue),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(e.name, style: TextStyle(color: Colors.black)),
              ),
            )
          ],
        ),
      ),
      onTap: () => _showSkillSetDialog(context),
    );
  }
}
