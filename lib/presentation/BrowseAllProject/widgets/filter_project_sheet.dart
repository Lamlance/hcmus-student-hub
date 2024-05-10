import 'package:boilerplate/core/stores/misc/misc_store.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/main.dart';
import 'package:boilerplate/constants/text.dart';
import 'package:provider/provider.dart';

class FilterData {
  final String? title;
  final int? duration;
  final int? numberOfStudent;

  FilterData({
    this.title,
    this.duration,
    this.numberOfStudent,
  });
}

class FilterProjectSheet extends StatefulWidget {
  final void Function(FilterData? filterData) onSubmit;
  const FilterProjectSheet({super.key, required this.onSubmit});

  @override
  State<StatefulWidget> createState() {
    return _FilterProjectSheetState();
  }
}

class _FilterProjectSheetState extends State<FilterProjectSheet> {
  int? _filterProjectScope;
  final _titleController = TextEditingController();
  final _numberOfStudentController = TextEditingController();
  final _miscStore = getIt<MiscStore>();

  void _handleFilterScopeSelect(int? value) {
    setState(() {
      _filterProjectScope = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 24,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            _miscStore.isEnglish
                ? AppStrings.filterProjects_en
                : AppStrings.filterProjects_vn,
          ),
          Divider(color: Colors.black),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: _miscStore.isEnglish
                  ? AppStrings.projectTitle_en
                  : AppStrings.projectTitle_vn,
              suffixIcon: IconButton(
                onPressed: () => _titleController.clear(),
                icon: Icon(Icons.clear),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          Divider(color: Colors.black),
          TextFormField(
            controller: _numberOfStudentController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: _miscStore.isEnglish
                  ? AppStrings.numberOfStudent_en
                  : AppStrings.numberOfStudent_vn,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              suffixIcon: IconButton(
                onPressed: () => _numberOfStudentController.clear(),
                icon: Icon(Icons.clear),
              ),
            ),
          ),
          Divider(color: Colors.black),
          Text(
            _miscStore.isEnglish
                ? AppStrings.projectDuration_en
                : AppStrings.projectDuration_vn,
          ),
          ListTile(
            onTap: () => _handleFilterScopeSelect(null),
            title: Text(
              _miscStore.isEnglish ? AppStrings.none_en : AppStrings.none_vn,
            ),
            leading: Radio<int?>(
              value: null,
              groupValue: _filterProjectScope,
              onChanged: _handleFilterScopeSelect,
            ),
          ),
          ListTile(
            onTap: () => _handleFilterScopeSelect(0),
            title: Text(
              _miscStore.isEnglish
                  ? AppStrings.oneToThreeMonth_en
                  : AppStrings.oneToThreeMonth_vn,
            ),
            leading: Radio<int?>(
              value: 0,
              groupValue: _filterProjectScope,
              onChanged: _handleFilterScopeSelect,
            ),
          ),
          ListTile(
            onTap: () => _handleFilterScopeSelect(1),
            title: Text(
              _miscStore.isEnglish
                  ? AppStrings.threeToSixMonth_en
                  : AppStrings.threeToSixMonth_vn,
            ),
            leading: Radio<int?>(
              value: 1,
              groupValue: _filterProjectScope,
              onChanged: _handleFilterScopeSelect,
            ),
          ),
          Divider(color: Colors.black),
          TextButton(
            onPressed: () {
              widget.onSubmit(
                FilterData(
                  duration: _filterProjectScope,
                  title: _titleController.text.isEmpty
                      ? null
                      : _titleController.text,
                  numberOfStudent:
                      int.tryParse(_numberOfStudentController.text),
                ),
              );
            },
            child: Text(
              _miscStore.isEnglish
                  ? AppStrings.submit_en
                  : AppStrings.submit_vn,
            ),
          ),
          Divider(color: Colors.black),
          TextButton(
            onPressed: () {
              widget.onSubmit(null);
            },
            child: Text(
              _miscStore.isEnglish
                  ? AppStrings.disableFilter_en
                  : AppStrings.disableFilter_vn,
              style: TextStyle(color: Colors.red),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20))
        ],
      ),
    );
  }
}
