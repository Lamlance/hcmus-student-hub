import 'package:flutter/material.dart';

class StudentCVInputScreen extends StatefulWidget {
  final Function() onFinishInput;

  const StudentCVInputScreen({super.key, required this.onFinishInput});

  @override
  State<StatefulWidget> createState() {
    return _StudentCVInputScreenState();
  }
}

class _StudentCVInputScreenState extends State<StudentCVInputScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text("CV & Transcript"),
          SizedBox(
            height: 16,
          ),
          Text("Upload your CV"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ConstrainedBox(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(width: 4, color: Colors.black)),
              ),
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.35,
                  maxWidth: MediaQuery.of(context).size.width - (16 * 2)),
            ),
          ),
          Text("Transcript"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ConstrainedBox(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    border: Border.all(width: 4, color: Colors.black)),
              ),
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.35,
                  maxWidth: MediaQuery.of(context).size.width - (16 * 2)),
            ),
          ),
          SizedBox(height: 24),
          Align(
            child: TextButton(
              onPressed: () => widget.onFinishInput(),
              child: const Text("Finish"),
            ),
            alignment: Alignment.centerRight,
          )
        ],
      ),
    );
  }
}
