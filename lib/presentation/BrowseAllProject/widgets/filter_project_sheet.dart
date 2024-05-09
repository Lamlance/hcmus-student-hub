import 'package:flutter/material.dart';

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
          Text("Filter projects"),
          Divider(color: Colors.black),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: "Project title",
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
              labelText: "Number of student",
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
          Text("Project duration"),
          ListTile(
            onTap: () => _handleFilterScopeSelect(null),
            title: const Text('None'),
            leading: Radio<int?>(
              value: null,
              groupValue: _filterProjectScope,
              onChanged: _handleFilterScopeSelect,
            ),
          ),
          ListTile(
            onTap: () => _handleFilterScopeSelect(0),
            title: const Text('1 to 3 month'),
            leading: Radio<int?>(
              value: 0,
              groupValue: _filterProjectScope,
              onChanged: _handleFilterScopeSelect,
            ),
          ),
          ListTile(
            onTap: () => _handleFilterScopeSelect(1),
            title: const Text('3 to 6 month'),
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
              child: Text("Submit")),
          Divider(color: Colors.black),
          TextButton(
            onPressed: () {
              widget.onSubmit(null);
            },
            child: Text(
              "Disable filter",
              style: TextStyle(color: Colors.red),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 20))
        ],
      ),
    );
  }
}
