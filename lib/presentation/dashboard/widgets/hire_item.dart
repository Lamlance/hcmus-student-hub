import 'package:boilerplate/core/stores/dashboard/dashboard_store.dart';
import 'package:boilerplate/presentation/dashboard/models/hire_model.dart';
import 'package:flutter/material.dart';

class HireItem extends StatelessWidget {
  final HireModel hireData;

  const HireItem({super.key, required this.hireData});

  @override
  Widget build(BuildContext context) {
    var hireButton = Expanded(
      flex: 1,
      child: TextButton(
        onPressed: () {},
        child: switch (hireData.hireStatus) {
          HireStatus.propose => Text("Sent hire offer"),
          HireStatus.sentHire => Text("Hire"),
          HireStatus.activePropose => Text("Hire"),
          HireStatus.hired => Text("Already hired")
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: 64),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(hireData.name),
              Text('${hireData.nthYear}(th) year student')
            ])
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(hireData.skill), Text(hireData.quality)],
        ),
        SizedBox(height: 16),
        Text(hireData.desc, maxLines: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: TextButton(
                onPressed: () {},
                child: const Text("Message"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
              ),
            ),
            hireButton
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Container(height: 2, color: Colors.grey),
        )
      ],
    );
  }
}
