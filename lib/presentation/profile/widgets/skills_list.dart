import 'dart:developer';

import 'package:boilerplate/presentation/profile/widgets/skill_set.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class SkillListDataModel {
  String? name;
  String? desc;
  DateTime? date1;
  DateTime? date2;
  List<String>? skillSet;
  SkillListDataModel(
      {this.name, this.date1, this.date2, this.desc, this.skillSet});
}

class SkillListArgs {
  String title;
  String? titleOfName;
  String? titleOfDesc;
  String? titleOfDate1;
  String? titleOfDate2;
  String? titleOfSkillSet;
  SkillListArgs(
      {this.title = "Title",
      this.titleOfDate1,
      this.titleOfDate2,
      this.titleOfName,
      this.titleOfDesc,
      this.titleOfSkillSet});
}

class SkillList extends StatefulWidget {
  final SkillListArgs args;
  final Widget Function(SkillListDataModel)? renderItems;
  final ValueSetter<List<SkillListDataModel>> onSkillChange;
  final List<SkillListDataModel> data;

  SkillList(
      {super.key,
      required this.args,
      this.renderItems,
      required this.data,
      required this.onSkillChange});

  @override
  State<StatefulWidget> createState() {
    return _SkillListState();
  }
}

class _SkillListState extends State<SkillList> {
  SkillListDataModel data = SkillListDataModel();

  Future<DateTime?> _showDateTime(BuildContext ctx) {
    return showDatePicker(
        context: ctx,
        firstDate: DateTime.fromMillisecondsSinceEpoch(0),
        lastDate: DateTime.now());
  }

  Dialog _buildAddWidget(
      BuildContext buildContext, void Function(void Function()) setState) {
    List<Widget> inputs = [];

    String titleOfName = widget.args.titleOfName ?? "";
    if (titleOfName.isNotEmpty) {
      inputs.add(TextFormField(
          onChanged: (value) => data.name = value,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
              filled: true,
              fillColor: Colors.white,
              labelText: titleOfName)));
      inputs.add(SizedBox(
        height: 16,
      ));
    }

    String titleOfDate1 = widget.args.titleOfDate1 ?? "";
    if (titleOfDate1.isNotEmpty) {
      inputs.add(InkWell(
          child: ListTile(
            title: Text(
                "$titleOfDate1: ${DateFormat("yyyy-MM-dd").format(data.date1 ?? DateTime.now())}"),
            trailing: IconButton(
              icon: Icon(Icons.calendar_month),
              onPressed: () =>
                  _showDateTime(buildContext).then((value) => setState(() {
                        data.date1 = value;
                      })),
            ),
          ),
          onTap: () => _showDateTime(buildContext).then((value) => setState(() {
                data.date1 = value;
              }))));
      inputs.add(SizedBox(
        height: 16,
      ));
    }

    String titleOfDate2 = widget.args.titleOfDate2 ?? "";
    if (titleOfDate2.isNotEmpty) {
      inputs.add(InkWell(
          child: ListTile(
            title: Text(
                "$titleOfDate2: ${DateFormat("yyyy-MM-dd").format(data.date2 ?? DateTime.now())}"),
            trailing: IconButton(
              icon: Icon(Icons.calendar_month),
              onPressed: () =>
                  _showDateTime(buildContext).then((value) => setState(() {
                        data.date2 = value;
                      })),
            ),
          ),
          onTap: () => _showDateTime(buildContext).then((value) => setState(() {
                data.date2 = value;
              }))));
      inputs.add(SizedBox(
        height: 16,
      ));
    }

    String titleOfDesc = widget.args.titleOfDesc ?? "";
    if (titleOfDesc.isNotEmpty) {
      inputs.add(TextFormField(
          onChanged: (value) => data.desc = value,
          minLines: 1,
          maxLines: 5,
          keyboardType: TextInputType.multiline,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black),
              hintStyle: TextStyle(color: Colors.black),
              filled: true,
              fillColor: Colors.white,
              labelText: titleOfDesc)));
      inputs.add(SizedBox(
        height: 16,
      ));
    }

    return Dialog(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...inputs,
            TextButton(
                onPressed: () {
                  widget.onSkillChange([...widget.data, data]);
                  data = SkillListDataModel();
                  Navigator.of(buildContext).pop();
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String titleOfSkill = widget.args.titleOfSkillSet ?? "";

    var items = widget.data
        .asMap()
        .map<int, Widget>((i, e) => MapEntry(
            i,
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: widget.renderItems == null
                          ? SizedBox()
                          : widget.renderItems!(e),
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              var newData = [...widget.data];
                              newData.removeAt(i);
                              widget.onSkillChange(newData);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    )
                  ],
                ),
                titleOfSkill.isNotEmpty
                    ? SkillSet(
                        onSkillSetsSelect: (skills) {},
                      )
                    : SizedBox(),
                SizedBox(height: 16)
              ],
            )))
        .values;

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.args.title),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => StatefulBuilder(
                            builder: (context, setState) =>
                                _buildAddWidget(context, setState)));
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          ...items
        ]);
  }
}
